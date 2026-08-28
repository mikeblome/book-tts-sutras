# Roadmap

- [x] Make sure we get line breaks working as expected
  - [x] Verse and poetry should have line breaks after each line
  - [x] Implemented a global rule in `style.typ` to treat newlines as line breaks.
- [x] Concentrate on making this beautiful typography. 
  - [x] Large, legible type with Libertinus Serif and Noto CJK.
  - [x] Lots of negative space and narrow paper size for verse.
  - [x] Ligatures and kerning enabled.
- [x] Always make sure we have all three outputs building successfully: 
  1. the print PDF (with no percussion annotations and no ino notes) 
  2. the Ino PDF (with percussion annotations and ino notes) 
  3. the HTML (with no ino annotations and no ino notes) 
- [x] Ensure that Chinese characters are displaying correctly 
  - [x] Increased size significantly (tripled) for legibility.
- [x] Ensure that the HTML version has a sidebar which toggles on and off various elements: 
  - [x] Toggle on/off chinese characters
  - [x] Toggle on/off ino annotations
  - [x] Toggle on/off hyperlinks to explanatory notes
- [x] Add a table of contents to the beginning
- [x] Change the paper size to something more narrow, for verse 
- [x] Use proper citations for the book sources listed in the footnotes 
- [x] Create [Hyragriva YAML entries](https://github.com/typst/hayagriva/blob/main/docs/file-format.md) for each book mentioned in a citation
- [x] Regularize all spellings, following editorial conventions listed in the README
- [x] Add a bibliography at the end
- [x] Add more explanatory notes to the notes: we want to explain sanskrit, chinese, and japanese terms like _prajna paramita_ and _skandhas_ and everything else
  - [x] In the HTML version, automated hyperlinks to the glossary.
  - [x] Toggle-able via the sidebar.
- [x] Add github action based on nix which runs make and has all the requisite tools installed
- [x] Fix bibliography. On page 47 of "Ino Book 2023.pdf" there is a list of sources. Make sure each text with a source has a related bibliographic entry. 
- [x] Fix ruby text display: the ruby annotations above chinese characters don't have enough whitespace around them to be readable as syllables. Find a way to give these enough space and also make the chinese character spacing consistent. How does latex do it? Find a way to make it beautiful. 
- [x] Add in missing sections from PDF
- [x] Add title page
- [x] Make some things into includes. The Jukai ceremony includes Ti-Sarana and Purification, for example. Rather than just copy-paste let's write a function that includes it elsewhere. 
- [x] Make yourself a skill for good design and typography, based on https://github.com/nutlope/hallmark and other design skillsets, but geared for Typst. Then apply this skill to revising the book. 
- [x] Proofread everything

### Page-by-Page Typographic Review TODOs
- [x] **Font Pairing & Body Font**: Upgrade primary body font to **EB Garamond** and display headings to **Libertinus Serif Display**, paired with **Noto Serif CJK JP**.
- [x] **Page Numbers & Pagination**: Enable page numbering in Typst (`#set page(numbering: "1")`) and position page numbers consistently in alternating footers.
- [x] **Front Matter Page Numbering**: Suppress page numbers on the Title Page (p. 1) and Table of Contents (pp. 2–3), starting page numbers on "Opening Recitations".
- [x] **Facing Page Binding**: Set `#set page(binding: left)` in `style.typ` so inside/outside margins flip correctly across facing pages (recto/verso).
- [x] **Running Headers**: Add running headers (e.g., book title on verso, recitations title on recto) with a subtle horizontal rule.
- [x] **CJK & Serif Harmony**: Switch CJK font from `Noto Sans CJK JP` to `Noto Serif CJK JP` so Chinese characters harmonize optically with EB Garamond body text.
- [x] **CJK Character Weight**: Set regular font weight for CJK text and ruby annotations.
- [x] **Ruby Text Line-Wrap**: Prevent orphan Romaji ruby syllables by keeping ruby blocks grouped within non-breaking box units.
- [x] **Footnote Citation Parens**: Remove redundant parens in footnote citations using prose citation mode `#cite(<key>, form: "prose")`.
- [x] **Footnote Entry Spacing**: Format footnote entry spacing and leading in the footer.
- [x] **H1 Heading Wraps**: Fix awkward line breaking in long H1 headers with balanced font sizing.
- [x] **Recto Chapter Starts**: Set major section breaks to start on odd (recto) pages (`pagebreak(to: "odd")`).
- [x] **Table of Contents Styling**: Format level-1 chapter titles in bold with extra top spacing in the TOC.
- [x] **Bibliography Hanging Indents**: Set Chicago author-date hanging indents for bibliography entries.
- [x] **Sesshin Dedication Phonetics**: Clean up capitalization and diacritics in phonetic guides on page 14 (e.g., `prajāpati`, `kīrti`, `chāra`, `kapilāni`).

## Completed Tasks
- [x] Bibliography and Hayagriva setup.
- [x] Glossary with automated linking and state management (to avoid linking within the glossary itself).
- [x] HTML Sidebar with comprehensive toggles.
- [x] Narrow format (125mm x 200mm) for portable verse books.
- [x] Regularized IAST and Pinyin spellings throughout.
- [x] Native HTML `<ruby>` tag support for the web version.
- [x] Fixed all-caps in H1 headers.
- [x] Tripled size of Chinese characters and Ruby text.
- [x] Global newline-to-linebreak rule for verse-heavy content.

## New Tasks
 - [x] Ensure that we have reasonable spacing between paragraphs
 - [x] Fix unusual spacing in table of contents: Ti-Sarana, Vandana, On Opening the Dharma, and more, (find them!) have uneven spacing before their entries in the table of contents 
 - [x] The ruby annotations (romaji above the chinese characters) needs to be way bigger 
 - [x] We need a Chinese character (Japanese) translation of Shiku Seigan Mon. Also is that Shigu or Shiku? 
 - [x] Everything that can be bigger on the page should be. For example, the romaji above the chinese characters in Shiku Seigan Mon 
 - [x] Cases where there are a single line on a page should be merged with the previous page, or the font size should be adjusted so that there are at least two lines on the page. Page 13 is one
 - [x] Cases where there is "Leader:" and "Assembly" should be indented a little to indicate that they are said by those people
 - [x] "in gassho" should always be centered under the sutra
 - [x] Let's not have footnotes appear after the first word. Instead maybe we can move away from footnotes entirely and just have a Sources section 
 - [x] Places like Dedication (page 24) which only have a few lines and then only a few lines on the next page should be made into their own page 
 - [x] Is Song of Enlightenment and others just one stanza? Why does it look like just one stanza? 
 - [x] Song of the Grass-Roof Hermitage should start on its own page, same with Verse of the Faith-Mind and Discourse on Love and Discourse on Happiness. 
 - [x] In the Jukai Ceremony, "Assembly" is not a heading, it's who says it 
 - [x] Starting on page 66, there should be some space between Roshi, Initiate, etc. 
 - [x] In the Glossary the terms should be in italics or something to show that they're a term 
 - [x] The DIscourse on Happiness is also missing stanza breaks 
 - [x] Let's not have style in the actual text. Style should be in style.typ or lib.typ. Similarly let's not have any text in sutra_book.typ. If we need a new function, like for subtitles, as in Dharani for Dispelling Misfortune, let's make a new function "subtitles" which makes it centered and smaller type. Never do something like ` #align(center, text(style: "italic", size: 0.95em)[(Dharani for Dispelling Misfortune)])` because that mixes style and content. 
 - [x] Let's have a function like under_title_note() note which can handle things like "in gassho" so that we don't have to center it each time 
