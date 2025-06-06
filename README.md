#Bash Scripting Toolkit

This repository contains a series of practical Bash scripting exercises involving file manipulation, input validation, command-line tools, and data processing using `awk`, `bc`, and traditional Unix utilities.

Each script includes built-in test cases to validate functionality under various scenarios.

---

## 📂 Scripts Overview

### 📁 `prog1.sh` — C Source File Relocator
Moves `.c` source files from a given source directory to a destination directory, preserving directory structure.  
- Interactive confirmation if >5 files are moved from any subfolder.
- Creates missing directories as needed.

### 📊 `prog2.sh` — Column Sum Calculator
Reads a delimited data file (`:` `,` or `;`) and computes the sum of each column using `awk`.  
- Detects and rejects non-numeric characters.
- Outputs results in the format: `Col n: sum`.

### 📚 `prog3.sh` — Bookstore Discount Calculator
Reads a file with book titles, prices, and quantities to calculate total cost and apply tiered discounts using `bc`.  
- Discounts:
  - 5% for $100–$200
  - 10% for $201–$499
  - 15% for $500+

### 🎓 `prog4.sh` — Student Grade Evaluator
Reads CSV files with student quiz scores, calculates the total percentage, and assigns letter grades (A–D).  
- Supports batch grading across multiple input files in a directory.

Each script also supports a --test flag to run built-in test cases:

bash prog1.sh --test
bash prog2.sh --test
...

---

## ▶️ How to Run

```bash
bash prog1.sh <src_dir> <dest_dir>
bash prog2.sh input.txt output.txt
bash prog3.sh books.txt
bash prog4.sh scores_directory/


