+++
date = '2026-09-27T22:49:40-04:00'
draft = false
title = 'Klawerjass'
+++

At the beginning of grade 11, I decided to build a web app for my grandpa, porting the game Klawerjass online. Klawerjass is a card game similar to Euchre, and my family plays a possibly unique 2-player version. 

After working on this project for nearly 8 months on-and-off, I decided to drop it in favor of band, school and [other projects](../robotics). 

Still, I learned a ton about the web, and there are a few hacky solutions that I'm proud of.

### Laptop-hosted postgres with ngrok
I made the decision to host the website using AWS, since I got a year's free trial of EC2. Unfortunately, an Amazon-hosted DB would've cost me $20 a month, so I searched for a workaround. I ended up using ngrok to expose a port on my laptop to the public internet, and then modifying the postgres ```Pool()``` method to ping my laptop and wait for a response. The code can be found {{<targetblank href="https://github.com/noahjaye/Klawerjass-Pub/blob/main/sapi/useful/sharedStuff.js">}} here {{</targetblank>}} and the laptop-based server can be found {{<targetblank href="https://github.com/noahjaye/Klawerjass-Pub/blob/main/dbforwarder.js">}} here {{</targetblank>}}. 

This solution was a major reason that I dropped the project, since it made my laptop massively vulnerable to arbitrary SQL being run on a priveleged user. I could've found a different solution, but my interest in the project had been waning for a while.