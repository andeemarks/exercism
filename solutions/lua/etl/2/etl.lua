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
