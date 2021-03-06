GITLOCALFOLDER=$1

echo "Create clean Neo4j Folder..."
rm -rf ./R.Neo4j
cp -r $GITLOCALFOLDER/R.Neo4j .

echo "Get the Import Program..."
cp -r $GITLOCALFOLDER/Import-XML/target/* .


echo "Get the crosswalks from github.."
curl https://raw.githubusercontent.com/researchgraph/Crosswalks/master/figshare.com/figshareRDF_to_researchgraph.xsl > ./crosswalk.xsl


mkdir ./versions
mkdir ./versions/figshare

JARFILE=import-xml-1.3.6.jar

#Switch one an off the VERBOSE output
VERBOSE=false #for production
#VERBOSE=true #for testing and debuging 

NOW="$(date +'%Y-%m-%d')"

SOURCE=monash.figshare
java -jar $JARFILE \
  -n ./R.Neo4j/ -s $SOURCE -f ./xml/figshare/rdf/$NOW/portal_21 \
  -C crosswalk.xsl -v ./versions -V "$VERBNOSE"