;;; lang-go.el --- Go behavior from the old config -*- lexical-binding: t; -*-

(defun minimal-go-mode-setup ()
  "Restore the old Go mode bindings and formatting behavior."
  (when (fboundp 'gofmt-before-save)
    (add-hook 'before-save-hook #'gofmt-before-save nil t))
  (setq-local tab-width 4)
  (setq-local indent-tabs-mode 1)
  (setq-local outline-regexp
              "//\\.\\|//[^\r\n\f][^\r\n\f]\\|pack\\|func\\|impo\\|cons\\|var.\\|type\\|\t\t*....")
  (outline-minor-mode 1)
  (local-set-key (kbd "M-a") #'outline-previous-visible-heading)
  (local-set-key (kbd "M-e") #'outline-next-visible-heading))

(with-eval-after-load 'go-mode
  (add-hook 'go-mode-hook #'minimal-go-mode-setup))

(provide 'lang-go)

;;; lang-go.el ends here
