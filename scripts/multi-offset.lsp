;; multi-offset.lsp - Offset one object several distances at once
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
