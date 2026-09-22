# GstarCAD Offset Tools

Offset one object by several distances in a single command, and offset copies straight onto the current layer.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Offsetting the same line four times at 5, 10, 20 and 50 is four trips through the same prompts. These commands offset one object by a whole list of distances in a single run, and place offset copies directly on the current layer so contours and clearances stay organised.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/multi-offset.lsp` | ;; multi-offset.lsp - Offset one object several distances at once
;; Command: MOFF
;; Usage: MOFF -> pick object -> pick side -> enter distances like 5,10,20
(defun c:MOFF ( / en side dlist d )
  (vl-load-com)
  (setq en (car (entsel "\nPick the object to offset: ")))
  (if en
    (progn
      (setq side (getpoint "\nPoint on the offset side: "))
      (setq dlist (getstring T "\nDistances (comma separated, e.g. 5,10,20): "))
      (if (and side (/= dlist ""))
        (progn
          (setq dlist (read (strcat "(" (vl-string-translate "," " " dlist) ")")))
          (foreach d dlist
            (if (numberp d)
              (command "_.OFFSET" d en side "")
            )
          )
          (princ "\nOffsets created.")
        )
      )
    )
  )
  (princ)
)
 |
| `scripts/offset-to-layer.lsp` | ;; offset-to-layer.lsp - Offset a copy straight onto the current layer
;; Command: OFFTOLAY
;; Usage: make the target layer current, then offset; the copy lands on that layer
(defun c:OFFTOLAY ( / en side d lay )
  (setq en (car (entsel "\nPick the object to offset: ")))
  (if en
    (progn
      (setq side (getpoint "\nPoint on the offset side: "))
      (setq d (getdist "\nOffset distance: "))
      (setq lay (getvar "CLAYER"))
      (if (and side d)
        (progn
          (command "_.OFFSET" d en side "")
          (command "_.CHPROP" (entlast) "" "_LA" lay "")
          (princ (strcat "\nOffset placed on layer " lay "."))
        )
      )
    )
  )
  (princ)
)
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
