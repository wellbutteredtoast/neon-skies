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