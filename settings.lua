delay = 0.01
unit = 24
width = 480
height = 520
white   = {r = 255,g = 255, b = 255}
green   = {r = 0,g = 255, b = 0}
red     = {r = 255,g = 0, b = 0}
score = 0
timer = 0
gameMode = 'play'
upSpace = 48

-- enemies
moveDelay = 100

function between(x,y,min,max)
    if x > min and y < max then
        return true
    end
    return false
end

function lose()
    love.load()
end