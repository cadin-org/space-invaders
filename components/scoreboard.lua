local score = {}

function score.draw(spaceship)
  love.graphics.print('Score: ' .. spaceship.score, 10, 10)
end

return score
