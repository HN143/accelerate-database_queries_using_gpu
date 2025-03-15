const fs = require("fs");
const path = require("path");
const sqlFormatter = require("sql-formatter");

// Get argument (if any) for the folder to format
const folderArg = process.argv[2];

// Resolve the target directory:
// If an argument is given, resolve it relative to current working directory.
// Otherwise, use the current working directory.
const directoryPath = folderArg
  ? path.resolve(process.cwd(), folderArg)
  : process.cwd();

// Ensure that the directory exists
if (!fs.existsSync(directoryPath)) {
  console.error(`Directory does not exist: ${directoryPath}`);
  process.exit(1);
}

// Read directory contents
fs.readdirSync(directoryPath).forEach((fileName) => {
  // Only process .sql files
  if (path.extname(fileName).toLowerCase() === ".sql") {
    const fullPath = path.join(directoryPath, fileName);

    // Read file content
    const fileContent = fs.readFileSync(fullPath, "utf8");

    // Format SQL using tab indentation
    const formattedSQL = sqlFormatter.format(fileContent, { useTabs: "\t" });

    // Write the formatted content back to the file
    fs.writeFileSync(fullPath, formattedSQL, "utf8");
    console.log(`Formatted: ${fileName}`);
  }
});
