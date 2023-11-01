# Crossfire Server Demographics - Introduction

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
input_directory="/path/to/your/directory"

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