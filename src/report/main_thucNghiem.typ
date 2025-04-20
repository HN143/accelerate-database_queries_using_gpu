#import "template.typ": *
#import "util.typ": *
#import "state.typ": bib_state, bib
#import "cover.typ": *

#bib_state.update(none)

#show: template

#cover()
#cover(border: false)

// --- set page number
#set page(numbering: "1")
#counter(page).update(1)

#include "thucNghiem.typ"

#bib