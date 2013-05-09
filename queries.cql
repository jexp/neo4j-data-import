# list all movies in the db by title and ordered

start movie=node:node_auto_index("title:*") 
return movie.title 
order by movie.title asc;

# find all Matrix Movies

start movie=node:node_auto_index("title:*Matrix*") 
return movie;

# only the node-id's and titles

start movie=node:node_auto_index("title:*Matrix*") 
return id(movie) as id, movie.title;

# all actors in the matrix movies

start movie=node:node_auto_index("title:*Matrix*") 
match movie<-[:ACTED_IN]-actor
return actor;

# now with aggregation

start movie=node:node_auto_index("title:*Matrix*") 
match movie<-[:ACTED_IN]-actor
return actor, count(*);

# all distinct actors

start movie=node:node_auto_index("title:*Matrix*") 
match movie<-[:ACTED_IN]-actor
return actor;

# find Keanu Reeves

start actor=node:node_auto_index(name="Keanu Reeves") 
return actor;

# all movies for Keanu Reeves

start actor=node:node_auto_index(name="Keanu Reeves") 
match movie<-[:ACTED_IN]-actor
return movie;

# all co-actor for Keanu Reeves

start actor=node:node_auto_index(name="Keanu Reeves") 
match coactor-[:ACTED_IN]->movie<-[:ACTED_IN]-actor
return distinct coactor.name as name
order by name asc;

# all the paths between Neo and Trinity

start actor1=node:node_auto_index(name="Kevin Bacon"), 
      actor2=node:node_auto_index(name="Carrie-Anne Moss") 
match p=allShortestPaths(actor1-[:ACTED_IN*]-actor2) 
return p;

# advanced collection functions

start actor1=node:node_auto_index(name="Keanu Reeves"), 
      actor2=node:node_auto_index(name="Johnny Depp") 
match p=allShortestPaths(actor1-[:ACTED_IN*]-actor2) 
return extract(n in nodes(p) : coalesce(n.title?, n.name?)), length(p);

# bacon path for Keanu Reeves (in our dataset)

start actor1=node:node_auto_index(name="Kevin Bacon"), 
      actor2=node:node_auto_index(name="Keanu Reeves") 
match p=shortestPath(actor1-[:ACTED_IN*]-actor2) 
return length(p) / 2;

