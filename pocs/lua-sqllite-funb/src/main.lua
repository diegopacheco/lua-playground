sqlite3 = require "luasql.sqlite3"

local env  = sqlite3.sqlite3()
local conn = env:connect('mydb.sqlite')
print(env,conn)

status,errorString = conn:execute([[CREATE TABLE sample ('id' INTEGER, 'name' TEXT)]])
print(status,errorString )

conn:execute([[INSERT INTO sample values('1','Lua')]])
conn:execute([[INSERT INTO sample values('2','LuaRocks')]])
conn:execute([[INSERT INTO sample values('3','Brazil')]])

cursor,errorString = conn:execute([[select * from sample]])
row = cursor:fetch ({}, "a")
while row do
   print(string.format("Id: %s, Name: %s", row.id, row.name))
   row = cursor:fetch (row, "a")
end