# Fedora Datastream AI

### To list datastream
* curl -i http://localhost:8080/fedora/objects/test:02/datastreams

* curl -i http://localhost:8080/fedora/objects/test:02/datastreams?format=xml

* invalid: curl -i http://localhost:8080/fedora/objects/test:02/datastreams.xml
    
### To obtain a datastream
* curl -i http://localhost:8080/fedora/objects/test:02/datastreams/DC

* curl -i http://localhost:8080/fedora/objects/test:02/datastreams/DS1

### To create create a new datastream
 
regular post (always creates inline (I) datastream.  Will fail if not valid XML):
* curl -i -H "Content-type: text/xml" -XPOST --data-binary @build.xml -u fedoraAdmin:fedoraAdmin "http://localhost:8080/fedora/objects/test:02/datastreams/DS1?dsLabel=A%20Test%20Datastream&altIDs=3333" 

"E" and "R" datastreams
* curl -i -H "Content-type: text/html" -XPOST "http://localhost:8080/fedora/objects/test:02/datastreams/REDIRECT?dsLabel=A%20Redirect%20Datastream&altIDs=3333&controlGroup=R&dsLocation=http://www.yourmediashelf.com" -u fedoraAdmin:fedoraAdmin

* curl -i -H "Content-type: text/html" -XPOST "http://localhost:8080/fedora/objects/test:02/datastreams/EXT?dsLabel=A%20Ext%20Datastream&altIDs=3333&controlGroup=E&dsLocation=http://www.yahoo.com" -u fedoraAdmin:fedoraAdmin   

multipart/form-data (always creates managed content (M) datastream):
* curl -i -H -XPOST -F file=@build.xml -u fedoraAdmin:fedoraAdmin "http://localhost:8080/fedora/objects/test:02/datastreams/DS3?dsLabel=hello&altIDs=3333" 

* curl -i -H -XPOST -F file=@dino.jpg -u fedoraAdmin:fedoraAdmin "http://localhost:8080/fedora/objects/test:02/datastreams/JPEG?dsLabel=hello&altIDs=3333" 

MIME Type is set according to Content Type Header:
* curl -i -H -XPOST -F "file=@01 Float On.m4a;type=audio/mp4a-latm"  -u fedoraAdmin:fedoraAdmin "http://localhost:8080/fedora/objects/test:02/datastreams/Float_On.m4a?dsLabel=hello&altIDs=3333" 

* curl -i -H -XPOST -F "file=@educause2004Fedora.ppt;type=application/vnd.ms-powerpoint"  -u fedoraAdmin:fedoraAdmin "http://localhost:8080/fedora/objects/test:02/datastreams/PPT.ppt?dsLabel=hello&altIDs=3333" 
 
mutipart/related is also supported but can only be tested with xform clients.
  
###  To update a datastream
* curl -i -H "Content-type: text/xml" -XPUT "http://localhost:8080/fedora/objects/test:02/datastreams/DS1?dsLabel=hello&altIDs=3333" --data-binary @build.xml -u fedoraAdmin:fedoraAdmin

* curl -i -H "Content-type: text/xml" -XPOST "http://localhost:8080/fedora/objects/test:02/datastreams/DS1?dsLabel=hello&altIDs=3333" --data-binary @build.xml -u fedoraAdmin:fedoraAdmin
  
### To delete a datastream 
* curl -i -XDELETE "http://localhost:8080/fedora/objects/test:02/datastreams/DS1" -u fedoraAdmin:fedoraAdmin

### More examples

* curl -i -H -XPOST -F file=@test/fixtures/minivan-in-minneapolis.jpg  -u fedoraAdmin:fedoraAdmin "http://localhost:8080/fedora/objects/test:test_xml_post/datastreams/FOO" 
 
* curl -i -XDELETE -u admin:muradora "http://localhost:9090/fedora/objects/test:test:test_object_1" 
 
* curl -i -H "Content-type: text/xml" -XPOST --data-binary @test/fixtures/mods-mskcc-filledsample.xml -u fedoraAdmin:fedoraAdmin "http://localhost:9090/fedora/objects/test:02/datastreams/DS1?dsLabel=A%20Test%20Datastream" 

* curl -i -H "Content-type: image/jpeg" -XPOST -F file=@test/fixtures/dino.jpg -u admin:muradora "http://localhost:9090/fedora/objects/test:02/datastreams/DINO?dsLabel=A%20Test%20Datastream"
