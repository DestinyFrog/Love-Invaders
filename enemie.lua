-- enemies factory
require('settings')
require('player')
require('main')

function enemie_load(index,spr)
    local enemie = {}
    enemie.index = index
    enemie.x = 0
    enemie.y = 0
    enemie.color = white
    enemie.radius = unit
    enemie.spr = spr
    enemie.sprite = EnSprites[spr]
    enemie.timer = 0
    enemie.shotTime = math.random(250, 1200)
    enemie.animaTimer = 0
    enemie.firstSpr = false

    enemie.dead = false
    enemie.deadTimer = 0

    enemie.update = function()
        local v = shotPl

        if enemie.dead == true then
        if enemie.deadTimer >= 50 then
            for k,v in pairs(enemies) do
                if v.index > enemie.index then
                    v.index = v.index - 1
                end
            end
            table.remove(enemies,enemie.index)
            score = score + (10 * enemie.spr)
            moveDelay = moveDelay - 1.3
            return
        else
            enemie.deadTimer = enemie.deadTimer + 1
        end
        end

        if enemie.timer == enemie.shotTime then
            table.insert(shots,shot_load({x = enemie.x + enemie.radius/2, y = enemie.y}, false))
            enemie.shotTime = math.random(1100, 1200)
            enemie.timer = 0
        else
            enemie.timer = enemie.timer + 1
        end

        if shotPl == 0 or enemie.dead == true then
            return
        end

        if v.y < enemie.y + enemie.radius and v.y + v.height > enemie.y then
            if v.x + v.width > enemie.x and v.x < enemie.x + enemie.radius then
                enemie.dead = true
                shotPl = 0
            end
        end
    end

    enemie.move = function(distance)
        enemie.x = enemie.x + distance.x
        enemie.y = enemie.y + distance.y
        enemie.firstSpr = not enemie.firstSpr
    end

    enemie.draw = function()
        love.graphics.setColor(enemie.color.r,enemie.color.g,enemie.color.b)
        if enemie.dead == true then
            love.graphics.draw(Explosion,enemie.x,enemie.y)
            return
        end

        local t = 0
        if enemie.firstSpr == false then t = 24 end
        local spr = love.graphics.newQuad(t,0,24,24,enemie.sprite)
        love.graphics.draw(enemie.sprite,spr,enemie.x,enemie.y)
    end

    return enemie
end