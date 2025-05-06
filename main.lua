-- setting package path to minimize path shenanigans for Love
package.path = package.path .. ";content/?.lua"

local Player = require("player")
local modloader = require("modLoader")
local log = require("logSys")

local player

function love.load()
    player = Player.new(70, 70, nil)
    print("\x1b[2J\x1b[0m\x1b[H")
    log.info("Preparing to load mods...")
    local mods = modloader.loadAllMods("mods")

    for _, mod in ipairs(mods) do

        local entryPath = mod._modPath .. "/" .. mod.entrypoint
        if love.filesystem.getInfo(entryPath) then
            local chunk, err = love.filesystem.load(entryPath)
            if chunk then
                log.debug("Chunks for " .. mod.mod_id .. " loaded.")
                local success, runtimeErr = pcall(chunk)
                if not success then
                    log.error("Runtime error: " .. runtimeErr)
                end
            else
                -- load error
                log.error("Loading error: " .. err)
            end

            log.info(mod.name .. " has loaded.")

        else
            -- no entry error
            log.error("No entrypoint found in " .. mod.name .. ", mod is being skipped!")
        end
    end
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()

    -- reset colours b/c text rendering
    love.graphics.setColor(1.0, 1.0, 1.0)
    love.graphics.print("Neon Skies - 0.0.5d", 0, 0)
end