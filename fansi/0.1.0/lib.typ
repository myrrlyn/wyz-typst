#import "@preview/meander:0.3.0"

// ANSI Z535.1-2022 according to the actual document I found online.
// https://www.nema.org/docs/default-source/standards-document-library/ansi-z535_1-2022-contents-and-scope.pdf?sfvrsn=5dcd1c32_1
// https://www.scribd.com/document/705719130/ANSI-Z535-1-2017-SAFETY-COLOR
#let ansi = (
  red:    color.rgb("#c8102e"), // Pantone 186 C, Munsell 7.5 R, 4.0/14
  orange: color.rgb("#ff8200"), // Pantone 151 C, Munsell 5.0YR, 6.0/15
  yellow: color.rgb("#ffd100"), // Pantone 109 C, Munsell 5.0Y, 8.0/12
  green:  color.rgb("#007b5f"), // Pantone 335 C, Munsell 7.5G, 4.0/9
  blue:   color.rgb("#0072ce"), // Pantone 285 C, Munsell 2.5PB, 3.5/10
  purple: color.rgb("#6d2077"), // Pantone 259 C, Munsell 10.0P, 4.5/10
  white:  color.rgb("#e7e6e2"), // Munsell N 9.0/
  black:  color.rgb("#2c2a29"), // Pantone Process Black C, Munsell N 1.5/
)

// ISO 3864
#let iso = (
  red:   color.rgb("#9b2423"),
  orange:color.rgb("#d05d29"),
  yellow:color.rgb("#f9a900"),
  green: color.rgb("#237f52"),
  blue:  color.rgb("#005387"),
  purple: ansi.purple, // 3864 doesn't spec a purple
  white: color.lighten(color.rgb("#ecece7"), 4%),
  black: color.darken(color.rgb("#2b2b2c"), 8%),
)

#let striping(primary, secondary, size, stripe-dir: ltr) = tiling(
  size: (size * 2, size * 2),
  // rotate(angle)
  [
  #place(square(fill: secondary, size: size * 2))
  #if stripe-dir == ltr or stripe-dir == btt {
    place(polygon(fill: primary, (0pt, size), (0pt, 0pt), (size, 0pt)))
    place(polygon(fill: primary, (0pt, size * 2), (size * 2, 0pt), (size * 2, size), (size, size * 2)))
  } else {
    place(polygon(fill: primary, (0pt, size), (0pt, size * 2), (size, size * 2)))
    place(polygon(fill: primary, (0pt, 0pt), (size * 2, size * 2), (size * 2, size), (size, 0pt)))
  }
]
)

#let signage(..ctx) = {
  let signage-box(primary, secondary,
    size: 12pt, icon: none, stroke-join: auto,
    stripe-dir: ltr, content, ..args
  ) = rect(
    inset: size,
    fill: color.transparentize(primary, 80%),
    stroke: stroke(
      paint: striping(primary, secondary, size, stripe-dir: stripe-dir),
      thickness: size,
      join: stroke-join,
    ),
    ..args,
    box(meander.reflow({
      if icon != none { meander.placed(top + left, icon) }
      meander.container()
      meander.content(content)
    }))
  )
  (
    // red:    (theme,  ..args) => signage-box(theme.red,    theme.white, ..ctx, ..args),
    // orange: (theme,  ..args) => signage-box(theme.orange, theme.black, ..ctx, ..args),
    // yellow: (theme,  ..args) => signage-box(theme.yellow, theme.black, ..ctx, ..args),
    // green:  (theme,  ..args) => signage-box(theme.green,  theme.white, ..ctx, ..args),
    // blue:   (theme,  ..args) => signage-box(theme.blue,   theme.white, ..ctx, ..args),
    // purple: (theme,  ..args) => signage-box(theme.purple, theme.white, ..ctx, ..args),
    custom: (fg, bg, ..args) => signage-box(fg,           bg,          ..ctx, ..args),
    ansi: (
      red:    (..args) => signage-box(ansi.red,    ansi.white, ..ctx, ..args),
      orange: (..args) => signage-box(ansi.orange, ansi.black, ..ctx, ..args),
      yellow: (..args) => signage-box(ansi.yellow, ansi.black, ..ctx, ..args),
      green:  (..args) => signage-box(ansi.green,  ansi.white, ..ctx, ..args),
      blue:   (..args) => signage-box(ansi.blue,   ansi.white, ..ctx, ..args),
      purple: (..args) => signage-box(ansi.purple, ansi.white, ..ctx, ..args),
    ),
    iso: (
      red:    (..args) => signage-box(iso.red,    iso.white, ..ctx, ..args),
      orange: (..args) => signage-box(iso.orange, iso.black, ..ctx, ..args),
      yellow: (..args) => signage-box(iso.yellow, iso.black, ..ctx, ..args),
      green:  (..args) => signage-box(iso.green,  iso.white, ..ctx, ..args),
      blue:   (..args) => signage-box(iso.blue,   iso.white, ..ctx, ..args),
      purple: (..args) => signage-box(iso.purple, iso.white, ..ctx, ..args),
    ),
  )
}

#let iso7010(..ctx) = for name in (
  "e001", "e002", "e003", "e004", "e005", "e006", "e007", "e008", "e009", "e010",
  "e011", "e012", "e013", "e014", "e015", "e016", "e017", "e018", "e019", "e020",
  "e021", "e022", "e023", "e024", "e025", "e026", "e027", "e028", "e029", "e030",
  "e031", "e032", "e033", "e034", "e035", "e036", "e037", "e038", "e039", "e040",
  "e041", "e042", "e043", "e044", "e045", "e046", "e047", "e048", "e049", "e050",
  "e051", "e052", "e053", "e054", "e055", "e056", "e057", "e058", "e059", "e060",
  "e061", "e062", "e063", "e064", "e065",         "e067", "e068", "e069", "e070",
          "e072", "e073", "e074", "e075", "e076",
  "f001", "f002", "f003", "f004", "f005", "f006", "f007", "f008", "f009", "f010",
  "f011", "f012", "f013", "f014", "f015", "f016", "f017", "f018", "f019",
  "m001", "m002", "m003", "m004", "m005", "m006", "m007", "m008", "m009", "m010",
  "m011", "m012", "m013", "m014", "m015", "m016", "m017", "m018", "m019", "m020",
  "m021", "m022", "m023", "m024", "m025", "m026", "m027", "m028", "m029", "m030",
  "m031", "m032", "m033", "m034", "m035", "m036", "m037", "m038", "m039", "m040",
  "m041", "m042", "m043", "m044", "m045", "m046", "m047", "m048", "m049", "m050",
  "m051", "m052", "m053", "m054", "m055", "m056", "m057", "m058", "m059", "m060",
  "m061", "m062",                                         "m068", "m069", "m070",
  "m071", "m072",
  "p001", "p002", "p003", "p004", "p005", "p006", "p007", "p008", "p009", "p010",
  "p011", "p012", "p013", "p014", "p015", "p016", "p017", "p018", "p019", "p020",
  "p021", "p022", "p023", "p024", "p025", "p026", "p027", "p028", "p029", "p030",
  "p031", "p032", "p033", "p034", "p035", "p036", "p037", "p038", "p039", "p040",
  "p041", "p042", "p043", "p044", "p045", "p046", "p047", "p048", "p049", "p050",
  "p051", "p052", "p053", "p054", "p055", "p056", "p057", "p058", "p059", "p060",
  "p061", "p062", "p063", "p064", "p065", "p066", "p067", "p068", "p069", "p070",
  "p071", "p072", "p073", "p074", "p075",                                 "p080",
  "p081",
  "w001", "w002", "w003", "w004", "w005", "w006", "w007", "w008", "w009", "w010",
  "w011", "w012", "w013", "w014", "w015", "w016", "w017", "w018", "w019", "w020",
  "w021", "w022", "w023", "w024", "w025", "w026", "w027", "w028", "w029", "w030",
  "w031", "w032", "w033", "w034", "w035", "w036", "w037", "w038", "w039", "w040",
  "w041", "w042", "w043", "w044", "w045", "w046", "w047", "w048", "w049", "w050",
  "w051", "w052", "w053", "w054", "w055", "w056", "w057", "w058", "w059", "w060",
  "w061", "w062", "w063", "w064", "w065", "w066", "w067", "w068", "w069", "w070",
  "w071", "w072", "w073", "w074", "w075", "w076", "w077", "w078", "w079", "w080",
                                                  "w087", "w088", "w089",
) {
  ((name): (..args) => image(
    "assets/" + name + ".svg",
    alt: "ISO-7010 icon " + name,
    ..ctx,
    ..args,
  ),)
}
