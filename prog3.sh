#!/bin/bash

#Edward Yeboah
#CSE/ISE 337
#SBU ID: 114385084
#Program 3

file="$1"

#checks if exactly 1 file argument is provided
if [[ $# != 1 ]]
then
    echo "missing data file"
    exit 1
fi
#checks if the file exists
if [[ ! -f "$file" ]]
then
    echo "File not found: $file"
    exit 1
fi

total_cost=0

#read each line of the file
while IFS= read -r line
do
    #skip empty lines
    [[ -z "$line" ]] && continue
    
    # extract price and quantity per line
    price=$(echo "$line" | awk '{print $2}')
    quantity=$(echo "$line" | awk '{print $3}')
    
    #validate integers
    [[ "$price" =~ ^[0-9]+(\.[0-9]+)?$ ]] || continue
    [[ "$quantity" =~ ^[0-9]+$ ]] || continue

    #calculates total
    total_cost=$(bc <<< "$total_cost + ($price * $quantity)")
done < "$file"

# Calculate discount
if (( $(bc <<< "$total_cost >= 500") == 1 ))
then
    discount=$(bc <<< "$total_cost * 0.15")
elif (( $(bc <<< "$total_cost >= 201") == 1 ))
then
    discount=$(bc <<< "$total_cost * 0.10")
elif (( $(bc <<< "$total_cost >= 100") == 1 ))
then
    discount=$(bc <<< "$total_cost * 0.05")
else
    discount=0
fi

#calculates final cost
final_cost=$(bc <<< "$total_cost - $discount")

#outputs final cost
echo "$final_cost"

exit 0

#Test Cases

#Test Case 1: No arguments
if [[ "$1" == "--test" ]]; then
    echo "=== TEST 1: No arguments ==="
    ./"$0"
    echo ""

    #Test Case 2: Book Calculations
    echo "=== TEST 2: Book Calculations ==="
    echo "Book1 20 5" > test2.txt
    echo "Book2 15 6" >> test2.txt
    echo "Book3 30 10">> test2.txt
    echo "Book4 25 6" >> test2.txt
    echo "Book5 10 3" >> test2.txt
    ./"$0" test2.txt
    echo "Summing these costs: "
    echo "20*5 + 15*6 + 30*10 + 25*6 + 10*3 = 100 + 90 + 300 + 150 + 30 = 670"
    echo "Applying Discount: 15%"
    echo "Final Cost: 670 - (670*0.15) = 569.5"
    echo ""

    #Test Case 3: Invalid input
    echo "=== TEST 3: Invalid input ==="
    echo "Book1 BANNED 0000" > test3.txt
    echo "Book2 ERROR" >> test3.txt
    ./"$0" test3.txt
    echo "Expected output: 0"
    echo ""

    #Test Case 4: Decimal quantities
    echo "=== TEST 4: Decimal quantities ==="
    echo "Book1 20 5.5" > test4.txt
    echo "Book2 15 6" >> test4.txt
    actual=$(./"$0" test4.txt)
    echo "Actual: $actual"
    echo "Expected: 90"
    [[ "$actual" == "90" ]] && echo "PASS" || echo "FAIL"
    echo ""

    #Test Case 5: negative numbers
    echo "=== TEST 5: Negative numbers ==="
    echo "Book1 -20 5" > test5.txt
    echo "Book2 15 6" >> test5.txt
    actual=$(./"$0" test5.txt)
    echo "Expected: 90"
    echo "Actual: $actual"
    [[ "$actual" == "90" ]] && echo "PASS" || echo "FAIL"
    echo ""
    exit 0
fi


