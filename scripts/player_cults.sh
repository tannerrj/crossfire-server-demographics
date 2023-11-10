#!/bin/bash

# Step 1: Define the titles you want to search for
# What is listed here is the currently available cults in Crossfire listed alphabetically, so no changes are likely in this list
titles=("Devourers" "Gaea" "Gnarg" "Gorokh" "Ixalovh" "Lythander" "Mostrai" "Ruggilli" "Sorig" "Valriel" "Valkyrie")

# Step 2: Specify the input directory where your .pl files are located
# This is a directory path that you modify and is most likely /usr/games/crossfire/var/crossfire/players/
input_directory="/usr/games/crossfire/var/crossfire/players/"

# Step 3: Create a CSV file to store the results
csv_file="cults_results.csv"

# Header for the CSV file
# echo "Title,Count" > "$csv_file"

# Step 4: Loop through the titles and perform the grep, sort, uniq operations
for title in "${titles[@]}"; do
    grep -h "title $title" "$input_directory"*/*.pl | sort | uniq -c | sort -n >> "$csv_file"
done

# Step 5: Update results file to replace title text with a single comma
awk '{gsub(/title/, ","); print}' cults_results.csv > modified_cults_results.csv

# Step 6: Sort the results file so they in the format of number , cult-name
awk '{print $3 "," $1}' modified_cults_results.csv > updated_cults_results.csv

# Step 7: Create a bar graph from the CSV file using gnuplot
gnuplot << EOF
set datafile separator ","
set term png enhanced font 'Arial,12' size 800,600
set output "cults_bar_graph.png"
set title "Player Cults"
set ylabel "Player Count"
set xlabel "Player Cults"
set style fill solid border lt -1
set style data histogram
set style histogram clustered
set boxwidth 0.9 relative
set xtics rotate
set key autotitle columnheader
plot 'updated_cults_results.csv' using 2:xticlabels(1) with boxes
EOF

echo "Results saved to cults_results.csv"
echo "Bar graph saved to cults_bar_graph.png"