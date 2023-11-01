#!/bin/bash

# Define the titles you want to search for
# What is listed here is the currently available cults in Crossfire listed alphabetically, so no changes are likely in this list
titles=("Devourers" "Gaea" "Gnarg" "Gorokh" "Ixalovh" "Lythander" "Mostrai" "Ruggilli" "Sorig" "Valriel" "Valkyrie")

# Specify the input directory where your .pl files are located
# This is a directory path that you modify and is most likely /usr/games/crossfire/var/crossfire/players/
input_directory="/usr/games/crossfire/var/crossfire/players/"

# Create a CSV file to store the results
csv_file="results.csv"

# Header for the CSV file
echo "Title,Count" > "$csv_file"

# Loop through the titles and perform the grep, sort, uniq operations
for title in "${titles[@]}"; do
    grep -h "title $title" "$input_directory"/*.pl | sort | uniq -c | sort -n >> "$csv_file"
done

# Create a bar graph from the CSV file using gnuplot
gnuplot << EOF
set datafile separator ","
set term png
set output "bar_graph.png"
set style data histogram
set style fill solid
set xtics rotate
plot "$csv_file" using 2:xtic(1) title ""
EOF