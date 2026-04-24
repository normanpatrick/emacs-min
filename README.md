# Minimal Emacs Config

This directory is a separate Emacs config you can try without touching the existing one.

It is still much smaller than the old setup, but it no longer tries to be purely built-in. A few pieces from the old config were restored because they materially affect daily use:
- the `hc-zenburn` theme from the checked-in `elpa/` tree
- `ido` with flex matching for file and buffer selection
- the old global keyboard shortcuts
- the tmux/iTerm key translation block

## Layout

- `init.el`: startup entry point
- `lisp/core-ui.el`: theme setup, UI defaults, `ido`
- `snippets/`: local snippet overrides and additions
- `lisp/core-editing.el`: editing behavior, backups, history, line numbers, CUA rectangle mode
- `lisp/core-keys.el`: restored global keybindings and lazy package-backed bindings
- `lisp/lang-python.el`: restored Python mode outline behavior
- `lisp/lang-go.el`: restored Go mode bindings and format-on-save behavior
- `lisp/lang-common-lisp.el`: optional Common Lisp support
- `minimal-custom.el`: visual and custom-set values
- `local.el`: optional machine-specific overrides, not created by default

Generated state files created by this config:
- `recentf`
- `history`
- `ido.last`

## What This Config Currently Preserves

- your old `hc-zenburn` theme setup
- your old fuzzy filename matching via `ido`
- `yasnippet` enabled globally from the checked-in `elpa/` tree
- backups and autosaves in a temp directory
- `recentf`, `savehist`, `winner-mode`, `show-paren-mode`
- your old global keyboard habits including `C-z`, `C-S-z`, `M-k`, `C-c o`, `F12`, `F9`
- `windmove` shift-arrow navigation
- tmux/iTerm key translations from the old config
- encrypted file support via `epa-file`
- Python `outline-minor-mode`
- Python `ifm<TAB>` snippet via local `yasnippet` snippets
- Go `M-a` / `M-e`, outline setup, and `gofmt-before-save` when available

## What Is Still Intentionally Missing

These are not part of startup unless you add them back on purpose:
- `auto-complete`
- `undo-tree`
- `fill-column-indicator`
- Haskell, Go, Angular, Nix, Clojure, and similar language-specific startup wiring
- Haskell, Angular, Nix, Clojure, and similar language-specific startup wiring
- the old monolithic `nemacs.el`

Some legacy package-backed keys are present as lazy wrappers, but the packages themselves are not loaded by default:
- `bm`
- `ecb`
- `ace-jump-mode`

If you press one of those keys without the package being available, Emacs will raise a clear error instead of silently doing nothing.

## How To Try It

To test this config without replacing your main one:

```bash
emacs -Q --load /path/to/minimal-config/init.el
```

That starts Emacs with no normal init file and then loads this directory's config.

## Notes About Theme Loading

This config now vendors `hc-zenburn` locally and loads it from:
- `themes/hc-zenburn-theme.el`

That means `minimal-config/` no longer depends on the old sibling `elpa/` tree for theme loading.

## Optional Common Lisp

Common Lisp support lives in `lisp/lang-common-lisp.el` and is off by default.

To enable it, uncomment this line in `init.el`:

```elisp
(require 'lang-common-lisp)
```

After enabling it:
- `.lisp` files still use built-in `lisp-mode`
- `C-c l` starts a Lisp session
- if `~/.quicklisp/slime-helper.el` exists, `C-c l` starts SLIME
- otherwise `C-c l` falls back to built-in `run-lisp`

Defaults:
- Lisp program: `sbcl`
- Quicklisp helper path: `~/.quicklisp/slime-helper.el`

If you need different values, put them in `local.el`:

```elisp
(setq minimal-common-lisp-program "ccl")
;; or
(setq minimal-common-lisp-slime-helper "/path/to/slime-helper.el")
```

## Extension Strategy

If you extend this config, add one small file at a time under `lisp/` and require it explicitly from `init.el`.

The safest next steps are:
1. add any language-specific modules you actually use
2. only then decide whether old package dependencies are worth restoring
3. keep visual settings in `minimal-custom.el` and machine-specific settings in `local.el`
