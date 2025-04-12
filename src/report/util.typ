/**
 * Utility functions for formatting and styling a report document.
 * This file provides custom heading styles, image handling, and table formatting functions
 * that maintain consistent styling throughout the document.
 *
 * The file imports base styles from template.typ and builds upon them.
 */

// Import template styles and configurations
#import "template.typ": *

/**
 * Creates a level 1 (major) heading with consistent styling.
 *
 * @param children - The content/text of the heading
 * @param numbering - Whether to show section numbering (default: true)
 * @param pageBreak - Whether to start this heading on a new page (default: true)
 * @returns A formatted level 1 heading with uppercase text
 */
#let h1(children, numbering: true, pageBreak: true) = {
  if (pageBreak) [#pagebreak()]
  set align(center)
  heading(
    upper(text(size: textSize, weight: "bold", children)),
    level: 1,
    numbering: if (numbering) {
      (..nums) => text(
        size: textSize,
        weight: "bold",
        prefixh1 + " " + nums.pos().map(str).join(".") + ".",
      )
    } else {
      none
    },
  )
}

/**
 * Creates a level 2 (section) heading with consistent styling.
 * Includes automatic numbering based on document hierarchy.
 *
 * @param children - The content/text of the heading
 * @returns A formatted level 2 heading with appropriate spacing
 */
#let h2(children) = {
  block(inset: (top: (0.5 * textSize)))
  heading(
    level: 2,
    numbering: (..nums) => text(size: textSize, weight: "bold", nums.pos().map(str).join(".") + "."),
    text(size: textSize, weight: "bold", children),
  )
 
  // par("")
}

/**
 * Creates a level 3 (subsection) heading with consistent styling.
 * Uses italic styling and indented numbering.
 *
 * @param children - The content/text of the heading
 * @returns A formatted level 3 heading with appropriate styling and spacing
 */
#let h3(children) = {
  block(inset: (top: -(0.5* textSize)))
  heading(
    level: 3,
    numbering: (..nums) => text(
      size: textSize,
      style: "italic",
      weight: "regular",
      h(1cm) + nums.pos().map(str).join(".") + ".",
    ),
    text(size: textSize, style: "italic", weight: "regular", children),
    
  )
}

/**
 * Creates a level 4 (sub-subsection) heading with consistent styling.
 * Similar to h3 but at a lower heading level in the hierarchy.
 *
 * @param children - The content/text of the heading
 * @returns A formatted level 4 heading with appropriate styling and spacing
 */
#let h4(children) = {
  block(inset: (top: -(0.5 * textSize)))
  heading(
    level: 4,
    numbering: (..nums) => text(
      size: textSize,
      style: "italic",
      weight: "regular",
      h(1cm) + nums.pos().map(str).join(".") + ".",
    ),
    text(size: textSize, style: "italic", weight: "regular", children),
    
  )
}

/**
 * Inserts an image with proper formatting and optional caption.
 * Automatically looks for images in the "images/" directory.
 *
 * @param src - The image filename (without the "images/" path)
 * @param cap - Caption text (default: empty string)
 * @param width - Image width as percentage of container (default: 100%)
 * @returns A figure containing the image with appropriate styling
 */
#let img(src, cap: "", width: 100%) = {
  src = "images/" + src
  figure(
    [
      #block(inset: (top: 0pt))
      #image(src, width: width)
      #block(inset: (top: -(1 * textSize)))
    ],
    caption: cap,
    supplement: "Hình",
  )
}

/**
 * Creates a formatted table with optional caption.
 *
 * @param fields - Table content and formatting options
 * @param cap - Caption text or false if no caption (default: false)
 * @returns A styled table with optional figure caption
 */
#let tabl(..fields, cap: false) = {
  if type(cap) == str {
    block(inset: (top: -(2 * textSize)))
    figure(placement: none, caption: cap, supplement: "Bảng", table())
    block(inset: (top: -(1 * textSize)))
  }
  table(inset: 10pt, align: left, ..fields)
}
