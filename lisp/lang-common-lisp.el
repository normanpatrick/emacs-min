;;; lang-common-lisp.el --- Optional Common Lisp setup -*- lexical-binding: t; -*-

(require 'cl-lib)

(defgroup minimal-common-lisp nil
  "Optional Common Lisp support for the minimal config."
  :group 'languages)

(defcustom minimal-common-lisp-program "sbcl"
  "Program used by SLIME or `run-lisp'."
  :type 'string)

(defcustom minimal-common-lisp-slime-helper
  (expand-file-name "~/.quicklisp/slime-helper.el")
  "Path to Quicklisp's slime-helper.el."
  :type 'file)

(setq inferior-lisp-program minimal-common-lisp-program)

;; `lisp-mode' is built in, so editing .lisp files works without SLIME.
;; If Quicklisp's SLIME helper is present, enable the REPL/integration too.
(when (file-exists-p minimal-common-lisp-slime-helper)
  (load minimal-common-lisp-slime-helper nil t)
  (with-eval-after-load 'slime
    (setq slime-lisp-implementations
          `((sbcl (,minimal-common-lisp-program))))))

(defun minimal-run-common-lisp ()
  "Start a Common Lisp session using SLIME when available."
  (interactive)
  (if (fboundp 'slime)
      (slime)
    (run-lisp inferior-lisp-program)))

(global-set-key (kbd "C-c l") #'minimal-run-common-lisp)

(provide 'lang-common-lisp)

;;; lang-common-lisp.el ends here
