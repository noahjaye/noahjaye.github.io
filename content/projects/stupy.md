+++
date = '2026-09-27T22:46:56-04:00'
draft = false
title = 'Asteroids Sans IF, WHILE and Other Useful Language Features'
+++

McMaster University has a general first year of engineering, which assumes no prior knowledge in any subject that it teaches. Computing was no exception, and was in fact the least exceptional, covering most of a standard intro to CS course.

One of our projects was to make an asteroid-blaster game in ```turtle.py```, using what we had learned **and nothing else**. At the time, we had covered ```for``` loops. To clarify, that meant no conditionals, lists, functions or ```while``` loops.

The assignment gave us an oracle function to detect the color of a pixel so that we could register hits, which was our only allowed conditional. I wanted to draw over hit asteroids with a different color, or create a colored dot on a miss. This would require lists for position and conditionals for hit or miss.

I should have given up here and made the hit-an-asteroid-increment-a-number game, but I really really wanted my dots. 

## Lists with no lists
I thought of how to implement lists first. Turtle allows you to write pixels offscreen, and with a consistent write and read strategy, data could be stored in what was effectively a tape. My strategy was very simple. Since all of the asteroid parameters were integer-valued, I broke them into their bitwise representations and stored those.

An example game's data:
{{<img src="/images/stupy.png" width=200px >}}

I colored the 0-values differently for different data sections, partially for debugging and partially because it looks sick. This array is 2-dimensional because each quantity had to be stored per asteroid, and each vertical slice is a single asteroid. 

\- Red is x-position, stored in 10 bits for a 1000-pixel wide screen. 

\- Orange is y-position, stored in 9 bits for a 500-pixel screen. 

\- Yellow is the number of sides of the asteroid, stored in 2 bits for a range of 6-9 sides.

\- Green is the radius of the asteroid, stored in 6 bits for a range of 32-64. 

I managed to avoid storing orientation by giving every asteroid an orientation pointing away from the center of the screen.





## Unconditional conditionals

Conditionals forced me to get very creative, and get very creative I eventually did. What if you run a ```for``` loop 0 times? Semi-obviously, it won't run, and so if we pass in a variable that can either be 0 or 1 (or simply >0 if the operation is idempotent and we're lazy (or not lazy, see the moral)), then we have conditionals!

Silly conditional logic: 
```
# if shot is a miss, create a dot at the position to guide future shots.
for j in range(1-hit):
    t.color(MISS_COLOR)
    t.up()
    t.goto(shot_x_position, shot_y_position)
    t.down()
    t.dot(8)
    screen.update()
```

More silly conditional logic:
```
for j in range(continuous_line):
    continuous_line = 1
```
This is interesting, becuase it {{<targetblank href="https://en.wikipedia.org/wiki/LOOP_(programming_language)">}}turns the natural numbers into either 0 or 1 and uses them for logic. {{</targetblank>}}


This insight gave me ```if```, and I was able to implement as many conditional features as I wanted. I implemented a pretty good anti-collision mechanism so asteroids didn't draw on the same area, although we weren't allowed ```while``` loops so if after a large number of iterations there is still a collision, so be it (see the moral for why this isn't lazy). This number couldn't be too large, though, as we weren't allowed ```break``` statements either and the progam slowed to a crawl.


The fruits of my labor:
{{<img src="/images/stupy3.png" width=400px >}}

{{<img src="/images/stupy2.png" width=400px >}}

## Moral of the story

"Computers are pretty good at doing all the things given the ability to do a small number of the right things" - Fake Alan Turing

Fake Alan is correct, but the LOOP language (which I linked to above) is guaranteed to eventually halt, so asteroid collision risk is something this program, as it is written, has to live with.