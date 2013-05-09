source env.sh
NEO4J_PATH="neo4j"
if [ ! -f init.cql ]; then
   echo "Creating init.cql"
   ruby import.rb $1 > init.cql 
fi
rm -rf cineasts.db
cat init.cql | ${NEO4J_PATH}/bin/neo4j-shell -path cineasts.db -config neo4j.properties
