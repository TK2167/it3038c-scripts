var http = require("http");
var fs = require("fs");
var os = require("os");
var ip = require('ip');
var totalMemory = os.totalmem();
var totalMemoryinMB = totalMemory/(1024 * 1024);
var ut_sec = os.uptime();
var ut_min = ut_sec/60;
var ut_hour = ut_min/60;
var ut_day = ut_hour/24;
   
ut_sec = Math.floor(ut_sec);
ut_min = Math.floor(ut_min);
ut_hour = Math.floor(ut_hour);
ut_day = Math.floor(ut_day);
  
ut_day = ut_hour%24;
ut_hour = ut_hour%60;
ut_min = ut_min%60;
ut_sec = ut_sec%60;

http.createServer(function(req, res){

    if (req.url === "/") {
        fs.readFile("./public/index.html", "UTF-8", function(err, body){
        res.writeHead(200, {"Content-Type": "text/html"});
        res.end(body);
    });
}
    else if(req.url.match("/sysinfo")) {
        myHostName=os.hostname();
        cpuCount = os.cpus().length
        totalMemory = os.totalmem();
        freeMemory = os.freemem();
        upTime = os.uptime();
        html=`    
        <!DOCTYPE html>
        <html>
          <head>
            <title>Node JS Response</title>
          </head>
          <body>
            <p>Hostname: ${myHostName}</p>
            <p>IP: ${ip.address()}</p>
            <p>Server Uptime: ${ut_day} days, ${ut_hour} hours, ${ut_min} minutes, ${ut_sec} seconds </p>
            <p>Total Memory: ${totalMemory / (1024 * 1024)} MB </p>
            <p>Free Memory: ${freeMemory / (1024 * 1024)} MB </p>
            <p>Number of CPUs: ${cpuCount} </p>            
          </body>
        </html>` 
        res.writeHead(200, {"Content-Type": "text/html"});
        res.end(html);
    }
    else {
        res.writeHead(404, {"Content-Type": "text/plain"});
        res.end(`404 File Not Found at ${req.url}`);
    }
}).listen(3000);

console.log("Server listening on port 3000");