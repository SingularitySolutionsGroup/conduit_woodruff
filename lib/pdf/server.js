var express = require('express');
var sh = require('execSync');
var uuid = require('node-uuid');
var app = express();

app.configure(function(){
  app.use('/pdfs', express.static(__dirname + '/pdfs'));
  app.use(express.bodyParser());
});

app.post('/pdf', function(req, res){
  var document_url = req.body.document_url;
  var footer_url   = req.body.footer_url;
  var local_file   = "pdfs/" + uuid.v4() + ".pdf";

  var command = 'phantomjs --ignore-ssl-errors=yes stampPdf.js "' + document_url + '" "' + footer_url + '" "' + local_file + '"';
  console.log(command);
  sh.exec(command);

  res.send( { filename: local_file } );
});

var port = 3001;
app.listen(port);
console.log('Listening on port ' + port);
