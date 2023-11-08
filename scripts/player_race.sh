#!/bin/bash

# Define the output CSV file
output_file="results.csv"

# Run the grep commands and save the results to CSV
grep -h '_player' */*.pl | sort | uniq -c | sort -n > "$output_file"
grep -h 'arch pl_dragon' */*.pl | sort | uniq -c | sort -n >> "$output_file"
grep -h 'pl_half_orc' */*.pl | sort | uniq -c | sort -n >> "$output_file"

# Create a bar graph from the CSV using gnuplot
gnuplot <<EOF
set datafile separator ","
set terminal png enhanced font 'Arial,12' size 800,600
set output "race_bar_graph.png"
set title "Player Races"
set xlabel "Count"
set ylabel "Pattern"
set style fill solid
set style data histograms
plot "$output_file" using 1:2:xtic(3) with boxes title "Pattern"
EOF

echo "Results saved to $output_file"
echo "Bar graph saved to race_bar_graph.png"
