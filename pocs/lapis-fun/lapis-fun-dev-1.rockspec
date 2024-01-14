rockspec_format = "3.0"
package = "lapis-fun"
version = "dev-1"
source = {
   url = "git+https://github.com/diegopacheco/lua-playground.git"
}
description = {
   homepage = "https://github.com/diegopacheco/lua-playground",
   license = "unlicesed"
}
build = {
   type = "builtin",
   modules = {
      main = "src/main.lua",
   }
}
test = {
   type = "command",
   command = "lua app.lua -o TAP"
 }
dependencies = {
   "lua >= 5.4",
   "luaunit >= 3.4",
   "lapis"
}
