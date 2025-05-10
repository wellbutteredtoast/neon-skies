# Changelog

## May 2, 2025

- Created Project
- Created `main.lua`
- Created `conf.lua`
- Created `changelog-dev.md`
- Created `changelog-rel.md`
- Created `devlog.md`
- Completed `conf.lua`

## May 3, 2025

- Worked on `player.lua`
- Slight format change to `conf.lua`
- Created `gamedata`, all assets beyond Lua scripts will go here
- Added proper asset rendering to `player.lua`
- Created `npc.lua`
- Started work on pathToPlayerPerfect
- Started work on pathToPlayerVariance
- Added test NPCs to `main.lua` (broken)

## May 4, 2025

- Fixed major bugs `in npc.lua`
- Small update to `pathToPlayerPerfect`
- Tweaked main.lua for added NPC testing
- Added a `speed` variable to NPCs
- Validated `chasep`, `chasev`, and `static` path methods
- Slightly increased player movement speed
- Expanded the readme.md
- Converted `:pathToPlayerPerfect` and `:pathToPlayerVariance` into `local` functions
- Implemented bounds detection to keep players in the game window
- Removed NPC tests from `main.lua`
- Removed `CHANGELOG-rel.md`

## May 5, 2025

- Added custom colours to NPC default rectangles
- Removed stat system stub from `player.lua`
- Added `utility.lua` for misc global functions

## May 6, 2025

- Created `logSys.lua`
- Created `modLoader.lua`
- Added rxi's `json.lua` as a dependency
- Added mod loading in `love.load()` step of `main.lua`

## May 7, 2025

- Re-wrote `npc.lua`
- Implemented `npcManager.lua` to centralize all NPCs
- Created a simple JSON structure and decoding step for NPCs
- Added a log step in `npc.lua`
- Implemented NPC/Player collisions
- Gave the player a `width` and `height` attribute (fixing `checkCollision()`)

## May 8, 2025

- Removed log step from `npc.lua`
- Added boundary checking to NPCs
- Large bugfixes to `npcManager:loadAll()`
- Added better filechecking in `npc.new()`
- Improved no asset fallback in `npc.lua`
- Implemented `modValidator.lua` to check for bad acting mods
- Re-added log steps to `npcManager.lua` and `player.lua`
- Added a test mod; `mods/bad` to test manifest loading and script checking
- Added a second test mod; `mods/mod2` for multimod testing
- Changed `info()` logs to `debug()` logs in `npcManager.lua`
- Added `inventory.lua`
- Added `inventoryManager.lua`

## May 9, 2025

- No updates

## May 10, 2025

- No updates