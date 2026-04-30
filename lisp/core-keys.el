;;; core-keys.el --- Minimal keybindings -*- lexical-binding: t; -*-

(defun minimal-call-package-command (feature command)
  "Call COMMAND after loading FEATURE, or fail with a clear message."
  (interactive)
  (unless (featurep feature)
    (require feature nil t))
  (if (fboundp command)
      (call-interactively command)
    (user-error "Command %s requires package %s" command feature)))

(let ((linemark-dir
       (expand-file-name "vendor/matlab-mode-20200213.930" minimal-config-root)))
  (when (file-directory-p linemark-dir)
    (add-to-list 'load-path linemark-dir)))

(defun minimal-ecb-activate ()
  (interactive)
  (minimal-call-package-command 'ecb #'ecb-activate))

(defun minimal-ecb-deactivate ()
  (interactive)
  (minimal-call-package-command 'ecb #'ecb-deactivate))

(defun minimal-ace-jump-mode ()
  (interactive)
  (minimal-call-package-command 'ace-jump-mode #'ace-jump-mode))

(defun minimal-ace-jump-pop-mark ()
  (interactive)
  (minimal-call-package-command 'ace-jump-mode #'ace-jump-mode-pop-mark))

(defun minimal-visual-bookmark-command (command)
  "Call visual bookmark COMMAND from vendored `linemark'."
  (interactive)
  (minimal-call-package-command 'linemark command))

(defun minimal-visual-bookmark-toggle ()
  (interactive)
  (minimal-visual-bookmark-command #'viss-bookmark-toggle))

(defun minimal-visual-bookmark-next ()
  (interactive)
  (minimal-visual-bookmark-command #'viss-bookmark-next-buffer))

(defun minimal-visual-bookmark-prev ()
  (interactive)
  (minimal-visual-bookmark-command #'viss-bookmark-prev-buffer))

(defun minimal-visual-bookmark-clear ()
  (interactive)
  (minimal-visual-bookmark-command #'viss-bookmark-clear-all-buffer))

(defun minimal-redo ()
  "Redo the most recent undo.

On Emacs 28+, use `undo-redo'. On Emacs 27, redo works by
breaking the consecutive-undo chain and then calling `undo' again."
  (interactive)
  (cond
   ((fboundp 'undo-redo)
    (undo-redo))
   ((memq last-command '(undo minimal-redo))
    (setq last-command 'minimal-redo-break)
    (undo))
   (t
    (user-error "Redo is only available immediately after undo on this Emacs"))))

(global-set-key (kbd "C-x C-r") #'recentf-open-files)
(global-set-key (kbd "C-x r m") #'bookmark-set)
(global-set-key (kbd "C-x r b") #'bookmark-jump)
(global-set-key (kbd "C-x r l") #'list-bookmarks)
(global-set-key (kbd "M-k")
                (lambda ()
                  (interactive)
                  (kill-line 0)))
(global-unset-key (kbd "M-c"))
(global-set-key (kbd "C-c o") #'ff-find-other-file)
(global-set-key (kbd "C-c <left>") #'winner-undo)
(global-set-key (kbd "C-c <right>") #'winner-redo)
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z") #'undo)
(global-set-key (kbd "C-S-z") #'minimal-redo)
(global-set-key (kbd "C-c z") #'minimal-redo)
(global-set-key (kbd "M-/") #'hippie-expand)
(global-set-key (kbd "M-TAB") #'completion-at-point)
(global-set-key (kbd "S-C-<left>") #'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") #'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") #'shrink-window)
(global-set-key (kbd "S-C-<up>") #'enlarge-window)
(global-set-key (kbd "<f2>") #'minimal-visual-bookmark-toggle)
(global-set-key (kbd "S-<f2>") #'minimal-visual-bookmark-prev)
(global-set-key (kbd "C-<f2>") #'minimal-visual-bookmark-next)
(global-set-key (kbd "C-S-<f2>") #'minimal-visual-bookmark-clear)
(global-set-key (kbd "C-c p") #'minimal-visual-bookmark-prev)
(global-set-key (kbd "C-c n") #'minimal-visual-bookmark-next)
(global-set-key (kbd "C-c C-b") #'minimal-visual-bookmark-clear)
(global-set-key (kbd "<f5>") #'minimal-ecb-activate)
(global-set-key (kbd "S-<f5>") #'minimal-ecb-deactivate)
(global-set-key (kbd "<f9>") #'gdb-many-windows)
(global-set-key (kbd "<f12>") #'tool-bar-mode)
(global-set-key (kbd "C-c b") #'minimal-visual-bookmark-toggle)
(global-set-key (kbd "C-c SPC") #'minimal-ace-jump-mode)
(global-set-key (kbd "C-x SPC") #'minimal-ace-jump-pop-mark)

(defun minimal-kill-other-file-buffers ()
  "Kill all file-visiting buffers except the current one."
  (interactive)
  (mapc #'kill-buffer
        (delq (current-buffer)
              (seq-filter #'buffer-file-name (buffer-list)))))

(global-set-key (kbd "C-x M-k") #'minimal-kill-other-file-buffers)

(windmove-default-keybindings)

;; Restore outline folding support used by <f4>.
(let ((outline-magic-dir
       (expand-file-name "vendor/outline-magic-20130813.1333" minimal-config-root)))
  (when (file-directory-p outline-magic-dir)
    (add-to-list 'load-path outline-magic-dir)))

;; Keep the useful C/C++ file pairing from the old config.
(setq-default cc-other-file-alist
              '(("\\.cc$"  (".hh" ".h"))
                ("\\.hh$"  (".cc" ".C"))
                ("\\.c$"   (".h"))
                ("\\.h$"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp"))
                ("\\.cxx$" (".hh" ".h"))
                ("\\.cpp$" (".hpp" ".hh" ".h"))))

(with-eval-after-load 'outline
  (require 'outline-magic nil t)
  (define-key outline-minor-mode-map (kbd "<f4>") #'outline-cycle))

;; Preserve the old tmux/iTerm escape translations when running inside tmux.
(when (getenv "TMUX")
  (let ((x 2)
        (tkey ""))
    (while (<= x 8)
      (setq tkey
            (pcase x
              (2 "S-")
              (3 "M-")
              (4 "M-S-")
              (5 "C-")
              (6 "C-S-")
              (7 "C-M-")
              (8 "C-M-S-")))
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d A" x)) (kbd (format "%s<up>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d B" x)) (kbd (format "%s<down>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d C" x)) (kbd (format "%s<right>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d D" x)) (kbd (format "%s<left>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d H" x)) (kbd (format "%s<home>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d F" x)) (kbd (format "%s<end>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 5 ; %d ~" x)) (kbd (format "%s<prior>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 6 ; %d ~" x)) (kbd (format "%s<next>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 2 ; %d ~" x)) (kbd (format "%s<delete>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 3 ; %d ~" x)) (kbd (format "%s<delete>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d P" x)) (kbd (format "%s<f1>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d Q" x)) (kbd (format "%s<f2>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d R" x)) (kbd (format "%s<f3>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d S" x)) (kbd (format "%s<f4>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 15 ; %d ~" x)) (kbd (format "%s<f5>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 17 ; %d ~" x)) (kbd (format "%s<f6>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 18 ; %d ~" x)) (kbd (format "%s<f7>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 19 ; %d ~" x)) (kbd (format "%s<f8>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 20 ; %d ~" x)) (kbd (format "%s<f9>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 21 ; %d ~" x)) (kbd (format "%s<f10>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 23 ; %d ~" x)) (kbd (format "%s<f11>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 24 ; %d ~" x)) (kbd (format "%s<f12>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 25 ; %d ~" x)) (kbd (format "%s<f13>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 26 ; %d ~" x)) (kbd (format "%s<f14>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 28 ; %d ~" x)) (kbd (format "%s<f15>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 29 ; %d ~" x)) (kbd (format "%s<f16>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 31 ; %d ~" x)) (kbd (format "%s<f17>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 32 ; %d ~" x)) (kbd (format "%s<f18>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 33 ; %d ~" x)) (kbd (format "%s<f19>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 34 ; %d ~" x)) (kbd (format "%s<f20>" tkey)))
      (setq x (1+ x)))))

(provide 'core-keys)

;;; core-keys.el ends here
