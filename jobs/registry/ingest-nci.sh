RNEO4J=$1
MNTDATA=$2

echo "Create clean Neo4j Folder..."
rm -rf $MNTDATA/nci/R.Neo4j
mkdir $MNTDATA/nci/R.Neo4j
cp -r $RNEO4J/. $MNTDATA/nci/R.Neo4j

rm -rf csv
mkdir csv
echo "Download CSV files..."
curl https://raw.githubusercontent.com/researchgraph/nci/master/csv/datasets.csv > ./csv/datasets.csv
curl https://raw.githubusercontent.com/researchgraph/nci/master/csv/researchers.csv > ./csv/researchers.csv
curl https://raw.githubusercontent.com/researchgraph/nci/master/csv/publications.csv > ./csv/publications.csv
curl https://raw.githubusercontent.com/researchgraph/nci/master/csv/relations.csv > ./csv/relations.csv

echo "Building Neo4j ... "
$MNTDATA/nci/R.Neo4j/bin/neo4j-import --into $MNTDATA/nci/R.Neo4j/data/databases/graph.db \
  --nodes ./csv/datasets.csv \
  --nodes ./csv/researchers.csv \
  --nodes ./csv/publications.csv \
  --relationships ./csv/relations.csv \
  --ignore-empty-strings true

echo "Invalid relationships"
cat $MNTDATA/nci/R.Neo4j/data/databases/graph.db/bad.log

 # --nodes ./csv/datasets.csv \
#sudo zip "r-neo4j-nci.zip" ./R.Neo4j
#aws s3 --region eu-west-2 cp "r-neo4j-nci.zip"  s3://nci.registry.researchgraph/neo4j/
