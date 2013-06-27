subject matches '.*business.*'

register ./myudfs.jar

-- load the test file into Pig
--raw = LOAD 'cse344-test-file' USING TextLoader as (line:chararray);
-- later you will load to other files, example:
--btc-2010-chunk-000
raw = LOAD 'btc-2010-chunk-000' USING TextLoader as (line:chararray); 

-- parse each line into ntriples
ntriples = foreach raw generate FLATTEN(myudfs.RDFSplit3(line)) as (subject:chararray,predicate:chararray,object:chararray);

ntriplesF = FILTER ntriples by subject matches '.*business.*';

ntriples2 = foreach raw generate FLATTEN(myudfs.RDFSplit3(line)) as (subject2:chararray,predicate2:chararray,object2:chararray);

ntriplesF2 = FILTER ntriples2 by subject2 matches '.*business.*';

joinResult = join ntriplesF by object, ntriplesF2 by subject2; 

--group the n-triples by object column
joinResultD = DISTINCT joinResult;

grouper = GROUP joinResultD ALL;

joinCount = foreach grouper GENERATE COUNT(joinResultD);


-- store the results in the folder /user/hadoop/example-results
store joinCount into './rejoin3' using PigStorage();