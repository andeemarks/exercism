local HighScores = {}

function HighScores:scores()
  return self._scores
end

function HighScores:latest()
  return self._scores[#self._scores]
end

function HighScores:personal_best()
  sorted = {}
  for i=1, #self._scores do
    sorted[i] = self._scores[i]
  end

  table.sort(sorted)

  return sorted[#sorted]
end

function HighScores:personal_top_three()
  sorted = {}
  for i=1, #self._scores do
    sorted[i] = self._scores[i]
  end

  table.sort(sorted)

  return {sorted[#sorted], sorted[#sorted - 1], sorted[#sorted - 2]}
end

return function(scores)
  local high_scores = {}
  setmetatable(high_scores, { __index = HighScores })

  high_scores._scores = scores

  return high_scores
end
