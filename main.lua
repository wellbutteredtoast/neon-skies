-- setting package path to minimize path shenanigans for Love
package.path = package.path .. ";content/?.lua"

local Player = require("player")

local player

function love.load()
    player = Player.new(70, 70)
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()
    love.graphics.print("Hello, Lua!", 0, 0)
end