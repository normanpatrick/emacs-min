;;; lang-c-cpp.el --- C/C++ behavior from the old config -*- lexical-binding: t; -*-

(setq c-default-style "linux"
      c-basic-offset 4)

(defun minimal-c-cpp-mode-setup ()
  "Restore the old C/C++ mode behavior."
  (outline-minor-mode 1))

(add-hook 'c-mode-hook #'minimal-c-cpp-mode-setup)
(add-hook 'c++-mode-hook #'minimal-c-cpp-mode-setup)

(provide 'lang-c-cpp)

;;; lang-c-cpp.el ends here
