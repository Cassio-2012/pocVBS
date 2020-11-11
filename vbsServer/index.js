
const express = require('express');
const morgan = require('morgan');
const cors = require('cors');
const bodyParser = require('body-parser');
const app = express();
app.use(morgan('dev'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());

// process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = '0';

  
app.post('/data', function(req, res, params){
  
  var body = '';
  req.on('data', function (data) {
      body += data;
  });
  req.on('end', function () {
      console.log(body)     
  });

  return res.send('[+] END')

});

app.listen(9001, () => console.log('Express started at http://localhost:9001'));
