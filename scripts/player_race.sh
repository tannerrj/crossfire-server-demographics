#!/bin/bash

# Step 1. Run grep commands and save results to a temporary file
# First pass searches for all _player references with a list of exceptions
grep -h '_player' /usr/games/crossfire/var/crossfire/players/*/*.pl | grep -v -e 'fenx_player_class_warrior' -e 'human_player_force' -e 'fenx_player_force' -e 'troll_player_force' -e 'wraith_player_force' -e 'fireborn_player_force' -e 'valriel_player_glow' -e 'elf_player_force' -e 'no_fix_player 1' | sort | uniq -c | sort -n > tmp_results.txt
# Second pass looks for dragon players and it's own syntax of pl_dragon
grep -h 'arch pl_dragon' /usr/games/crossfire/var/crossfire/players/*/*.pl | sort | uniq -c | sort -n >> tmp_results.txt
# Third pass looks for half orc players and uses it's own syntax of pl_half_orc
grep -h 'pl_half_orc' /usr/games/crossfire/var/crossfire/players/*/*.pl | sort | uniq -c | sort -n >> tmp_results.txt

# Step 2. Create a CSV file from the temporary file
awk '{print $1 "," $3}' tmp_results.txt > player_race_results.csv

echo "Results saved to player_race_results.csv"

# Step 3. Create a bar graph using gnuplot
gnuplot <<EOF
set datafile separator ","
set terminal png enhanced font 'Arial,12' size 800,600
set output "races_bar_graph.png"
set title "Player Statistics"
set xlabel "Count"
set ylabel "Player Race"
set style data histogram
set style histogram cluster
set boxwidth 0.9 relative
set style fill solid border -1
set xtics rotate
plot "player_race_results.csv" using 1:xtic(2) title ""
EOF

# Step 4. Clean up temporary file
rm tmp_results.txt

echo "Bar graph saved to races_bar_graph.png"