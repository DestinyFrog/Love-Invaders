function love.load()
    -- Requiring classes
    math.randomseed(os.time())
    require('settings')
    require('player')
    require('enemie')
    require('shot')

    -- loading sprites
    Explosion = love.graphics.newImage('sprites/explosion.png')
    ShotSprite = {}
        ShotSprite[1] = love.graphics.newImage('sprites/enemieShot1.png')
        ShotSprite[2] = love.graphics.newImage('sprites/enemieShot2.png')
    EnSprites = {}
        EnSprites[1] = love.graphics.newImage('sprites/enemy1.png')
        EnSprites[2] = love.graphics.newImage('sprites/enemy2.png')
        EnSprites[3] = love.graphics.newImage('sprites/enemy3.png')
    PlSprite = love.graphics.newImage('sprites/player.png')
    mainFont = love.graphics.newFont('FreePixel.ttf', 25)
    love.graphics.setFont(mainFont)

    local icon = love.image.newImageData('sprites/icon.png')
    love.window.setIcon(icon)

    -- Initializing classes
    player.load()
    shots = {}
    enemies = {}
    local sprOrder = {3,1,1,2,2}
    for j = 1, table.getn(sprOrder), 1 do
        for i = 1, (width - 196) / 18 - 1, 1 do
            table.insert(enemies,enemie_load(table.getn(enemies) + 1, sprOrder[j]))
            enemies[table.getn(enemies)].x = (i * unit + (unit/4 * i))
            enemies[table.getn(enemies)].y = (j * unit + (unit/4 * j)) + upSpace
        end
    end

    direction = -1
 end
function love.update()
    player.update()
    -- check if the player is out of screen
    if player.x < 0 or player.x > width then
        player.die()
     end
    
    -- update all available enemies
    for k,v in pairs(enemies) do
        v.update()
     end
    -- update all bullets, and destroy if is out of the screen
    for j = 1, table.getn(shots) do
        if shots[j].y > height then
            table.remove(shots,j)
            break
        end
        shots[j].update()
     end
    -- move all the enemies
    if timer <= moveDelay then
        timer = timer + 1
    else
        timer = 0
        
        local moveParam = {x = 0,y = 0}
        local lessValue = width/2
        local largValue = width/2
        local max = 24

        for k,n in pairs(enemies) do
            if n.x < lessValue then
                lessValue = n.x
            end
            if n.x > largValue then
                largValue = n.x
            end
        end


        if lessValue <= 12 and direction == -1 then
            direction = 1

            for j = 1, table.getn(enemies) do
                enemies[j].move({x = 0, y = unit/2})
            end
            goto jump
        elseif largValue >= width - max - 12 and direction == 1 then 
            direction = -1

            for j = 1, table.getn(enemies) do
                enemies[j].move({x = 0, y = unit/2})
            end
            goto jump
        end

        for j = 1, table.getn(enemies) do
            enemies[j].move({x = unit/2 * direction, y = 0})
        end
        ::jump::
    end

    love.timer.sleep(delay)
 end

function love.keypressed(key, scancode, isrepeat)
    if key == "right" then
       player.dir = 1
    end
    if key == "left" then
        player.dir = -1
    end

    if key == "space" and shotPl == 0 then
        player.shot()
    end
 end
function love.keyreleased(key, scancode, isrepeat)
    if key == 'left' or key == 'right' then
        player.dir = 0
    end
 end
function love.draw()
    love.graphics.setColor(green.r,green.g,green.b)
    love.graphics.line(0,player.y + 30,width,player.y + 30)

    love.graphics.print(tostring(score),0,0)
    -- draw player
    player.draw()

    -- draw enemies
    for j = 1, table.getn(enemies) do
        enemies[j].draw()
    end

    -- draw shots
    for j = 1, table.getn(shots) do
        shots[j].draw()
    end
 end