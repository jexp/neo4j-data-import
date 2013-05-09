require 'rubygems'
require 'rest-client'
require 'json'

URL = "http://api.themoviedb.org/2.1"
KEY = ARGV[0] || ENV["API_KEY"]

def get(type,id)
  res = RestClient.get "#{URL}/#{type}.getInfo/en/json/#{KEY}/#{id}"
  JSON.parse(res.to_str)
end

def person(id) 
  get("Person",id)
end

def clean(name) 
  name.to_s.gsub(/['"]/,"")
end

def movie(id)
  res = get("Movie",id).first
  movie = [:tagline,:released,:genres].reduce({:id => id}) { |r, prop| r[prop] = res[prop.to_s] if res[prop.to_s].length>0; r }
  movie[:year] = res["released"]
  movie[:title] = res["name"]
  movie[:genres] = movie[:genres].collect { |g| g["name"] }
  movie[:actors] = res["cast"].find_all {|a| a["job"]=="Actor" } .collect { |g| { :id => g["id"], :name => clean(g["name"]) , :role => clean(g["character"]) }}
  movie[:directors] = res["cast"].find_all {|a| a["job"]=="Director" } .collect { |g| { :id => g["id"], :name => clean(g["name"]) }}
  movie
end

def create_actor(name)
  "start n=node:node_auto_index(name='#{name}') 
   with count(*) as c 
   where c=0 
   create x={name:'#{name}'};"
end

def create_role(id,name,role)
  "start movie=node:node_auto_index(id='#{id}'),
         actor=node:node_auto_index(name='#{name}')
   movie<-[:ACTED_IN {role : '#{clean(role)}'}]-actor;"
end

# node auto-index for id, id, name, title, genre, type
def create_movie(movie)
#  puts movie.inspect
  props=[:id, :title,:year].find_all{ |p| movie[p] }.collect { |p| "#{p} : '#{clean(movie[p])}'" }.join(', ')
  few_actors = movie[:actors].find_all { |a| ["Keanu Reeves", "Laurence Fishburne", "Carrie-Anne Moss"].member? a[:name] }
  actors = few_actors.collect { |a| create_actor(a[:name])}.join(" \n") + "\n"
  roles = few_actors.collect { |a| create_role(movie[:id], a[:name],a[:role]) }.join(" \n") + "\n"
  "create movie={#{props}};\n" + actors + roles
end

puts "begin"
[603, 604,605].each do |id|
 puts create_movie(movie(id)) 
end
puts "commit"
