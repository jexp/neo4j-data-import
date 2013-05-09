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

@@id = 1
@@lookup = {}

def node(nodes,fields,offset=0) 
  return if (@@lookup[fields[0]])
  @@lookup[fields[0]]=@@id
  nodes.write("\t"*offset+fields.join("\t")+"\n")
  @@id=@@id+1
end

def rel(rels, fields) 
# uncomment for node-id based lookup
#  fields[0]=@@lookup[fields[0]]
#  fields[1]=@@lookup[fields[1]]
  rels.write(fields.join("\t")+"\n")
end

# node auto-index for movie_id, id, name, title, genre, type
def create_movie(nodes,rels,movie)
  id=clean(movie[:movie_id])
  node(nodes,[:movie_id, :title,:tagline,:released].collect{ |p| clean(movie[p]) })
end

def create_actors(nodes,rels,movie)
  id=clean(movie[:movie_id])
  movie[:actors].each do |a| 
    node(nodes,[a[:id],a[:name]],4)
    rel(rels,[a[:id],id,"ACTED_IN",clean(a[:role])])
  end
end

def create_directors(nodes,rels,movie)
  id=clean(movie[:movie_id])
  movie[:directors].each do |d| 
    node(nodes,[d[:id],d[:name]],4)
    rel(rels,[d[:id],id,"DIRECTED"])
  end
end

def create_genres(nodes,rels,movie)
  id=clean(movie[:movie_id])
  movie[:genres].each do |g|
    node(nodes,[g],6)
    rel(rels,[id,g,"GENRE"])
  end
end

nodes =  File.open("nodes.csv", "w")
nodes.write("movie_id\ttitle\ttagline\treleased\tid\tname\tgenre\n")
rels =  File.open("rels.csv", "w")
rels.write("start\tend\ttype\trole\n")


movies = [19995 , 194, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 13, 20526, 11, 1893, 1892, 
 1894, 168, 193, 200, 157, 152, 201, 154, 12155, 58, 285, 118, 22, 392, 5255, 568, 9800, 497, 101, 120, 121, 122].collect do |id|
   movie(id)
end

# only to have those sections in the CSV files
movies.each{ |m| create_movie(nodes,rels,m) }
movies.each{ |m| create_genres(nodes,rels,m) }
movies.each{ |m| create_actors(nodes,rels,m) }
movies.each{ |m| create_directors(nodes,rels,m) }

nodes.close()
rels.close()
