local server = require("http").server.new()
server.port = 8081
server:get("/", function()
    return "hello from default Astra instance! Version: " .. Astra.version
end)
print("Astra Server(Tokio/Rust) running on http://localhost:8081/")
server:run()