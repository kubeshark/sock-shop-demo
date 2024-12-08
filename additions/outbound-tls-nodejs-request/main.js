const request = require('request');

const ACCESS_TOKEN = "c798b14b83d519ffc531ef816cfce81e7d53367dbd5c4d3171a06ad888fabdaf"

function doRequests() {
    var formData = {
        email: 'john.doe@example.com',
        name: 'John',
        gender: 'male',
        status: 'active'
    };
    var headers = {
        "authorization": `Bearer ${ACCESS_TOKEN}`,
        "cache-control": "no-cache",
        "x-powered-by": "nodejs-request"
    }
    request.post({url:'https://gorest.co.in/public/v2/users', headers: headers, formData: formData}, function optionalCallback(err, httpResponse, body) {
        if (err) {
            return console.error('request failed:', err);
        }
        console.log('Server responded with:', httpResponse, body);
    });


    var headers = {
        "cache-control": "no-cache",
        "x-powered-by": "nodejs-request"
    }
    request.get({url:'https://gorest.co.in/public/v2/users', headers: headers}, function optionalCallback(err, httpResponse, body) {
        if (err) {
            return console.error('request failed:', err);
        }
        console.log('Server responded with:', httpResponse, body);
    });


    var headers = {
        "cache-control": "no-cache",
        "x-powered-by": "nodejs-request"
    }
    request.get({url:'https://gorest.co.in/public/v2/posts', headers: headers}, function optionalCallback(err, httpResponse, body) {
        if (err) {
            return console.error('request failed:', err);
        }
        console.log('Server responded with:', httpResponse, body);
    });

    setTimeout(doRequests, 3000);
}

doRequests();
