# myrrlyn’s Typst warehouse

I'm using [Typst] for some of my writing where I don't need media other than
text and images. Strictly speaking, [PDFs support multimedia][0], but Typst
doesn't currently have a way to create those elements. Since almost none of my
creative work needs those constraints, but I _do_ want to do more than what
Markdown/HTML offers (that I know how to accomplish), Typst is a nice second
engine to learn.

At time of writing, this only contains the workplace safety-themed callout boxes
I use on my blog, in the `fansi` package.

## Installation

This repository is a Typst package namespace. See [the Typst Package guide][1]
for up-to-date instructions.

```sh
cd $XDG_DATA_HOME/typst/packages
git clone https://github.com/myrrlyn/wyz-typst wyz
# don't include "-typst" in the namespace -----^^^
```

The packages in this repository then become available as

```typ
#import "@wyz/<package>:<version>"
```

[0]: https://helpx.adobe.com/acrobat/using/playing-video-audio-multimedia-formats.html
[1]: https://github.com/typst/packages?tab=readme-ov-file#local-packages
[Typst]: https://typst.app/
