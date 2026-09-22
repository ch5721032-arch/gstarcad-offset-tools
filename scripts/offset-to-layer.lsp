;; offset-to-layer.lsp - Offset a copy straight onto the current layer
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
