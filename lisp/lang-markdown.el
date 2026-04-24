;;; lang-markdown.el --- Local Markdown support -*- lexical-binding: t; -*-

(let ((markdown-dir (expand-file-name "vendor/markdown-mode-20181029.140"
                                      minimal-config-root)))
  (when (file-directory-p markdown-dir)
    (add-to-list 'load-path markdown-dir)
    (autoload 'markdown-mode "markdown-mode" "Major mode for Markdown." t)
    (autoload 'gfm-mode "markdown-mode" "Major mode for GitHub Flavored Markdown." t)
    (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
    (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
    (add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))))

(provide 'lang-markdown)

;;; lang-markdown.el ends here
