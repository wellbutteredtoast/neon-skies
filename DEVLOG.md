# Development Log
<!-- A day-to-day log of my existence as this is developed -->

### 2 May, 2025

The beginning of the beginning, very cool. This is the beginning of the project, stuff gets laid out here, the ground floor is being setup. Mostly markdown and document files with only a little bit of Lua code today. Of the little Lua written, it's mostly a Love2D template to get things started. A decent bit of work into the readme, mostly a shell of a readme, it'll be worked on as the project evolves. I've also planned to do weekly devlogs, or as close to weekly as possible. Each Sunday night (Sunday night for me) I'll be compiling the previous weeks work into a video format and posting it on my [YouTube Channel]() as a more concrete archive of development, and maybe to spark some interest in the project.

This video log series will not start on *this coming Sunday* (4 May, 2025), but rather the following Sunday (11 May, 2025), since I think talking openly about this would be a better approach than just endless words yapping away forever and ever.

Just finished the basic system for the player, which is awesome progress for me. I even threw in sprinting, but no asset rendering yet since I do not have any art created yet. But hopefully in a couple days I will!

### 3 May, 2025

It's a quiet and gray Saturday morning for me, I figured I would take about an hour our of my morning to mess around with shaders and see how that goes.

The shaders appear to not work without assets, since I still haven't done art, I'll have to come back to this later on. I did learn that the shaders are written in `OpenGL ES 1.0` shader language, which is helpful. I also learned that some shaders can be quite complex, so for th time being I'll just avoid shadering stuff.

I got something to render on the player, progress! So now I'll need to start making proper art once I'm started in uni. Until then I'm gonna start working on a basic NPC like system, complete with pathing and everything! ...A couple hours later, the NPC system base is a lot more functional as of now. We have NPCs that stand, walk, and chase. Right now it's good! Well, I broke it, I'll fix it tonight!

### 4 May, 2025

It's early in the morning (about 10:30AM) and some good progress has been made. I fixed the NPCs after patching some **major** issues with `Nonplayer:pathToPlayerPerfect` and `Nonplayer:pathToPlayerVariance`, mostly math related. The update loop was also fixed, as I was trying to compare a string to a boolean, and guess what, that doesn't work. (gasp!) Some small changes to the player to made, but not large enough to make a proper note of it.

I also expanded the readme to give an overview of the world the game takes place in. I will *not* be adding things like build instructions as [The Love2D Wiki](https://love2d.org/wiki) provides good instructions for taking a project like this and building it into a binary.

I learned that you can't make a function `local` if it's a `:` method, which kinda sucks because I built the pathing functions to be that way. Well, that should be fine for the next few days as I build out a collision system and using `Tiled` data to make a map, which'll be extremely helpful for me. For now, collision is just a concept, nonexistent. I fixed the path functions anyways, even if they're only gonna exist for another few days.

### 5 May, 2025

Today was the first day of lectures, so I didn't do a whole lot for the morning and some of the afternoon, but by the evening, things were moving smoothly. I added custom colours to the NPCs by just adding `r, g, b` values in the table. My current implementation is a little simple and can be improved upon later.

I'm currently thinking of how I plan on implementing collisions between the player and NPCs, it'll be a bit complex but I can handle it, I've stuffed some collision code into a `utility.lua` for the time being.

Now then, time to ramble. As I intend to make clear now, and later, I want players to be able to modify this game to their hearts content. Unfortunately this requires a lot of fun work. Lots of careful work to keep things from breaking, alongside building every single system of this game to not only be modular and generic for mods, but also securing things enough to keep this game from becoming a glorified trojan loader. I'm declaring this now since I do want this to be a big thing, since I cannot support this game forever. But with dedicated modding tools and, well, the ability to develop and distribute mods, the games life will be far longer!

All of this will be explained hopefully in better detail when the first video update is released. Despite this challenge, I will continue to write this game in Lua with Love2D even if that sounds a little wacky for the scope of the game and set of systems I've drafed for it, but this is a passion project, afterall. It's gonna take a while to get perfect.

### 6 May, 2025

**Big** day ahead, after some morning things, like taking notes for my online classes and tidying things up, finally sitting down to code. And today I finally start the first re-write of large portions of game code. Right now, I only have a couple hours so I'll be re-writing the player as it is top priority, I will focus on the NPCs afterwards. This re-write has put safety and readability in mind as well as modularity to a hilarious extent. By the end of this, a single mod could theoretically replace entire systems and the game would just chug along (within the sandboxed allowances of the game itself) This will need more work than I realized initally. So at this specific commit, do not be surprised with the hilariously large amount of changes happening in the repository.

Note: **I am aware of how insecure the current `modLoader.lua` currently is. This'll be addressed ASAP.**

Well that was not very eventful, I'll try do some more work tomorrow after my lectures.

### 7 May, 2025

12:05am for me, doing a small little thing before I go to bed, wake up, then go sliding into my lectures. 10 minutes later and I've re-written the NPC system to make it borderline drag-and-drop. Now an entire blank NPC can be slipped into the game via a single JSON file. For now, it's basic, but I will be extending this far and wide. The original `npc.lua` implementation will of course still be found in past commits, but for now this system is a lot better, at least in my opinion.

I accidentally broke everything by attempting to add NPC collisions with the player, currently fixing it, it'll take a little bit however. Currently 2:10pm - most of my day has been taken up by uni, only some coding today, probably some more later today.

**5 hours later and I realized it was because in `checkCollisions` it checks for `width` and `height`, not `w` and `h`.** What a day, but hey the code runs and it *didn't work* because why would it. Let me just explode really quick and figure this out. My theory is that `checkCollisions` is *always* returning false - or not even a boolean value. Turns out it was just reassigning `isColliding` before checking the value it just overwrote, rookie mistake. But now Love2D full-on **SEGFAULTS** shortly after collision. So this just got really weird... progress at least. Or maybe that's a one-off thing, it appears fine after testing, but the NPC doesn't *un-stick* itself, that should be a quick fix.

It was not a quick fix, it's almost midnight and I realized that putting per-instance code in the manager was probably a bad idea, I shipped the code into the `npc.lua` script and it works completely fine.

```lua
function Nonplayer:update(dt, playerPos)

    if checkCollision(self, playerPos) then
        self.isColliding = true
    end

    if not allowedTypes[self.type] or self.type == "static" then return end
    
    if self.isColliding then
        -- left blank intentionally
    else
        if self.type == "chasep" then
            pathToPlayerPerfect(self, playerPos)
        elseif self.type == "chasev" then
            pathToPlayerVariance(self, playerPos, 0.5)
        elseif self.type == "wander" then
            wanderRandom(self)
        end
    end

    self.isColliding = false
end
```

And that's the function, it front-loads collision, before even checking the NPC type check, which can probably be removed by now, but that's for the me of tomorrow to find out. That's all for today, I'm gonna go get some well deserved sleep.