function shot_load(pos, player)
    require('settings')
    require('player')
    require('main')

    local shot = {}
        shot.player = player
        shot.x = pos.x
        shot.y = pos.y
        shot.width = 2
        shot.height = 12
        shot.color = white
        shot.dir = -1
        shot.speed = 7
        shot.spr = math.random(1,2)
        shot.side = 0
        shot.timer = 0

    if player == false then
        shot.dir = 1
        shot.speed = 2
        shot.width = 6
    end

    shot.update = function()
        shot.y = shot.y + (shot.dir * shot.speed)
    end

    shot.draw = function()
        -- love.graphics.setColor(250,0,0)
        -- love.graphics.rectangle("fill",shot.x,shot.y,shot.width,shot.height)

        -- love.graphics.setColor(250,0,0)
        -- love.graphics.arc("fill",shot.x,shot.y,5,0,360)

        love.graphics.setColor(shot.color.r,shot.color.g,shot.color.b)

        if shot.player == true then
            love.graphics.rectangle("fill",shot.x,shot.y,2,shot.height)
        else
            local q = love.graphics.newQuad(6 * shot.side,0,6,12,ShotSprite[shot.spr])
            love.graphics.draw(ShotSprite[shot.spr],q,shot.x,shot.y)
            if shot.timer >= 6 then 
                shot.timer = 0
                if shot.side == 1 then shot.side = 0 else shot.side = 1 end
            else
                shot.timer = shot.timer + 1
            end
        end
    end

    return shot
end