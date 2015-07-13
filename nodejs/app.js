var express = require('express');
var http = require('http');
var app = express();
app.set('port', process.env.PORT || 8080); // 绑定端口
app.use(express.static(__dirname)); // 默认首页目录

// 定义转发
var request = require('request');
// 转发portal请求到后端api服务器
var apiUrl = 'http://10.6.201.185';
app.use("/api/u/portal/*", function(req, res) {
  var url = apiUrl + req.originalUrl;
  // console.log(req);
  var method = req.method;
  if(method=="GET"){
    req.pipe(request(url)).pipe(res);
  } else {
    req.pip(request.post({url: url, formData: req.body})).pipe(res)
  }
  
  console.log("Redirect to " + apiUrl + ". Path: " + req.originalUrl);
});


// 创建、运行server
http.createServer(app).listen(app.get('port'), '0.0.0.0', function(){
  console.log('Express server listening on port ' + app.get('port'));
});