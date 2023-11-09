#!/bin/bash

# Define the titles you want to search for
# What is listed here is the currently available cults in Crossfire listed alphabetically, so no changes are likely in this list
titles=("Devourers" "Gaea" "Gnarg" "Gorokh" "Ixalovh" "Lythander" "Mostrai" "Ruggilli" "Sorig" "Valriel" "Valkyrie")

# Specify the input directory where your .pl files are located
# This is a directory path that you modify and is most likely /usr/games/crossfire/var/crossfire/players/
input_directory="/usr/games/crossfire/var/crossfire/players/"

# Create a CSV file to store the results
csv_file="cults-results.csv"

# Header for the CSV file
# echo "Title,Count" > "$csv_file"

# Loop through the titles and perform the grep, sort, uniq operations
for title in "${titles[@]}"; do
    grep -h "title $title" "$input_directory"*/*.pl | sort | uniq -c | sort -n >> "$csv_file"
done

awk '{gsub(/title/, ","); print}' cults_results.csv > modified_cults_results.csv

awk '{print $3 "," $1}' modified_cults_results.csv > updated_cults_results.csv

# Create a bar graph from the CSV file using gnuplot
gnuplot << EOF
set datafile separator ","
set term png enhanced font 'Arial,12' size 800,600
set output "cults_bar_graph.png"
set title "Player Cults"
set ylabel "Player Cults Count"
set xlabel "Player Cults"
set style fill solid border lt -1
set style data histogram
set style histogram clustered
set boxwidth 0.9 relative
set xtics rotate
set key autotitle columnheader
plot 'updated_cults_results.csv' using 2:xticlabels(1) with boxes
EOF