#!/bin/bash

# Script: player_cults.sh
# Author: Rick Tanner via ChatGPT
# Description: This script searches through all server player files and collects statistics on which cult the players have chosen to play or use and then assembles a bar graph with this information.
# Project URL: https://github.com/tannerrj/crossfire-server-demographics
# License: MIT License


# Step 1: Define the titles you want to search for
# What is listed here is the currently available cults in Crossfire listed alphabetically, so no changes are likely in this list
titles=("Devourers" "Gaea" "Gnarg" "Gorokh" "Ixalovh" "Lythander" "Mostrai" "Ruggilli" "Sorig" "Valriel" "Valkyrie")

# Step 2: Check to make sure the input diretory exists, and if not display the error message

if [ ! -d "$input_directory" ]; then
    echo "Error: Input directory does not exist."
    exit 1
fi

# Step 3: Check if there are any .pl files in the specified input directory, and if not display the error message

if [ -z "$(find "$input_directory" -name '*.pl' -print -quit)" ]; then
    echo "Error: No .pl files found in the specified directory."
    exit 1
fi

# Step 4: Check if the necessary commands (grep, sort, uniq, awk, gnuplot) are available in the system

for cmd in grep sort uniq awk gnuplot; do
    if ! command -v "$cmd" > /dev/null; then
        echo "Error: $cmd command not found."
        exit 1
    fi
done

# Step 5: Specify the input directory where your .pl files are located
# This is a directory path that you modify and is most likely /usr/games/crossfire/var/crossfire/players/
input_directory="/usr/games/crossfire/var/crossfire/players/"

# Step 6: Create a CSV file to store the results
csv_file="cults_results.csv"

# Step 7: Loop through the titles and perform the grep, sort, uniq operations
for title in "${titles[@]}"; do
    grep -h "title $title" "$input_directory"*/*.pl | sort | uniq -c | sort -n >> "$csv_file"
done

# Step 8: Update results file to replace title text with a single comma
awk '{gsub(/title/, ","); print}' "$csv_file" > modified_cults_results.csv

# Step 9: Indicate that the first round of collected results were saved
echo "Initial results saved to modified_cults_results.csv"

# Step 10: Sort the results file so they in the format of number, cult-name
awk '{print $3 "," $1}' modified_cults_results.csv > updated_cults_results.csv

# Step 11: Indicate that the reformatted csv file has been created
echo "Modified results saved to updated_cults_results.csv"

# Step 12: Create a bar graph from the CSV file using gnuplot
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

# This Gnuplot code is used to generate a clustered bar graph from a CSV file named 'updated_cults_results.csv.' Let's break down the code step by step:
#
# 1. `set datafile separator ","`: Specifies that the comma (`,`) is used as the field separator in the CSV file.
#
# 2. `set term png enhanced font 'Arial,12' size 800,600`: Sets the output terminal to PNG format with enhanced mode, using the Arial font at size 12, and the graph size is set to 800x600 pixels.
#
# 3. `set output "cults_bar_graph.png"`: Specifies the output file name for the generated plot as "cults_bar_graph.png."
#
# 4. `set title "Player Cults"`: Sets the title of the plot as "Player Cults."
#
# 5. `set ylabel "Player Count"`: Sets the label for the y-axis as "Player Count."
#
# 6. `set xlabel "Player Cults"`: Sets the label for the x-axis as "Player Cults."
#
# 7. `set style fill solid border lt -1`: Sets the style for filling the boxes in the histogram plot as solid with no border.
#
# 8. `set style data histogram`: Specifies that the data to be plotted is in histogram format.
#
# 9. `set style histogram clustered`: Configures the histogram to be clustered, meaning that bars for each data point will be grouped together.
#
# 10. `set boxwidth 0.9 relative`: Sets the width of the boxes in the histogram to 90% of the space between clusters.
#
# 11. `set xtics rotate`: Rotates the x-axis tic labels for better readability.
#
# 12. `set key autotitle columnheader`: Uses the column headers from the CSV file as titles for the legend.
#
# 13. `plot 'updated_cults_results.csv' using 2:xticlabels(1) with boxes`: Plots the data from the CSV file. It uses the values in the second column for the y-axis and the first column for x-axis tic labels. The `with boxes` option specifies that the data should be plotted as boxes in the histogram.
#
# In summary, this Gnuplot script generates a clustered bar graph illustrating the player count for different player cults using data from the 'updated_cults_results.csv' file. The x-axis represents different player cults, the y-axis represents the player count, and each cluster of bars corresponds to a different data point in the CSV file.


# Step 13: Indicate that the graph and graphic has been created
echo "Bar graph saved to cults_bar_graph.png"