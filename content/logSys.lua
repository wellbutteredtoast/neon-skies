local logger = {}

-- ANSI color codes
local colors = {
    reset = "\27[0m",
    info  = "\27[36m",  -- Cyan-ish
    warn  = "\27[33m",  -- Yellow
    error = "\27[31m",  -- Red
    debug = "\27[90m",  -- Gray
}

local logFileName = nil
local logFile = nil

local function getTimestampForFilename()
    return os.date("%Y-%m-%d_%H-%M-%S")
end

local function init()
    -- Open the log file directly in append mode
    local timestamp = getTimestampForFilename()
    logFileName = "logs_" .. timestamp .. ".log"
    logFile = love.filesystem.newFile(logFileName)
    if logFile then
        local success = logFile:open("a")
        if not success then
            print("[LOGGER] Failed to open log file: " .. logFileName)
            logFile = nil
        end
    else
        print("[LOGGER] Failed to create log file: " .. logFileName)
    end
end

local function format(tag, msg)
    return string.format("[%s] %s", tag:upper(), msg)
end

local function write(tag, msg)
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    local line = string.format("[%s] [%s] %s\n", timestamp, tag:upper(), msg)

    -- Console with color
    local color = colors[tag] or colors.info
    io.write(color .. line .. colors.reset)

    -- Log file
    if logFile then
        logFile:write(line)
        logFile:flush()
    end
end

-- Public methods
function logger.info(msg)
    write("info", msg)
end

function logger.warn(msg)
    write("warn", msg)
end

function logger.error(msg)
    write("error", msg)
end

function logger.debug(msg)
    write("debug", msg)
end

function logger.close()
    if logFile then
        logFile:close()
        logFile = nil
    end
end

-- Auto init on require
init()

return logger
