;;;;;;;;; COMMON CONFIGURATIONS

(column-number-mode t)               ;; Show current column
(size-indication-mode t)             ;; Show current buffer size
(setq inhibit-startup-message t)     ;; Don't show the GNU splash screen
(transient-mark-mode t)              ;; Show selection from mark
(mouse-avoidance-mode 'jump)         ;; Jump mouse away when typing
(auto-compression-mode t)            ;; Browse compressed archives
(put 'upcase-region 'disabled nil)   ;; Enable ``upcase-region''
(global-font-lock-mode t)            ;; Syntax highlight
(fset 'yes-or-no-p 'y-or-n-p)        ;; Use 'y' instead of 'yes' etc.
(setq message-log-max 10000)         ;; Extend message buffer
(setq set-mark-command-repeat-pop t) ;; Pop repeat marks
(setq kill-whole-line t)             ;; Kill whole line and move next line up.
(setq confirm-kill-emacs 'y-or-n-p)  ;; Confirm killing emacs (might not be on purpose..).
(setq echo-keystrokes 0.2)           ;; Echo keystrokes quicker.
(setq tab-always-indent 'complete)   ;; First indent, but if indented then try to complete at point.

;; Don't show menu bar, scroll bar, and tool bar. In TTY they are not
;; defined.
(when window-system
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1))

;; Set fringe size to 4 instead of the default of 8.
(when (fboundp 'fringe-mode)
  (fringe-mode 4))

;; Garbage collect at every 20 MB allocated instead of the default 8 MB. This
;; speeds up various things.
(setq gc-cons-threshold 20000000)

;; Change warning to appear at 100+ MB instead of 10 MB.
(setq large-file-warning-threshold 100000000)

;; Use utf-8 for everything!
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

;; Stop creating backup~ and #autosave# files!
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Enable abbrev-mode on default and save new abbrevs silently to "~/.emacs.d/abbrev_defs".
(setq save-abbrevs 'silently)
(setq-default abbrev-mode t)

;; Set fill column to 100.
(defconst global-fill-column 100)
(setq-default fill-column global-fill-column)
(dolist (hook '(auto-fill-mode-hook
                prog-mode-hook))
  (add-hook hook (lambda () (setq fill-column global-fill-column))))

;; Set default tab width to 2 spaces.
(defconst general-tab-width 2)
(setq-default indent-tabs-mode nil)  ;; Use spaces instead of tabs

;; Sensible window splitting should follow the fill column.
(when window-system
  (setq split-height-threshold (* 2 global-fill-column)
        split-width-threshold (* 2 global-fill-column)))

;; Disable visible bell because it looks ugly, but that makes the audible bell and therefore we
;; "flash" the mode line by double-inverting instead.
(setq visible-bell nil)
(setq ring-bell-function (lambda ()
                           (invert-face 'mode-line)
                           (run-with-timer 0.05 nil 'invert-face 'mode-line)))

;; Scratch buffer
(setq initial-major-mode 'lisp-interaction-mode)
(setq initial-scratch-message ";; Scratch buffer..
")

;; Set title including name and path of current buffer.
(setq frame-title-format
      '("" invocation-name ":   "
        (:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; Cursor setup.
(setq cursor-type 'box)
(setq blink-cursor-blinks 50)
(blink-cursor-mode t)

;; Uniquify buffer names.
(setq uniquify-buffer-name-style 'forward)

;; Auto-revert buffers when files change on disk.
(setq-default auto-revert-verbose nil)  ;; Don't announce when buffer is reverted.
(global-auto-revert-mode t)

;; Log files should automatically update on changes.
(setq auto-mode-alist
      (append '(("\\.log$" . (lambda () (auto-revert-tail-mode))))
              auto-mode-alist))
