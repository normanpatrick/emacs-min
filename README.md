# Minimal Emacs Config

A standalone minimal Emacs configuration.

A few vendored components are kept locally.
- `hc-zenburn` theme
- `yasnippet`
- `markdown-mode`

## Layout

- `init.el`: startup entry point
- `lisp/core-ui.el`: theme setup, UI defaults, `ido`, `yasnippet`
- `lisp/core-editing.el`: editing behavior, backups, history, line numbers, CUA rectangle mode
- `lisp/core-keys.el`: global keybindings and lazy package-backed bindings
- `lisp/lang-c-cpp.el`: C/C++ style and outline behavior
- `lisp/lang-markdown.el`: Markdown file associations
- `lisp/lang-python.el`: Python mode outline behavior
- `lisp/lang-go.el`: Go mode bindings and format-on-save behavior
- `lisp/lang-common-lisp.el`: optional Common Lisp support
- `minimal-custom.el`: visual and `custom-set-*` values
- `themes/`: local theme files
- `snippets/`: local snippet overrides and additions
- `vendor/yasnippet-20140911.312/`: vendored snippet engine and selected bundled snippets
- `vendor/markdown-mode-20181029.140/`: vendored Markdown major mode
- `local.el`: optional machine-specific overrides, not created by default

Generated state files created by this config:
- `recentf`
- `history`
- `ido.last`

## Current Behavior

- `hc-zenburn` loaded from `themes/hc-zenburn-theme.el`
- `ido` with flex matching for file and buffer selection
- `yasnippet` enabled globally from the vendored local copy
- backups and autosaves stored outside project directories
- `recentf`, `savehist`, `winner-mode`, `show-paren-mode`
- global keybindings for window movement, window resizing, undo, buffer cleanup, and file switching
- tmux/iTerm key translations when running inside tmux
- encrypted file support via `epa-file`
- C/C++ Linux style with `c-basic-offset` 4 and `outline-minor-mode`
- Markdown files associated with `markdown-mode`
- Python `outline-minor-mode`
- Python `ifm<TAB>` snippet via local snippets
- Go `M-a` / `M-e`, outline setup, and `gofmt-before-save` when available

## Not Included By Default

These are not part of startup unless explicitly reintroduced:
- `auto-complete`
- `undo-tree`
- `fill-column-indicator`
- Haskell-specific startup wiring
- Angular-specific startup wiring
- Nix-specific startup wiring
- Clojure-specific startup wiring
- the old monolithic `nemacs.el`

Some legacy package-backed keys are present as lazy wrappers, but the packages themselves are not loaded by default:
- `bm`
- `ecb`
- `ace-jump-mode`


## Isolation

This config stores its own runtime state locally:
- `minimal-custom.el`
- `recentf`
- `history`
- `ido.last`
- `elpa/`

Theme loading is local:
- `themes/hc-zenburn-theme.el`

Snippet loading is local:
- `snippets/`
- `vendor/yasnippet-20140911.312/snippets/`

The normal startup path does not depend on `~/.emacs.d`.

One optional exception exists in the Common Lisp module:
- `lisp/lang-common-lisp.el` defaults to `~/.quicklisp/slime-helper.el` if that module is enabled

## How To Try It

To test this config without replacing the main one:

```bash
emacs -Q --load /path/to/minimal-config/init.el
```

The above starts Emacs loads this config.

## Optional Common Lisp

Common Lisp support is available but disabled by default.

To enable it, uncomment this line in `init.el`:

```elisp
(require 'lang-common-lisp)
```

After enabling it:
- `.lisp` files use built-in `lisp-mode`
- `C-c l` starts a Lisp session
- if `~/.quicklisp/slime-helper.el` exists, `C-c l` starts SLIME
- otherwise `C-c l` falls back to built-in `run-lisp`

Defaults:
- Lisp program: `sbcl`
- Quicklisp helper path: `~/.quicklisp/slime-helper.el`

If different values are needed, put them in `local.el`:

```elisp
(setq minimal-common-lisp-program "ccl")
;; or
(setq minimal-common-lisp-slime-helper "/path/to/slime-helper.el")
```

## Extension Strategy

* If this config grows, add one small file at a time under `lisp/` and require it explicitly from `init.el`.
* Keep visual settings in `minimal-custom.el` and machine-specific settings in `local.el`.
