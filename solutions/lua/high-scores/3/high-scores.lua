local HighScores = {}

function HighScores:scores()
  return self._scores
end

function HighScores:latest()
  return self._scores[#self._scores]
end

function HighScores:sort_scores()
  sorted = {}
  for i=1, #self._scores do
    sorted[i] = self._scores[i]
  end

  table.sort(sorted, function(v1, v2) return v1 > v2 end)

  return sorted
end

function HighScores:personal_best()
  sorted = self:sort_scores()

  return sorted[1]
end

function HighScores:personal_top_three()
  sorted = self:sort_scores()

  return {table.unpack(sorted, 1, 3)}
end

return function(scores)
  local high_scores = {}
  setmetatable(high_scores, { __index = HighScores })

  high_scores._scores = scores

  return high_scores
end
