-- random util functions that i don't know where to put them
-- so they go here, the utility file where all random funcs go to die

function checkCollision(a, b)
    return a.x < b.x + b.width and
            b.x < a.x + a.width and
            a.y < b.y + b.height and
            b.y < a.y + a.height
end