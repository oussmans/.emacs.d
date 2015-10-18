(require 'req-package)

;;;;;;;;; COMMON CONFIGURATIONS

(column-number-mode t)                  ;; show current column
(setq inhibit-startup-message t)        ;; don't show the GNU splash screen
(transient-mark-mode t)                 ;; show selection from mark
(mouse-avoidance-mode 'jump)            ;; jump mouse away when typing
(auto-compression-mode t)               ;; browse compressed archives
(put 'upcase-region 'disabled nil)      ;; enable ``upcase-region''
(global-font-lock-mode t)               ;; syntax highlight
(setq-default indent-tabs-mode nil)     ;; use spaces instead of tabs
(fset 'yes-or-no-p 'y-or-n-p)           ;; use 'y' instead of 'yes' etc.
(setq message-log-max 10000)            ;; extend message buffer

;; Don't show menu bar, scroll bar, and tool bar. In TTY they are not
;; defined.
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; Prefer newest version of a file, especially for compiled files this is
;; useful.
(setq load-prefer-newer t)

;; Garbage collect at every 20 MB allocated instead of the default 8 MB. This
;; speeds up various things.
(setq gc-cons-threshold 20000000)

;; Set fill column to 80.
(setq-default fill-column 80)
(add-hook 'auto-fill-mode-hook
          (lambda () (set-fill-column 80)))

;; Disable visible bell because it looks ugly, but that makes the
;; audible bell and therefore we replace it with a
;; background/foreground color "flash".
(setq visible-bell nil)
(setq ring-bell-function
      `(lambda ()
         (let ((old (face-foreground 'default)))
           (set-face-foreground 'default (face-background 'default))
           (set-face-foreground 'default old))))

;; Scratch buffer
(setq initial-major-mode 'lisp-interaction-mode)
(setq initial-scratch-message ";; Scratch buffer..
")

;; Set title including name of currently active buffer.
(setq frame-title-format "Emacs: %b")

;; Configure the cursor to use a bar when editable and a box when read-only. And
;; after idling 5 seconds it will show as a box to more easily spot it.
(req-package cursor-chg
  :config
  (progn
    (setq blink-cursor-blinks 50)
    (blink-cursor-mode t)

    (setq curchg-default-cursor-color (face-attribute 'cursor :background))
    (change-cursor-mode t)
    (curchg-change-cursor-when-idle-interval 5)
    (toggle-cursor-type-when-idle t)))


(provide 'init-general)
