require('settings')
require('shot')
player = {}
shotPl = 0

function player:load()
    player.x = width/2
    player.y = height - 60
    player.radius = unit
    player.color = green
    player.dir = 0
    player.speed = 1.5
    player.sprite = PlSprite
    player.lifes = 3
end

function player:update()
    player.x = player.x + (player.dir * player.speed)

    for k,v in pairs(shots) do
        if v.y + v.height > player.y and v.y < player.y + unit then
            if v.x + v.width > player.x - player.radius and v.x < player.x then
                player.die()
            end
        end
    end
    
    if shotPl ~= 0 then
        if shotPl.y <= 0 then
            shotPl = 0
            return
        end
        shotPl.update()
    end
end

function player:die()
    if player.lifes <= 0 then
        lose()
    else
        player.lifes = player.lifes - 1
    end
end

function player:draw()
    -- love.graphics.setColor(250,0,0)
    -- love.graphics.rectangle("fill",player.x - player.radius,player.y,player.radius,unit)

    love.graphics.setColor(player.color.r,player.color.g,player.color.b)
    love.graphics.draw(player.sprite,player.x - player.radius,player.y)

    if shotPl ~= 0 then
        shotPl.draw()
    end
end

function player:shot()
    if shotPl == 0 then
        shotPl = shot_load({x = player.x, y = player.y}, true)
    end
end