///HTTP request
//https://nodejs.org/api/http.html

const http = require('http');

//HTTP client GET request

//Activity
//Factory Reset: 67110912           //Administrator
//Monitoring RTDX: 83886082         //Technician 


var request = http.request('http://172.31.250.1/api/auth/authorizer?activity=83886082',{'auth': 'Chantal:Chantal8*'}, (res) => {
  if (res.statusCode !== 200) {
    console.error(`Did not get an OK from the server. Code: ${res.statusCode}`);
    res.resume();
    return;
  }
  else{
    console.log(`Success: Code: ${res.statusCode}`);
    res.resume();
    return;
  }
});

request.end();
