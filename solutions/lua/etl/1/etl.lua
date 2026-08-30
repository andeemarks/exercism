
local function prettyPrint(t, indentLevel)
    indentLevel = indentLevel or 0
    local indent = string.rep("  ", indentLevel) -- Adjust indentation as needed

    if type(t) ~= "table" then
        print(t)
        return
    end

    print(indent .. "{")
    for k, v in pairs(t) do
        io.write(indent .. "  [" .. tostring(k) .. "] = ")
        if type(v) == "table" then
            prettyPrint(v, indentLevel + 1)
        else
            print(tostring(v) .. ",")
        end
    end
    print(indent .. "},")
end

return {
  transform = function(dataset) 
    new = {}
    for k, v in pairs(dataset) do 
      for k2, v2 in pairs(v) do 
        new[string.lower(v2)] = k
      end
    end

    return new
  end
}
