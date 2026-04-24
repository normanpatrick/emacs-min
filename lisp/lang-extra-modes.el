;;; lang-extra-modes.el --- Local extra major modes -*- lexical-binding: t; -*-

(let ((dockerfile-dir
       (expand-file-name "vendor/dockerfile-mode-20150407.550" minimal-config-root))
      (matlab-dir
       (expand-file-name "vendor/matlab-mode-20200213.930" minimal-config-root))
      (verilog-dir
       (expand-file-name "vendor/verilog-mode-2019.11.21.248091482" minimal-config-root)))
  (when (file-directory-p dockerfile-dir)
    (add-to-list 'load-path dockerfile-dir)
    (autoload 'dockerfile-mode "dockerfile-mode" "Major mode for Dockerfiles." t)
    (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
    (add-to-list 'auto-mode-alist '("Containerfile\\'" . dockerfile-mode))
    (add-to-list 'auto-mode-alist '("\\.dockerfile\\'" . dockerfile-mode)))

  (when (file-directory-p matlab-dir)
    (add-to-list 'load-path matlab-dir)
    (autoload 'matlab-mode "matlab" "Major mode for MATLAB." t)
    (add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode)))

  (when (file-directory-p verilog-dir)
    (add-to-list 'load-path verilog-dir)
    (autoload 'verilog-mode "verilog-mode" "Major mode for Verilog." t)
    (add-to-list 'auto-mode-alist '("\\.v\\'" . verilog-mode))
    (add-to-list 'auto-mode-alist '("\\.vh\\'" . verilog-mode))
    (add-to-list 'auto-mode-alist '("\\.sv\\'" . verilog-mode))
    (add-to-list 'auto-mode-alist '("\\.svh\\'" . verilog-mode))))

(provide 'lang-extra-modes)

;;; lang-extra-modes.el ends here
