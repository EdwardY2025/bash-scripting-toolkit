#!/bin/bash

#Edward Yeboah
#CSE/ISE 337
#SBU ID: 114385084
#Program 2

#check if input and output files are provided
if [[ $# != 2 ]] 
then
    echo "data file or output file not found"
    exit 1
fi

#stores input and output files in variables
input_file="$1"
output_file="$2"

#check if input fiule exists
if [[ ! -f "$input_file" ]]
then
    echo "$input_file not found" 
    exit 1
fi

#checks for illegal characters in input file
if grep -q '[^0-9;:,[:space]-]' "$input_file"
then
    echo "Illegal Pattern in input_file"
    exit 1
fi

#process the file and sends output to the output file using awk
awk '
BEGIN {
    FS = "[,;:]"
}
{
    split($0, fields, FS)
    for (i=1; i <= NF; i++) {
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", fields[i])
        if (fields[i] ~ /^-?[0-9]+$/) {
            sums[i] += fields[i]
        }
    }
}
END {
    for (i in sums) {
        print "Col " i ": " sums[i]
    }
}' "$input_file" > "$output_file"
#end of script
exit 0

#Test Cases

# Test Case 1: general test
if [[ "$1" == "--test" ]]; then
    echo "1,2,3" > test1.txt
    echo "4,5,6" >> test1.txt
    ./"$0" test1.txt output1.txt
    cat output1.txt
    echo ""

    # Test Case 2: invalid characters
    echo "1,a,3" > test2.txt
    ./"$0" test2.txt output2.txt

    # Test Case 3: missing arguments
    ./"$0"

    # Test Case 4: nonexistent file
    ./"$0" notexist.txt output4.txt

    # Test Case 5: negative numbers
    echo "1,-2,3" > test5.txt
    echo "-4,5,-6" >> test5.txt
    ./"$0" test5.txt output5.txt
    cat output5.txt
    exit 0
fi

