import os
import re
import shutil
import sys

def main():
    # Define input and output file paths
    input_file = os.path.expanduser("~/heavyai/tpcds/tpcds.sql")
    temp_file = os.path.expanduser("~/heavyai/tpcds/tpcds_no_pk.sql")
    
    # Check if the input file exists
    if not os.path.isfile(input_file):
        print(f"Error: Input file {input_file} not found.")
        sys.exit(1)
    
    # Remove all lines containing primary key definitions and comments
    with open(input_file, 'r') as infile, open(temp_file, 'w') as outfile:
        for line in infile:
            if "primary key" not in line and not line.strip().startswith('--'):
                outfile.write(line)
    
    # Fix trailing commas before closing parentheses
    with open(temp_file, 'r') as file:
        content = file.read()
    
    # Replace patterns like ",\n)" with "\n)" to ensure valid SQL syntax
    modified_content = re.sub(r',\s*\);', '\n);', content)
    
    # Write the modified content back to the temp file
    with open(temp_file, 'w') as file:
        file.write(modified_content)
    
    # Replace the original file with the modified version
    shutil.move(temp_file, input_file)
    
    # Print success message
    print(f"Primary key definitions and comments have been removed in {input_file}")

if __name__ == "__main__":
    main()
