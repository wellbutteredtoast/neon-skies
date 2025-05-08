local json = require("rxiJson")
local modLoader = {}
local modValidator = require("modValidator")
local log = require("logSys")

local function readFile(path)
    if not love.filesystem.getInfo(path) then
        return nil, "File not found: " .. path
    end
    local content, size = love.filesystem.read(path)
    if not content then
        return nil, "Failed to read file: " .. path
    end
    return content
end

-- validate required fields in mod manifest
local function validateManifest(manifest)
    local requiredFields = { "name", "mod_id", "entrypoint", "version", "api_ver" }
    for _, field in ipairs(requiredFields) do
        if not manifest[field] then
            return false, "Missing required field: " .. field
        end
    end
    return true
end

-- loading a single mod (just the json for now)
function modLoader.loadMod(modPath)
    local manifestPath = modPath .. "/manifest.json"
    local content, err = readFile(manifestPath)
    if not content then return nil, err end

    local manifest, decodeErr = json.decode(content)
    if not manifest then return nil, "JSON decode error: " .. decodeErr end

    local valid, valErr = validateManifest(manifest)
    if not valid then return nil, valErr end

    -- checks if stuff is bad, blocks if yes
    local badFiles = modValidator.deepScanModDir(modPath)
    if next(badFiles) ~= nil then
        local report = {}
        for file, reasons in pairs(badFiles) do
            table.insert(report, file .. " -> " .. table.concat(reasons, ", "))
        end
        local message = "Mod '" .. manifest.name .. "' contains blocked code:\n" ..
                        table.concat(report, "\n") ..
                        "\n\nPlease remove or clean the mod before trying again."
        love.window.showMessageBox("Fatal", message, "error")
        log.error("Potentally unsafe mod found, the game will not continue.")
        error(message)
    end
    

    manifest._modPath = modPath
    return manifest
end

-- exposed func to check the full mods dir and loads mods sequencially
function modLoader.loadAllMods(modsDir)
    local mods = {}

    for _, file in ipairs(love.filesystem.getDirectoryItems(modsDir)) do
        local modPath = modsDir .. "/" .. file
        if love.filesystem.getInfo(modPath, "directory") then
            local mod, err = modLoader.loadMod(modPath)
            if mod then
                table.insert(mods, mod)
            else
                print("Failed to load mod '" .. file .. "': " .. err)
            end
        end
    end

    return mods
end

return modLoader