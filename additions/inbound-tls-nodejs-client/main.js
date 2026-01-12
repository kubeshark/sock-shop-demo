var http = require("https");

function doRequests() {
    var options = {
        "method": "GET",
        "hostname": "mizutest-inbound-tls-nodejs-server",
        "port": "8000",
        "path": "/",
        "headers": {
            "cache-control": "no-cache",
            "x-powered-by": "nodejs"
        }
    };

    process.env["NODE_TLS_REJECT_UNAUTHORIZED"] = 0;

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
