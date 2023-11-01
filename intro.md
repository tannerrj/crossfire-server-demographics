# Crossfire Server Demographics - Introduction

## Player Cults

Show me a bash script for the following command:

```shell
grep -h 'title Mostrai' */*.pl | sort | uniq -c | sort -n; grep -h 'title Lythander' */*.pl | sort | uniq -c | sort -n; grep -h 'title Gnarg' */*.pl | sort | uniq -c | sort -n; grep -h '^title Gaea' */*.pl | sort | uniq -c | sort -n; grep -h 'title Devourers' */*.pl | sort | uniq -c | sort -n; grep -h 'title Ruggilli' */*.pl | sort | uniq -c | sort -n; grep -h 'title Gorokh' */*.pl | sort | uniq -c | sort -n; grep -h 'title Valriel' */*.pl | sort | uniq -c | sort -n; grep -h 'title Sorig' */*.pl | sort | uniq -c | sort -n; grep -h 'title Ixalovh' */*.pl | sort | uniq -c | sort -n; grep -h 'title Valkyrie' */*.pl | sort | uniq -c | sort -n
```

And saves the results to a csv file, and then creates a bar graph from the results in the csv file

----

You can create a Bash script to achieve the desired functionality using a combination of commands like `grep`, `sort`, `uniq`, and `gnuplot` for creating the bar graph. Here's a Bash script that does that:

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

If necessary, customize the `titles` array and `input_directory` to match your specific requirements. Save this script to a file (e.g., `player_cults.sh`), make it executable using `chmod +x player_cults.sh`, and then run it using `./player_cults.sh`. This script will create a CSV file with the results and generate a bar graph in PNG format named "bar_graph.png" based on the data in the CSV file.

## Player Classes/Professions

Show me a bash script for the following command:

```shell

grep -h 'animation' */*.pl | sort | uniq -c | sort -n

```

And saves the results to a csv file, and then creates a bar graph from the results in the csv file

----

To achieve your goal, you can create a Bash script that performs the following steps:

1. Run the `grep` command.
2. Sort and count the lines.
3. Save the results to a CSV file.
4. Create a bar graph from the CSV file using a tool like `gnuplot`.

Here's a Bash script that does this:

```bash
#!/bin/bash

# Step 1: Run the grep command and store the results in a temporary file
grep -h 'animation' /usr/games/crossfire/var/crossfire/players/*/*.pl | sort | uniq -c | sort -n > temp_results.txt

# Step 2: Save the results to a CSV file
awk '{print $1 "," $2}' temp_results.txt > results.csv

# Step 3: Create a bar graph using gnuplot
gnuplot <<EOF
set datafile separator ","
set terminal png
set output "bar_graph.png"
set title "Animation Count by File"
set ylabel "Count"
set style data histograms
plot 'results.csv' using 2:xticlabels(1) with boxes
EOF

# Step 4: Clean up temporary files
rm temp_results.txt

echo "Results saved to results.csv and bar_graph.png"
```

Save this script to a file (e.g., `player_classes.sh`) and make it executable using `chmod +x player_classes.sh`. You can then run the script, and it will create a CSV file named `results.csv` and a bar graph image named `bar_graph.png` in the same directory.

This script assumes that you have `gnuplot` installed on your system to generate the bar graph. If you don't have it installed, you can usually install it using your package manager.