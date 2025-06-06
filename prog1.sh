#!/bin/bash

#Edward Yeboah
#CSE/ISE 337
#SBU ID: 114385084
#Problem 1

#checks if source and dest directories were provided
if [[ $# != 2 ]]
then
    echo "src and dest dirs missing"
    exit 1
fi

#stores both directories in their respective variables
src_dir="$1"
dest_dir="$2"

#checks if source directory doesn't exist
if [[ ! -d "$src_dir" ]]
then
    echo "The source directory '$src_dir' is not found."
    exit 1
fi

#checks if dest directory doesn't exist
if [[ ! -d "$dest_dir" ]]
then
    mkdir -p "$dest_dir"
fi

#function to move C files from source to dest
move_files() {
    local src="$1"
    local dest="$2"

    #locates all C files in current directory
    for file in "$src"/*.c
    do
        #only process if its a non directory file
        if [[ -f "$file" ]]
        then
            #adds to the list of C files
            c_files+=("$file")
        fi
    done
    #shows list of files to user if more than 5 files are found
    local file_count=${#c_files[@]}

    if (( file_count > 5 ))
    then
        echo "Found $file_count C files in $src:"
        for file in "${c_files[@]}"
        do
            echo "  $(basename "$file")"
        done
        #asks for user confirmation before moving the files
        read -p "Do you want to move these files? (Y/y for yes): " choice
        if [[ "$choice" =~ ^[Yy]$ ]]
        then
            mv "${c_files[@]}" "$dest/"
        fi

    elif (( file_count > 0 ))
    then
        mv "${c_files[@]}" "$dest/"
    fi

    c_files=()
}
#processes all directories
while IFS= read -r -d '' dir
do
    #creates corresponding dest directory structure
    destSubDir="${dest_dir}${dir#$src_dir}"
    mkdir -p "$destSubDir"
    #moves files for this directory
    move_files "$dir" "$destSubDir"
done < <(find "$src_dir" -type d -print0)

#Test cases

# Test Case 1: 5 .c files
if [[ "$1" == "--test" ]]; then
    mkdir case1_src
    mkdir case1_dest
    for i in {1..5}; do
        echo "int main() { return 0; }" > "case1_src/file$i.c"
    done
    ./"$0" "case1_src" "case1_dest"
    
    # Test Case 2: Non-existent src directory
    mkdir case2_dest
    ./"$0" "bad_src" "case2_dest"
    
    # Test Case 3: Destination does not exist
    mkdir case3_src
    echo "int main() { return 0; }" > "case3_src/single.c"
    ./"$0" "case3_src" "case3_dest"
    
    # Test Case 4: 6 .c files in src
    mkdir case4_src
    mkdir case4_dest
    for i in {1..6}; do
        echo "int main() { return 0; }" > "case4_src/file$i.c"
    done
    ./"$0" "case4_src" "case4_dest"
    
    # Test Case 5: Only 1 .c file in src
    mkdir case5_src
    mkdir case5_dest
    echo "int main() { return 0; }" > "case5_src/main.c"
    ./"$0" "case5_src" "case5_dest"
    exit 0
fi
exit 0

