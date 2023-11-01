# Crossfire Server Demographics

## Description

A bash script the searches through all server player files and collects statistics on which race, cult, and class the players have chosen to play or use and then assembles a bar graph with this information.

## Installation

`grep`, `sort`, `uniq`, and `gnuplot`

### Requirements


## Guidelines

### Description: Questions to Consider


## Usage

Once the script is downloaded or pulled via git:

```bash

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

```

Make sure to customize the `titles` array and `input_directory` to match your specific requirements. Save this script to a file (e.g., `generate_graph.sh`), make it executable using `chmod +x generate_graph.sh`, and then run it using `./generate_graph.sh`. This script will create a CSV file with the results and generate a bar graph in PNG format named "bar_graph.png" based on the data in the CSV file.

## Screenshot




## Live Web Page



## Contributing

 * Contributions are welcome.
 * Pull requests are welcome.
 * Creating a fork on this code base is also welcome.

## Questions

I can be reached via [tannerrj GitHub Profile](https://github.com/tannerrj)

## License:




## Crossfire Social Media Links

 * [Facebook](https://www.facebook.com/crossfireproject/)
 * [Mastodon](https://mastodon.social/@crossfiremrpg)
 * [X (Formerly Twitter)](https://twitter.com/crossfiremrpg/)