rockspec_format = "3.0"
package = "lua-rocks-fun"
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
   command = "lua src/test.lua -o TAP"
 }
dependencies = {
   "lua >= 5.4",
   "lua-cjson >= 2.1",
   "luaunit >= 3.4"
}