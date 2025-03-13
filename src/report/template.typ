// Define basic size and spacing variables
#let textSize = 14pt // Base font size for the document
#let tabSize = 1cm // Standard indentation size
#let prefixh1 = "CHƯƠNG" // Prefix for chapter titles (Vietnamese for "CHAPTER")

// Main document template function that applies formatting to the body content
#let template(body) = {
  // Set page properties: A4 paper with asymmetric margins (wider on left)
  set page("a4", margin: (top: 2cm, right: 2cm, bottom: 2cm, left: 3cm))

  // Set base text properties using Times New Roman for Vietnamese content
  set text(size: textSize, font: "Times New Roman", fallback: false, region: "VN")

  // Configure block spacing - no internal padding, with space after blocks
  set block(inset: 0pt, outset: 0pt, above: 0pt, below: 1.5 * textSize)

  // Configure paragraph properties - justified text with 1.5x line spacing
  // and standard tab indentation for first line
  set par(
    justify: true,
    leading: textSize, // 1.5 lines
    first-line-indent: tabSize,
  )

  // Configure bulleted lists with custom markers for different list levels
  set list(
    indent: tabSize, // Indentation from margin
    body-indent: .75em, // Item body indentation from marker
    marker: ([•], [◦], [--]), // Bullets for levels 1, 2, and 3
    tight: true, // Reduced spacing between list items
  )

  // Configure enumerated lists
  set enum(
    indent: tabSize, // Indentation from margin
    body-indent: .75em, // Item body indentation from marker
    tight: true, // Reduced spacing between list items
  )

  // Heading formatting: adjust spacing before and after headings
  show heading: it => {
    block(inset: (top: -(1 * textSize))) // Reduce space before heading
    it // Show the actual heading
    block(inset: (top: -(2.5 * textSize))) // Adjust space after heading
    par("") // Add an empty paragraph after
  }

  // List formatting: adjust spacing and hanging indents for list items
  show list: it => {
    block(inset: (top: -(0.25 * textSize))) // Adjust space before list
    set par(hanging-indent: -(2 * tabSize - 1.5em)) // Set hanging indent for items
    it // Show the actual list
    block(inset: (top: -(3 * textSize))) // Adjust space after list
    par("") // Add an empty paragraph after
  }

  // Enumeration formatting: similar adjustments as for lists
  show enum: it => {
    block(inset: (top: -(0.25 * textSize))) // Adjust space before enum
    set par(hanging-indent: -(2 * tabSize - 0.75em)) // Set hanging indent for items
    it // Show the actual enumeration
    block(inset: (top: -(3 * textSize))) // Adjust space after enum
    par("") // Add an empty paragraph after
  }

  // Figure formatting: adjust spacing after figures
  show figure: it => {
    it // Show the actual figure
    block(inset: (top: -(3 * textSize))) // Adjust space after figure
    par("") // Add an empty paragraph after
  }

  // Table formatting: adjust spacing after tables
  show table: it => {
    it // Show the actual table
    block(inset: (top: -(3 * textSize))) // Adjust space after table
    par("") // Add an empty paragraph after
  }

  // Code block formatting: create light gray boxes with borders
  show raw.where(block: true): it => {
    block(inset: (top: 0pt)) // No extra space before code block
    set par(justify: false, leading: 8pt) // Don't justify code and reduce line spacing
    set text(size: 8pt) // Smaller font for code
    grid(
      columns: (100%, 100%), // Create a grid layout
      column-gutter: -100%, // Negative gutter overlays the columns
      block(radius: 0em, fill: luma(246), stroke: 1pt, width: 100%, inset: 1em, it), // Gray background with border
    )
    block(inset: (top: -(3 * textSize))) // Adjust space after code block
    par("") // Add an empty paragraph after
  }

  // Bibliography formatting: set language for citations
  show bibliography: it => {
    block(inset: (top: (textSize))) // Add space before bibliography
    set text(lang: "vi", region: "VN") // Set Vietnamese language for bibliography
    it // Show the actual bibliography
  }

  body // Output the document body with all formatting rules applied
}
