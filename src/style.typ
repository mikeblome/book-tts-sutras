
// Read options from command line
#let show-ino = sys.inputs.at("show-ino-notation", default: "false") == "true"

#let project(body) = [
  // Set fonts and basic text properties
  #set text(
    font: ("EB Garamond 12", "Noto Serif CJK JP", "Libertinus Serif"),
    size: 11.5pt,
    weight: "regular",
    ligatures: true,
    kerning: true,
  )

  // Bibliography style: Chicago Manual of Style
  #set bibliography(style: "chicago-author-date")

  // Paper size, binding & geometry
  #set page(
    paper: "a5",
    margin: (inside: 20mm, outside: 15mm, top: 22mm, bottom: 22mm),
    binding: left,
    header: context {
      let page_num = counter(page).get().first()
      if page_num > 3 {
        let is_even = calc.even(page_num)
        if is_even {
          align(left, text(size: 8.5pt, style: "italic", fill: luma(100))[Three Treasures Sangha Sutra Book])
        } else {
          align(right, text(size: 8.5pt, style: "italic", fill: luma(100))[Zenkai and Sesshin Recitations])
        }
        v(0.3em)
        line(length: 100%, stroke: 0.4pt + luma(180))
      }
    },
    footer: context {
      let page_num = counter(page).get().first()
      if page_num > 3 {
        let is_even = calc.even(page_num)
        if is_even {
          align(left, text(size: 9pt, fill: luma(80))[#page_num])
        } else {
          align(right, text(size: 9pt, fill: luma(80))[#page_num])
        }
      }
    }
  )

  // Typography settings
  #set par(
    leading: 0.55em,
    justify: false, // Poetry shouldn't be justified
  )
  #show par: it => block(below: 1.2em, it)

  // Outline / TOC styling
  #show outline.entry: it => {
    // Strip all percussion symbols and leading spaces from TOC entries
    show regex("([△▲○●×])([¹²³]*)"): ""
    show regex("^\s+"): ""
    it
  }

  #show outline.entry.where(level: 1): it => {
    v(1.0em, weak: true)
    strong(text(size: 1.05em, it))
  }
  #show outline.entry.where(level: 2): it => {
    v(0.35em, weak: true)
    it
  }

  // Bibliography hanging indent
  #show bibliography: set par(hanging-indent: 2em, justify: true)

  // Description list / glossary term styling (ensure CJK in terms uses regular weight)
  #show terms.item: it => [
    #block(below: 0.8em)[
      #text(weight: "regular")[#it.term]: #it.description
    ]
  ]

  // Footnote entry styling
  #show footnote.entry: set par(spacing: 0.8em, leading: 0.55em)

  // Heading styles for elegant book design
  #show heading.where(level: 1): it => {
    pagebreak(to: "odd", weak: true)
    v(1.5em)
    align(center, text(size: 1.6em, weight: "bold", font: "Libertinus Serif Display", it.body))
    v(1.2em)
  }

  #show heading.where(level: 2): it => {
    v(1.6em, weak: true)
    block(width: 100%, align(center, text(size: 1.35em, weight: "bold", font: "Libertinus Serif Display", it.body)))
    v(1.4em, weak: true)
  }

  #show heading.where(level: 3): it => {
    v(1.0em, weak: true)
    block(width: 100%, align(center, text(size: 1.1em, weight: "regular", style: "italic", it.body)))
    v(0.6em, weak: true)
  }

  // Don't show ino percussion annotation if not desired; normalize spacing when hidden
  #show regex("([ \t]*)([△▲○●×])([¹²³]*)([ \t]*)"): it => {
    if show-ino { 
      text(fill: rgb("#b22222"), it) // Firebrick red
    } else { 
      " " 
    }
  }

  #body
]

