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