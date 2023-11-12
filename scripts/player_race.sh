#!/bin/bash

# Step 1. Run grep commands and save results to a temporary file
grep -h '_player' /usr/games/crossfire/var/crossfire/players/*/*.pl | sort | uniq -c | sort -n > tmp_results.txt
grep -h 'arch pl_dragon' /usr/games/crossfire/var/crossfire/players/*/*.pl | sort | uniq -c | sort -n >> tmp_results.txt
grep -h 'pl_half_orc' /usr/games/crossfire/var/crossfire/players/*/*.pl | sort | uniq -c | sort -n >> tmp_results.txt

# Step 2. Create a CSV file from the temporary file
awk '{print $1 "," $3}' tmp_results.txt > player_race_results.csv

# Create a bar graph using gnuplot
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

# Clean up temporary file
# rm tmp_results.txt

echo "Results saved to player_race_results.csv"
echo "Bar graph saved to player_race_bar_graph.png"