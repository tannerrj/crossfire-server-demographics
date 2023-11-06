#!/bin/bash

# Step 1: Run the grep command and store the results in a temporary file
grep -h 'animation' /usr/games/crossfire/var/crossfire/players/*/*.pl | sort | uniq -c | sort -n > temp_results.txt

# Step 2: Save the results to a CSV file
awk '{print $3 "," $1}' temp_results.txt > results.csv

# Step 3: Create a bar graph using gnuplot
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
plot 'results.csv' using 2:xticlabels(1) with boxes
EOF

# Step 4: Clean up temporary files
rm temp_results.txt

echo "Results saved to results.csv and classes_bar_graph.png"