-- Not a validator in the traditional sense, this actually checks the scripts
-- found as the entrypoint for each mod for *banned functions* and methods.
-- Basically it's a really budget method of making sure that bad actors are
-- stopped in some capacity.

local modValidator = {}
local log = require("logSys")

local badFunctions = {
    "os.execute",
    "io.popen",
    "os.remove",
    "os.rename",
    "os.exit",
    "require%(%s*['\"]socket['\"]%)",
    "debug%.",
    "package%.loadlib",
    "%f[%a_]loadstring%f[^%a_]",
    "load%s*%(",
    "setfenv",
    "getfenv",
    "pcall%s*%(%s*require",
    "pcall%s*%(os",
    "dofile",
    "loadfile",
}

function modValidator.checkForBadFuncs(script, modPath)
    local found = {}
    for _, pattern in ipairs(badFunctions) do
        if string.match(script, pattern) then
            table.insert(found, pattern)
        end
    end
    if #found > 0 then
        return false, found
    end
    log.debug("Scripts for " .. modPath .. " are OK.")
    return true
end

function modValidator.deepScanModDir(modPath)
    local badFiles = {}

    local function scanDir(path)
        local items = love.filesystem.getDirectoryItems(path)
        for _, item in ipairs(items) do
            local fullPath = path .. "/" .. item
            if love.filesystem.getInfo(fullPath, "file") and item:match("%.lua$") then
                local content = love.filesystem.read(fullPath)
                if content then
                    local ok, reasons = modValidator.checkForBadFuncs(content, modPath)
                    if not ok then
                        badFiles[fullPath] = reasons
                    end
                end
            elseif love.filesystem.getInfo(fullPath, "directory") then
                scanDir(fullPath)
            end
        end
    end

    scanDir(modPath)
    return badFiles
end

return modValidator