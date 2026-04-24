;;; minimal-custom.el --- Custom settings for the minimal config

(custom-set-variables
 '(background-color "#ffffd7")
 '(background-mode light)
 '(column-number-mode t)
 '(cursor-color "#626262")
 '(custom-enabled-themes '(hc-zenburn))
 '(custom-safe-themes
   '("bcc6775934c9adf5f3bd1f428326ce0dcd34d743a92df48c128e6438b815b44f" "29fb9b438b9815a8adae59cd1c4378f78f5f17f2f7d4714953710b8a4a7de793" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default))
 '(fci-rule-color "#5E5E5E")
 '(fill-column 84)
 '(foreground-color "#626262")
 '(global-hl-line-mode t)
 '(show-trailing-whitespace t))

(custom-set-faces
 '(default ((t (:family "Inconsolata" :height 110))))
 '(mode-line-inactive ((t (:inherit mode-line :background "gray98" :foreground "#708183" :inverse-video t :box nil :underline nil :slant normal :weight normal)))))

;;; minimal-custom.el ends here
