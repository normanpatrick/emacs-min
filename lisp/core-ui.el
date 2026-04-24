;;; core-ui.el --- Minimal UI defaults -*- lexical-binding: t; -*-

(add-to-list 'custom-theme-load-path
             (expand-file-name "themes" minimal-config-root))

(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(setq visible-bell t)
(setq ring-bell-function #'ignore)

(show-paren-mode 1)
(column-number-mode 1)
(when (fboundp 'global-hl-line-mode)
  (global-hl-line-mode 1))

;; Match the old config's fuzzy file and buffer completion behavior.
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)
(setq ido-save-directory-list-file
      (expand-file-name "ido.last" minimal-config-root))
(ido-mode 1)

;; Restore snippet expansion from the vendored yasnippet package.
(let ((yas-dir (expand-file-name "vendor/yasnippet-20140911.312" minimal-config-root)))
  (when (file-directory-p yas-dir)
    (add-to-list 'load-path yas-dir)
    (require 'yasnippet)
    (setq yas-snippet-dirs
          (delq nil
                (list (expand-file-name "snippets" minimal-config-root)
                      (expand-file-name "snippets" yas-dir))))
    (yas-global-mode 1)))

;; Keep startup quiet.
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

(when (member 'hc-zenburn (custom-available-themes))
  (load-theme 'hc-zenburn t))

(provide 'core-ui)

;;; core-ui.el ends here
