# Crossfire Server Demographics

## Description

A bash script the searches through all server player files and collects statistics on which race, cult, and class the players have chosen to play or use and then assembles a bar graph with this information.

## Installation

It is helpful to have git installed to download all the related code for `Crossfire Server Demographics`

### Requirements

No special add-ons or installation is required as the required tools are already bundled in most Linux distributions, such as: `grep`, `sort`, `uniq`, and `gnuplot`

## Guidelines

### Description: Questions to Consider

 * What is the script for?
   * Anyone who is running a Crossfire server and wants to see what choices players are making in regards to cults, race, and class/profession
 * What was your motivation?
   * Working on a gaming project of [Crossfire](https://sourceforge.net/projects/crossfire/), I sometimes encounter a question on [Discord](https://crossfire.real-time.com/discord/) or [IRC](https://crossfire.real-time.com/irc/) or within one of the game servers about what people are choosing to play - this can shed some light on those choices and perhaps direct map makers on where to make content that is needed.
 * What problem does it solve?
   * Quickly provides simple stats and numbers on the player base for the game server

## Usage

Each script collects population info on a different demographic and is run individually to collect player character information.

 * `player_classes.sh` - collects number of players who are in the current in-game classes or professions of alchemist, barbarian, devotee, evoker, sorcerer, summoner, warlock, wizard, monk, ninja, priest, swashbuckler, thief, paladin, warrior, and ranger
 * `player_cults.sh` - collects number of players who are followers of the current in-games cults of Devourers, Gaea, Gnarg, Gorokh, Ixalovh, Lythander, Mostrai, Ruggilli, Sorig, Valriel, and Valkyrie
 * `player_race.sh` - collects number of players who are in the current in-game races of dragons, dwarves, elves, fendrakis, fireborn, gnome, half orc, halfling, human, northmen, quetzalcoatls, serpent folk, trolls, and wraiths

Download and save the scripts or `git pull` the scripts, make them executable using `chmod +x <script-name>.sh`, and then run it using `./<script-name>.sh`.

This script will create a CSV file with the results and generate a bar graph in PNG format named "bar_graph.png" based on the data in the CSV file.

## Screenshot

Not available yet, work in progress.

## Live Web Page

Not available yet, work in progress.

## Contributing

 * Contributions are welcome.
 * Pull requests are welcome.
 * Creating a fork on this code base is also welcome.

## Questions

I can be reached via [tannerrj GitHub Profile](https://github.com/tannerrj)

## License:

MIT License

## Crossfire Social Media Links

 * [Facebook](https://www.facebook.com/crossfireproject/)
 * [Mastodon](https://mastodon.social/@crossfiremrpg)
 * [X (Formerly Twitter)](https://twitter.com/crossfiremrpg/)