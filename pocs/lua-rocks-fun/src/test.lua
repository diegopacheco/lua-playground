local lu = require("luaunit")
local fac = require("src/fac")

function Test1()
  result = fac(3)
  print("Factorial result is: "..result)
  lu.assertEquals(6,result)
end

os.exit(lu.LuaUnit.run())