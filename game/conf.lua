require('settings')

function love.conf(t)
    t.title = 'LöVE: Space Invaders'
    t.version = 11.3
    t.console = false
    t.window.width = width
    t.window.height = height
    t.window.vsync = 0
    t.window.borderless = false
    t.window.icon = 'sprites/icon.png'
end