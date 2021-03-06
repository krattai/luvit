local http = require("http")

require('tap')(function(test)
  test('http stream end', function(expect)
    local server
    server = http.createServer(function (req, res)
      local body = "Hello world\n"
      res:on("finish", expect(function() end))
      res:writeHead(200, {
        ["Content-Type"] = "text/plain",
        ["Content-Length"] = #body
      })
      res:finish(body)
    end):listen(8080)
    http.get('http://127.0.0.1:8080', expect(function()
      server:close()
    end))
  end)
end)
