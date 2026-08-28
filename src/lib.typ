
// Functions we will import for use in the sutra book

#let in-glossary = state("in-glossary", false)
#let in-heading = state("in-heading", false)

// A helper macro to wrap any content in a classed <span> for JS to find.
#let classed-span(classname, content) = {
  if sys.inputs.at("target", default: "pdf") == "html" {
    html.elem("span", content, attrs: (class: classname))
  } else {
    content
  }
}

// A helper macro to wrap any content in a classed <div> for JS to find.
#let classed-block(classname, content) = {
  if sys.inputs.at("target", default: "pdf") == "html" {
    html.elem("div", content, attrs: (class: classname))
  } else {
    content
  }
}

// English Wrapper
#let eng(body) = {
  let content = text(lang: "en", style: "italic", body)
  classed-span("lang-en", content)
}

// Helper for glossary links (disabled within glossary and headings)
#let gloss-link(it, target) = {
  if sys.inputs.at("target", default: "pdf") == "html" {
    context {
      if in-glossary.get() or in-heading.get() {
        it
      } else {
        classed-span("glossary-link", link(target, it))
      }
    }
  } else {
    it
  }
}

// Helpers for subtitles and stage directions
#let under-title-note(body) = align(center, text(style: "italic", size: 0.95em, body))
#let subtitle(body) = align(center, text(style: "italic", size: 0.95em, body))
#let in-gassho() = under-title-note[in gassho]

// Helper for indented blocks that preserves content in HTML export
#let indented-block(body) = {
  if sys.inputs.at("target", default: "pdf") == "html" {
    classed-block("indented-block", body)
  } else {
    pad(left: 1.5em, body)
  }
}

// Standardized trilingual sutra title helper (English, Kanji, Romaji)
#let sutra-title(eng, kanji: none, romaji: none, bells: "") = {
  let show-ino-input = sys.inputs.at("show-ino-notation", default: "false") == "true"
  let is-html = sys.inputs.at("target", default: "pdf") == "html"
  
  if is-html {
    in-heading.update(true)
    heading(level: 2)[#eng]
    in-heading.update(false)

    if kanji != none or romaji != none {
      classed-block("sutra-subtitle", [
        #if kanji != none [#classed-span("lang-zh", kanji)]
        #if kanji != none and romaji != none [#classed-span("subtitle-bullet", [ • ])]
        #if romaji != none [#classed-span("lang-ro", romaji)]
      ])
    }
  } else {
    let title-text = if show-ino-input and bells != "" { bells + " " + eng } else { eng }
    heading(level: 2)[#title-text]
    if kanji != none or romaji != none {
      v(-0.2em)
      align(center)[
        #if kanji != none [#text(size: 1.05em, font: ("Noto Serif CJK JP", "Noto Serif CJK SC"))[#kanji]]
        #if kanji != none and romaji != none [ #text(size: 0.8em, fill: luma(120))[•] ]
        #if romaji != none [#text(size: 0.95em, style: "italic", font: ("EB Garamond 12", "Libertinus Serif"))[#romaji]]
      ]
      v(0.4em)
    }
  }
}

// Helper for liturgical speakers (distinctive display style for Roshi, Assembly, Initiate, etc.)
#let speaker(name) = {
  v(0.9em, weak: true)
  text(font: "Libertinus Serif Display", weight: "bold", style: "italic", size: 1.05em, fill: luma(40))[#name:]
}


// Helper for ruby annotations
#let above(word, top) = {
  let zh_size = 1.5em
  let ro_size = 1.15em

  if sys.inputs.at("target", default: "pdf") == "html" {
    html.elem("ruby", [
      #classed-span("lang-zh", text(size: zh_size, word))
      #html.elem("rt", classed-span("lang-ro", text(size: ro_size, weight: "semibold", top)))
    ])
  } else {
    box(
      inset: (x: 0.18em, y: 0pt),
      grid(
        columns: 1,
        gutter: 6pt,
        align: center + horizon,
        text(font: ("EB Garamond 12", "Libertinus Serif"), size: ro_size, weight: "semibold", top),
        text(font: ("Noto Serif CJK JP", "Noto Serif CJK SC"), weight: "regular", size: zh_size, word)
      )
    )
  }
}

// Helper for large ruby annotations (e.g. Four Infinite Vows)
#let above_large(word, top) = {
  let zh_size = 2.2em
  let ro_size = 1.4em

  if sys.inputs.at("target", default: "pdf") == "html" {
    html.elem("ruby", [
      #classed-span("lang-zh", text(size: zh_size, word))
      #html.elem("rt", classed-span("lang-ro", text(size: ro_size, weight: "semibold", top)))
    ])
  } else {
    box(
      inset: (x: 0.28em, y: 0pt),
      grid(
        columns: 1,
        gutter: 8pt,
        align: center + horizon,
        text(font: ("EB Garamond 12", "Libertinus Serif"), size: ro_size, weight: "semibold", top),
        text(font: ("Noto Serif CJK JP", "Noto Serif CJK SC"), weight: "regular", size: zh_size, word)
      )
    )
  }
}

#let zh_large(left, right) = {
  let left_array = left.text.split("|")
  let right_array = right.text.split("|")

  if left_array.len() != right_array.len() {
    panic("Ruby text has imbalanced sides.")
  }

  let ruby_content = {
    let sum_body = () 
    for i in range(left_array.len()) {
      sum_body += (
        above_large(
          text(right_array.at(i)),
          text(size: 1em, left_array.at(i))
        ),
      )
    }
    sum_body.join()
  }

  text(lang: "zh", ruby_content)
}

// Reusable helper macro for lineage names grid
#let lineage-names-grid(items) = {
  if sys.inputs.at("target", default: "pdf") == "html" {
    classed-block("lineage-grid", items.join(" "))
  } else {
    set text(size: 8.8pt)
    set par(leading: 0.38em)
    grid(
      columns: (auto, 1fr),
      column-gutter: 1.2em,
      row-gutter: 0.22em,
      ..items
    )
  }
}


#let ino_note(text_content) = {
  let show-ino-input = sys.inputs.at("show-ino-notation", default: "false") == "true"
  let is-html = sys.inputs.at("target", default: "pdf") == "html"
  
  let content = [
    #set text(fill: gray, size: 0.8em)
    *Note:* #text_content
  ]

  if is-html {
    classed-block("ino-note", content)
  } else if show-ino-input {
    content
  }
}

#let zh(left, right) = {
  let left_array = left.text.split("|")
  let right_array = right.text.split("|")

  if left_array.len() != right_array.len() {
    panic("Ruby text has imbalanced sides. Left: " + str(left_array.len()) + ", Right: " + str(right_array.len()))
  }

  let ruby_content = {
    let sum_body = () 
    for i in range(left_array.len()) {
      sum_body += (
        above(
          text(right_array.at(i)),
          text(size: 1em, left_array.at(i))
        ),
      )
    }
    sum_body.join()
  }

  text(lang: "zh", ruby_content)
}


#if sys.inputs.at("target", default: "pdf") == "html" [
  #html.elem("div", attrs: (class: "controls"), [
    #html.elem("h3", [Display Options])
    #html.elem("label", [
      #html.elem("input", attrs: (type: "checkbox", id: "show-zh", checked: "true"))
      Show Chinese
    ])
    #html.elem("label", [
      #html.elem("input", attrs: (type: "checkbox", id: "show-ro", checked: "true"))
      Show Romaji
    ])
    #html.elem("label", [
      #html.elem("input", attrs: (type: "checkbox", id: "show-en", checked: "true"))
      Show English
    ])
    #html.elem("label", [
      #html.elem("input", attrs: (type: "checkbox", id: "show-ino", checked: "true"))
      Show Ino Notes
    ])
    #html.elem("label", [
      #html.elem("input", attrs: (type: "checkbox", id: "show-links", checked: "true"))
      Show Links to Glossary
    ])
  ])
]

// This raw block injects the <script> tag into the final HTML file.
#if sys.inputs.at("target", default: "pdf") == "html" [
  #html.elem("script", attrs: (src: "interactivity.js"))
]
