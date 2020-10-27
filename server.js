const http = require("http");
const express = require('express');
const morgan = require('morgan');
const cors = require('cors');
const bodyParser = require('body-parser');
const fs = require("fs")
const app = express();
app.use(morgan('dev'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());

const SERVER_PORT = process.env.PORT || 9001;

var path = require('path');
var mime = require('mime');

app.get('/download', function(req, res){

  var file = __dirname + '/node-v12.19.0-x64';

  var filename = path.basename(file);
  var mimetype = mime.lookup(file);

  res.setHeader('Content-disposition', 'attachment; filename=' + filename);
  res.setHeader('Content-type', mimetype);

  var filestream = fs.createReadStream(file);
  filestream.pipe(res);
  
});


app.listen(SERVER_PORT, () => console.log('Express started at http://localhost:9001'));