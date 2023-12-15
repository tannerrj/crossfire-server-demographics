#!/bin/bash

# Script: player_classes.sh
# Author: Rick Tanner via ChatGPT
# Description: This script searches through all server player files and collects statistics on which class the players have chosen to play or use and then assembles a bar graph with this information.
# Project URL: https://github.com/tannerrj/crossfire-server-demographics

# Step 1: Run the grep command and store the results in a temporary file
grep -h 'animation' /usr/games/crossfire/var/crossfire/players/*/*.pl | grep -v -e 'goose' -e 'wand' -e 'pl_dragon_bl' -e 'NONE' -e 'pl_dragon_blue' -e 'pl_dragon_g' | sort | uniq -c | sort -n > temp_results.txt

# Step 2: Save the results to a CSV file
awk '{print $3 "," $1}' temp_results.txt > player_class_results.csv

# Step 3: Indicate the .csv file has been created
echo "Results saved to player_class_results.csv"

# Step 4: Create a bar graph using gnuplot
gnuplot <<EOF
set datafile separator ","
set terminal png enhanced font 'Arial,12' size 800,600
set output "classes_bar_graph.png"
set title "Player Classes"
set ylabel "Player Classes Count"
set xlabel "Player Classes"
set style fill solid border lt -1
set style data histograms
set style histogram clustered
set boxwidth 0.9 relative
set xtics rotate
set key autotitle columnheader
plot 'player_class_results.csv' using 2:xticlabels(1) with boxes
EOF

# Step 5: Clean up temporary files
rm temp_results.txt

# Step 6: Indicate the graphic file has been created
echo "Results saved to classes_bar_graph.png"