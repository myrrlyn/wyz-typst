#import "lib.typ"

#set document(author: "myrrlyn", title: [fansi Typst Package])

#set page(paper: "a4")

#let fonts = (
  "Iosevka Etoile",
  "Iosevka Aile",
  "Roboto Slab",
  "Roboto Serif",
  "HK Grotesk",
  "IBM Plex Serif",
  "Cambria",
  "Inconsolata",
)

#set text(
  font: fonts,
  lang: "en",
  region: "US",
  hyphenate: true,
  kerning: true,
  ligatures: true,
  discretionary-ligatures: false,
  historical-ligatures: false,
  slashed-zero: true,
  // fractions: true,
)

#show link: it => underline(text(fill: blue, it))

#show raw: it => text(
  font: ("Iosevka NF", "Iosevka", "Roboto Mono", "Cascadia Code"),
  size: 1.2em,
  it
)

#let w(disp, href: none) = link(
  if href == none {
    "https://en.wikipedia.org/wiki/" + str.replace(disp, " ", "_")
  } else { href },
  disp,
)

#align(center, text(size: 4em)[= F#h(-8pt)AN#h(-3pt)S#h(-2pt)I])
// #align(center, text(size: 4em)[= F A N S I])

This package provides styles modeled after #w("ISO 3864"), #w("ISO 7010"), and
#w("ANSI Z535").

#(lib.signage().ansi.red)(icon: (lib.iso7010(height: 3em).p080)())[
  *I HAVE NOT PURCHASED THESE STANDARDS. I DO NOT CLAIM THAT DOCUMENTS WRITTEN
  USING THIS PACKAGE ARE STYLISTICALLY IN CONFORMANCE WITH THEM. I JUST LIKE THE
  AESTHETIC.*
]

That box uses stripes as shown on the 3864 Wikipedia page, an icon taken from
the 7010 Wikipedia page, and the color-scheme taken from a free preview of the
Z535 document I found online somewhere. You'd think that the ISO 7010 icon set
would use the ISO 3864 color scheme, but they don't. They don't use ANSI Z535
colors either, but they're close enough that _I_ can't see the difference,
anyway.

Maybe in the future I'll go normalize colors.

== Installation

See #link(
  "https://github.com/typst/packages?tab=readme-ov-file#local-packages"
)[the Typst Packages README] for up-to-date information.

This repository is an entire Typst namespace. Clone it into your Typst package
directory as specified at that link:

```shell-unix-generic
cd $XDG_DATA_HOME/typst/packages
git clone https://github.com/myrrlyn/wyz-typst wyz
```

It will then become available in your Typst environments as:

```typ
#import "@wyz/fansi:0.1.0"
```

== Usage

The primary exports are the `signage()` and `iso7010()` functions. These are
closures which capture their arguments and make them available to all items
stored in the dictionary that they return.

This behavior is useful for allowing you to quickly override settings. I don't
know how to receive `show` or `set` rules into a package yet.

The dictionaries returned from these functions are full of element-producing
functions. Invoke _those_ functions to produce content on the page.

Secondary exports are the `.ansi` and `.iso` dictionaries. These are the color
palettes of their eponymous standards:

#let color-cell = (it, fill) => table.cell(fill: it, text(fill: fill, raw(it.to-hex())))

#table(
  columns: 3,
  row-gutter: 2pt, column-gutter: 2pt,
  inset: 0.5em,
  table.header([], [ANSI Z535], [ISO 3864]),
  [`.red`], color-cell(lib.ansi.red, lib.ansi.white), color-cell(lib.iso.red, lib.iso.white),
  [`.orange`], color-cell(lib.ansi.orange, lib.ansi.black), color-cell(lib.iso.orange, lib.ansi.black),
  [`.yellow`], color-cell(lib.ansi.yellow, lib.ansi.black), color-cell(lib.iso.yellow, lib.ansi.black),
  [`.green`], color-cell(lib.ansi.green, lib.ansi.white), color-cell(lib.iso.green, lib.iso.white),
  [`.blue`], color-cell(lib.ansi.blue, lib.ansi.white), color-cell(lib.iso.blue, lib.iso.white),
  [`.purple`], color-cell(lib.ansi.purple, lib.ansi.white), color-cell(lib.iso.purple, lib.iso.white),
  [`.black`], color-cell(lib.ansi.black, lib.ansi.white), color-cell(lib.iso.black, lib.iso.white),
  [`.white`], color-cell(lib.ansi.white, lib.ansi.black), color-cell(lib.iso.white, lib.iso.black),
  table.footer([], [`#fansi.ansi`], [`#fansi.iso`]),
)

=== Callout Boxes

The boxes are provided through the `signage` function. This function accepts an
argument-list, which it snapshots and forwards to all the functions held inside
the dictionary it returns. The keys of the dictionary are `custom`, `ansi`, and
`iso`. The `ansi` and `iso` keys are dictionaries of six functions each: `red`,
`orange`, `yellow`, `green`, `blue`, and `purple`. These six functions, and
`custom`, produce `rect`s with striped borders as shown above. The `custom`
function takes two arguments, its primary and secondary colors, while the other
six produce boxes colored according to their names, using either ANSI Z535 or
ISO 3864 as their color palette.

Custom arguments captured by the `rect` generator are:

- `size`: the width of the striped border. Defaults to `12pt`.
- `icon`: if present, becomes an element in the top left corner of the contents.
  Expected, but not required, to be one of the ISO 7010 images also available in
  this package.
- `stroke-join`: Forwarded to the `rect`angle's `stroke()` property.
- `stripe-dir`: Forwarded to the striping generator. Controls whether the
  stripes are SW/NE (default, `ltr`, `btt`) or NW/SE (`rtl`, `ttb`).

All other arguments are passed to `rect()` as-is.

#pagebreak()

#grid(columns: (2fr, 1fr), row-gutter: 1.5em, align(horizon)[
  ```typ
  #(fansi.signage().ansi.purple)[inner text]
  ```
], (lib.signage().ansi.purple)[inner text], [
  ```typ
  #let bsg = fansi.signage(stroke-join: "bevel").iso
  #let icns = fansi.iso7010(height: 1em)
  #(bsg.yellow)(icon: (icns.w003)(), align(center)[
    #v(4pt)
    *#emoji.siren RADIOLOGICAL ALARM #emoji.siren*

    Text that passes the icon flows around it.
  ])
  ```
], align(horizon, (lib.signage(stroke-join: "bevel").iso.yellow)(
    icon: (lib.iso7010(height: 3em).w003)(),
    align(center)[
      #v(4pt) *#emoji.siren RADIOLOGICAL ALARM #emoji.siren*

    Text that passes the icon flows around it.
    ]
  ))
)

#let wb = gradient.linear(angle: 45deg, color.white, color.black).sharp(2)

From here on, elements are shown against full-white and full-black backgrounds
to illustrate how they appear in both light and dark settings.

#let color-cell = it => (
  table.cell(fill: wb, (lib.signage(outset: 0em).ansi.at(it))[]),
  table.cell(fill: wb, (lib.signage(outset: 0em).iso.at(it))[]),
)

#table(
  columns: 3,
  column-gutter: 0.5em,
  row-gutter: 0.5em,
  align: center + horizon,
  inset: 1em,
  table.header([Color], [ANSI Z535], [ISO 3864]),
  [`.red`], ..color-cell("red"),
  [`.orange`], ..color-cell("orange"),
  [`.yellow`], ..color-cell("yellow"),
  [`.green`], ..color-cell("green"),
  [`.blue`], ..color-cell("blue"),
  [`.purple`], ..color-cell("purple"),
  [`.custom`], table.cell(colspan: 2, fill: wb, (lib.signage().custom)(
    color.maroon, color.olive,
    [or bring your own colors]
  )),
  table.footer([], [`#fansi.signage().ansi`], [`#fansi.signage().iso`])
)

The boxes have a mostly-transparent fill of their primary color.

=== ISO 7010 Icons

- `.eNNN`: green background, white foreground, square, thin white border
- `.fNNN`: red background, white foreground, square, thin white border (except
  `.f019`)
- `.mNNN`: blue background, white foreground, circular, no border
- `.pNNN`: white background, black foreground, circular, thick red negation
  overlay (border and slash)
- `.wNNN`: yellow background, black foreground, triangular, moderate black
  border

There are no orange or purple icons.

Icons are held in the dictionary returned by `#fansi.iso7010()`.

#grid(
  columns: 10,
  row-gutter: 4pt,
  column-gutter: 4pt,
  // stroke: 0.5pt + black,
  ..for (name, icn) in lib.iso7010() {
    (box[
      #box(fill: wb, inset: 4pt, icn())
      #v(-1em)
      #align(center, raw("." + name))
    ],)
  }
)

=== Just The Stripe

`#fansi.striping` is a function which produces the `tiling()` element used by
the signage boxes. It receives two color arguments, one size argument, and an
optional direction argument. It can be used anywhere a `tiling()` is, and has
the same behavior.

The direction (`stripe-dir`) defaults to `ltr`. When it is `ltr` or `btt`,
stripes run from southwest to northeast. When it is `rtl` or `ttb`, stripes
run from northwest to southeast.

The angle of the striping itself cannot be changed.

#grid(columns: (1fr, 1fr),
  [```typ
  #rotate(30deg, reflow: true,
    line(length: 15em,
      stroke: stroke(
        thickness: 12pt,
        paint: fansi.striping(
          black, white, 12pt
        ),
      ),
    )
  )
  ```], rotate(30deg, reflow: true, line(
    length: 15em, stroke: stroke(
      thickness: 12pt,
      paint: lib.striping(black, white, 12pt),
    )
  ))
)

If the `size` argument to `fansi.striping` is smaller than the short dimension
of the rectangle it fills, then the stripes will appear visually narrower. If it
is larger, they will be thicker.

#grid(columns: (1fr, 1fr), row-gutter: 1em,
  [```typ
  #line(length: 15em, stroke(
    thickness: 12pt,
    paint: fansi.striping(
      black, white, 6pt
    ),
  ))
  ```], align(horizon, line(length: 15em,
    stroke: stroke(
      thickness: 12pt, paint: lib.striping(black, white, 6pt),
    )
  )), [```typ
  #line(length: 15em, stroke(
    thickness: 12pt,
    paint: fansi.striping(
      black, white, 24pt, dir: rtl
    ),
  ))
  ```], align(horizon, line(length: 15em,
    stroke: stroke(
      thickness: 12pt, paint: lib.striping(black, white, 24pt, stripe-dir: rtl),
    )
  )),
)
