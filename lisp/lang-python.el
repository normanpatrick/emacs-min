;;; lang-python.el --- Python behavior from the old config -*- lexical-binding: t; -*-

(defun minimal-python-mode-setup ()
  "Restore the old Python mode behavior."
  (outline-minor-mode 1))

(add-hook 'python-mode-hook #'minimal-python-mode-setup)

(provide 'lang-python)

;;; lang-python.el ends here
