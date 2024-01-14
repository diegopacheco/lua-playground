mysql = require "luasql.mysql"

local env  = mysql.mysql()
local conn = env:connect('test','root','pass','127.0.0.1',3325)
print(env,conn)
print("connected to mysql.")

status,errorString = conn:execute([[CREATE TABLE IF NOT EXISTS sample2 (id INTEGER, name TEXT);]])
print(errorString)

conn:execute([[INSERT INTO sample2 values('1','Lua')]])
conn:execute([[INSERT INTO sample2 values('2','LuaRocks')]])
conn:execute([[INSERT INTO sample2 values('3','Brazil')]])

cur = conn:execute("select * from test.sample2")
row = cur:fetch ({}, "a")
while row do
  print(string.format("ID: %s, Name: %s", row.id, row.name))
  row = cur:fetch (row, "a")
end