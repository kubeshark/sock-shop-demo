var http = require("https");

const ACCESS_TOKEN = "c798b14b83d519ffc531ef816cfce81e7d53367dbd5c4d3171a06ad888fabdaf"

function doRequests() {
    var options = {
        "method": "POST",
        "hostname": "gorest.co.in",
        "port": null,
        "path": "/public/v2/users",
        "headers": {
            "content-type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
            "authorization": `Bearer ${ACCESS_TOKEN}`,
            "cache-control": "no-cache",
            "x-powered-by": "nodejs"
        }
    };

    var req = http.request(options, function (res) {
        var chunks = [];

        res.on("data", function (chunk) {
            chunks.push(chunk);
        });

        res.on("end", function () {
            var body = Buffer.concat(chunks);
            console.log(body.toString());
        });
    });

    req.write("------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"email\"\r\n\r\njohn.doe@example.com\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"name\"\r\n\r\nJohn\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"gender\"\r\n\r\nmale\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"status\"\r\n\r\nactive\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW--");
    req.end();


    var options = {
        "method": "GET",
        "hostname": "gorest.co.in",
        "port": null,
        "path": "/public/v2/users",
        "headers": {
            "cache-control": "no-cache",
            "x-powered-by": "nodejs"
        }
    };

    var req = http.request(options, function (res) {
        var chunks = [];

        res.on("data", function (chunk) {
            chunks.push(chunk);
        });

        res.on("end", function () {
            var body = Buffer.concat(chunks);
            console.log(body.toString());
        });
    });

    req.end();


    var options = {
        "method": "GET",
        "hostname": "gorest.co.in",
        "port": null,
        "path": "/public/v2/posts",
        "headers": {
            "cache-control": "no-cache",
            "x-powered-by": "nodejs"
        }
    };

    var req = http.request(options, function (res) {
        var chunks = [];

        res.on("data", function (chunk) {
            chunks.push(chunk);
        });

        res.on("end", function () {
            var body = Buffer.concat(chunks);
            console.log(body.toString());
        });
    });

    req.end();

    setTimeout(doRequests, 3000);
}

doRequests();
