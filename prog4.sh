#!/bin/bash

#Edward Yeboah
#CSE/ISE 337
#SBU ID: 114385084
#Program 4


#check if the user didn't provide the scores directory
if [[ $# != 1 ]]
then
    echo "score directory missing"
    exit 1
fi
#stores the directory path argument in a variable scores_directory
scores_directory="$1"

#chesks if the provided path is not a valid directory
if [[ ! -d "$scores_directory" ]] 
then
    echo "$scores_directory is not a directory"
    exit 1
fi
# loops through each file in the scores directory
for score in "$scores_directory"/*
do    #read each line of teh current file, splitting at commas
    while IFS=',' read -r id q1 q2 q3 q4 q5 || [[ -n "$id" ]]
    do
        #skips the header line or lines that are empty
        [[ "$id" == "ID" ]] || [[ -z "$id" ]] && continue
        #calculates the total by adding all scores
        total=$((q1 + q2 + q3 + q4 + q5))
        #each quiz is worth 20 points, so the percentage is total * 2
        percentage=$((total * 2))

        #determine letter grade based on percentage
        if (( percentage >= 93 )) 
        then
            grade="A"
        elif (( percentage >= 80 )) 
            then
            grade="B"
        elif (( percentage >= 65 )) 
            then
            grade="C"
        else
            grade="D"
        fi
        #outputs student id with their grade
        echo "$id:$grade"
    done < "$score"
done

exit 0

#Test Cases

#Test case 1: Creating test directory and files
if [[ "$1" == "--test" ]]; then
    echo "=== TEST 1: Creating test directory ==="
    mkdir -p test_data

    #Test case 2: Example student score file
    echo "=== TEST 2: First student scores ==="
    echo "ID,Q1,Q2,Q3,Q4,Q5" > test_data/prob4-score1.txt
    echo "101,8,6,9,4,10" >> test_data/prob4-score1.txt

    #Test case 3: Example student score file
    echo "=== TEST 3: Second student scores ==="
    echo "ID,Q1,Q2,Q3,Q4,Q5" > test_data/prob4-score2.txt
    echo "102,9,9,9,10,10" >> test_data/prob4-score2.txt

    #Test case 4: Example student score file
    echo "=== TEST 4: Third student scores ==="
    echo "ID,Q1,Q2,Q3,Q4,Q5" > test_data/prob4-score3.txt
    echo "103,5,6,2,4,6" >> test_data/prob4-score3.txt

    #Test case 5: Example student score file
    echo "=== TEST 5: Perfect scores ==="
    echo "ID,Q1,Q2,Q3,Q4,Q5" > test_data/prob4-score4.txt
    echo "104,10,10,10,10,10" >> test_data/prob4-score4.txt

    echo ""
    echo "=== TEST RESULTS ==="
    ./"$0" test_data
    exit 0
fi

