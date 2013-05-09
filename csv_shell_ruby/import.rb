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
  movie = [:tagline,:released,:genres].reduce({:movie_id => id}) { |r, prop| r[prop] = res[prop.to_s] if res[prop.to_s].length>0; r }
  movie[:title] = res["name"]
  movie[:genres] = movie[:genres].collect { |g| g["name"] }
  movie[:actors] = res["cast"].find_all {|a| a["job"]=="Actor" } .collect { |g| { :id => g["id"], :name => clean(g["name"]) , :role => clean(g["character"]) }}
  movie[:directors] = res["cast"].find_all {|a| a["job"]=="Director" } .collect { |g| { :id => g["id"], :name => clean(g["name"]) }}
  movie
end

def setup
  "start root=node(0) 
   create unique 
   root-[:GENRES]->({type:'GENRES'}), 
   root-[:MOVIES]->({type:'MOVIES'}), 
   root-[:PEOPLE]->({type:'PEOPLE'});"
end

# node auto-index for movie_id, id, name, title, genre, type
def create_movie(movie)
#  puts movie.inspect
  props=[:movie_id, :title,:tagline,:released].find_all{ |p| movie[p] }.collect { |p| "#{p} : '#{clean(movie[p])}'" }.join(', ')
  actors = movie[:actors].collect { |a| "create unique movie<-[:ACTED_IN {role : '#{clean(a[:role])}'}]-({id : '#{a[:id]}', name: '#{a[:name]}'})-[:PERSON]->people "}.join(" \n") + "\n"
  directors = movie[:directors].collect { |a| "create unique movie<-[:DIRECTED]-({id : '#{a[:id]}', name: '#{a[:name]}'})-[:PERSON]->people "}.join(" \n") + "\n"
  genres = movie[:genres].collect { |g| "create unique movie-[:GENRE]->({genre : '#{g}'})-[:GENRE]->genres "}.join(" \n")
  " start root=node(0) 
   match
   root-[:GENRES]->genres, 
   root-[:MOVIES]->movies, 
   root-[:PEOPLE]->people 
   create movie={#{props}} 
   " + genres + actors + directors + ";"
end

puts "begin"
puts setup
[19995 , 194, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 13, 20526, 11, 1893, 1892, 
 1894, 168, 193, 200, 157, 152, 201, 154, 12155, 58, 285, 118, 22, 392, 5255, 568, 9800, 497, 101, 120, 121, 122].each do |id|
 puts create_movie(movie(id)) 
end
puts "commit"
