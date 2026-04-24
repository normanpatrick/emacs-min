;;; core-editing.el --- Minimal editing defaults -*- lexical-binding: t; -*-

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default fill-column 84)

(fset 'yes-or-no-p #'y-or-n-p)

(delete-selection-mode 1)
(electric-pair-mode 1)
(winner-mode 1)

(setq cua-enable-cua-keys nil)
(cua-mode 1)

(setq recentf-max-saved-items 100)
(setq recentf-save-file (expand-file-name "recentf" minimal-config-root))
(setq savehist-file (expand-file-name "history" minimal-config-root))
(setq make-backup-files t)
(setq backup-by-copying t)

(savehist-mode 1)
(recentf-mode 1)

;; Store transient files outside project directories.
(defvar minimal-temporary-file-directory
  (expand-file-name (format "emacs-%s/" user-login-name) temporary-file-directory))

(make-directory minimal-temporary-file-directory t)

(setq backup-directory-alist
      `(("." . ,minimal-temporary-file-directory)
        (,tramp-file-name-regexp nil)))
(setq auto-save-file-name-transforms
      `((".*" ,minimal-temporary-file-directory t)))
(setq auto-save-list-file-prefix
      (expand-file-name ".auto-saves-" minimal-temporary-file-directory))

;; Use built-in line numbers when available.
(when (fboundp 'global-display-line-numbers-mode)
  (global-display-line-numbers-mode 1))

;; Avoid prompts on exit for live processes.
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

;; Keep encrypted files working out of the box.
(require 'epa-file)
(epa-file-enable)

(provide 'core-editing)

;;; core-editing.el ends here
