function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end


names = {"Peter", "Paul", "Mary"}
grades = {Mary = 10, Paul = 8, Peter = 6}

table.sort(names, function (n1, n2)
    return grades[n1] <= grades[n2]    -- compare the grades
end)
print(dump(grades))


