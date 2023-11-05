#!/bin/bash

# Step 1: Run the grep command and store the results in a temporary file
grep -h 'animation' /usr/games/crossfire/var/crossfire/players/*/*.pl | sort | uniq -c | sort -n > temp_results.txt

# Step 2: Save the results to a CSV file
awk '{print $1 "," $2}' temp_results.txt > results.csv

# Step 3: Create a bar graph using gnuplot
gnuplot <<EOF
set datafile separator ","
set terminal png
set output "classes_bar_graph.png"
set title "Animation Count by File"
set ylabel "Count"
set style data histograms
plot 'results.csv' using 2:xticlabels(1) with boxes
EOF

# Step 4: Clean up temporary files
rm temp_results.txt

echo "Results saved to results.csv and classes_bar_graph.png"