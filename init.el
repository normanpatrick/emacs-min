;;; init.el --- Minimal standalone Emacs config -*- lexical-binding: t; -*-

(defconst minimal-config-root
  (file-name-directory (or load-file-name buffer-file-name))
  "Root directory of the minimal Emacs config.")

;; Keep generated customizations isolated from the main init.
(setq custom-file (expand-file-name "minimal-custom.el" minimal-config-root))

;; Package setup is present, but the config does not depend on external packages.
(require 'package)
(setq package-user-dir (expand-file-name "elpa" minimal-config-root))
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(add-to-list 'load-path (expand-file-name "lisp" minimal-config-root))

(require 'core-ui)
(when (file-exists-p custom-file)
  (load custom-file nil t))
(require 'core-editing)
(require 'core-keys)
(require 'lang-c-cpp)
(require 'lang-extra-modes)
(require 'lang-markdown)
(require 'lang-python)
(require 'lang-go)
;; Optional language modules. Uncomment only what you actively use.
;; (require 'lang-common-lisp)

;; Optional local overrides. Create local.el only if you need machine-specific code.
(let ((local-file (expand-file-name "local.el" minimal-config-root)))
  (when (file-exists-p local-file)
    (load local-file nil t)))

;;; init.el ends here
