;; -*- coding: utf-8; lexical-binding: t; -*-
;; Emacs settings plain gnu emacs only
;; 2019-11-06
;; http://ergoemacs.org/emacs/emacs_init_index.html

;;; --------------------
;; initial window and default window

(setq inhibit-startup-screen t)

(if (display-graphic-p)
    (setq initial-frame-alist
          '(
            (tool-bar-lines . 0)
            (background-color . "honeydew")
            (width . 106)
            (height . 56)
            ;; (left . 50)
            ;; (top . 50)
            ))
  (setq initial-frame-alist '( (tool-bar-lines . 0))))

(setq default-frame-alist
      '(
        (tool-bar-lines . 0)
        (background-color . "honeydew")
        (width . 100)
        (height . 55)))

;;; --------------------

;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)
;; (setenv "LANG" "en_US.UTF-8" )
;; (setenv "LC_ALL" "en_US.UTF-8" )

;;; --------------------

;; for isearch-forward, make these equivalent: space newline tab hyphen underscore
(setq search-whitespace-regexp "[-_ \t\n]+")

(defun dnewman-toggle-search-whitespace ()
  "Set `search-whitespace-regexp' to nil or includes hyphen lowline tab newline.
Explanation: When in isearch (M-x `isearch-forward'), space key can also stand for other chars such as hyphen lowline tab newline. It depend on a regex. It's convenient. But sometimes you want literal. This command makes it easy to toggle.
Emacs Isearch Space Toggle
http://ergoemacs.org/emacs/emacs_isearch_space.html
Version 2019-02-22"
  (interactive)
  (if (string-equal search-whitespace-regexp nil)
      (progn
        (setq search-whitespace-regexp "[-_ \t\n]+")
        (message "Space set to hyphen lowline tab newline space"))
    (progn
      (setq search-whitespace-regexp nil)
      (message "Space set to literal."))))

(setq make-backup-files nil)
(setq backup-by-copying t)

(setq create-lockfiles nil)

(setq auto-save-default nil)

(column-number-mode 1)

(progn
  ;; seems pointless to warn. There's always undo.
  (put 'narrow-to-region 'disabled nil)
  (put 'narrow-to-page 'disabled nil)
  (put 'upcase-region 'disabled nil)
  (put 'downcase-region 'disabled nil)
  (put 'erase-buffer 'disabled nil)
  (put 'scroll-left 'disabled nil)
  (put 'dired-find-alternate-file 'disabled nil)
)

;;; --------------------

(progn
  (require 'dired-x)
  (setq dired-dwim-target t)
  (when (string-equal system-type "gnu/linux") (setq dired-listing-switches "-al --time-style long-iso"))
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always))

;;; --------------------

(setq save-interprogram-paste-before-kill t)
;; 2015-07-04 bug of pasting in emacs.
;; http://debbugs.gnu.org/cgi/bugreport.cgi?bug=16737#17
;; http://ergoemacs.org/misc/emacs_bug_cant_paste_2015.html
;; (setq x-selection-timeout 300)

(setq x-select-enable-clipboard-manager nil)

;;; --------------------

(require 'recentf)
(recentf-mode 1)

(desktop-save-mode 1)

(blink-cursor-mode 0)

(global-auto-revert-mode 1)

(setq sentence-end-double-space nil )

(setq set-mark-command-repeat-pop t)
(setq mark-ring-max 5)
(setq global-mark-ring-max 5)

;; (electric-pair-mode 1)

(when (fboundp 'eww)
  (defun dnewman-rename-eww-buffer ()
    "Rename `eww-mode' buffer so sites open in new page.
URL `http://ergoemacs.org/emacs/emacs_eww_web_browser.html'
Version 2017-11-10"
    (let (($title (plist-get eww-data :title)))
      (when (eq major-mode 'eww-mode )
        (if $title
            (rename-buffer (concat "eww " $title ) t)
          (rename-buffer "eww" t)))))

  (add-hook 'eww-after-render-hook 'dnewman-rename-eww-buffer))

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;;; --------------------
(progn
  ;; set a default font
  (cond
   ((string-equal system-type "gnu/linux")
    (when (member "DejaVu Sans Mono" (font-family-list)) (set-frame-font "DejaVu Sans Mono" t t))
    ;; specify font for chinese characters using default chinese font on linux
    (when (member "WenQuanYi Micro Hei" (font-family-list))
      (set-fontset-font t '(#x4e00 . #x9fff) "WenQuanYi Micro Hei" ))
    ;;
    )
   ((string-equal system-type "darwin") ; Mac
    (when (member "Menlo" (font-family-list)) (set-frame-font "Menlo-14" t t)))
   ((string-equal system-type "windows-nt") ; Windows
    (when (member "Courier" (font-family-list)) (set-frame-font "Courier" t t))))

  ;; specify font for all unicode characters
  (when (member "Symbola" (font-family-list))
    (set-fontset-font t 'unicode "Symbola" nil 'prepend))

  ;; ;; specify font for all unicode characters
  ;; (when (member "Apple Color Emoji" (font-family-list))
  ;;   (set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend))
  ;;
  )

;; (progn
;;   ;; use variable-width font for some modes
;;   (defun dnewman-set-proportial-font ()
;;     "Set current buffer to use variable-width font."
;;     (variable-pitch-mode 1)
;;     ;; (text-scale-increase 1 )
;;     )
;;   (add-hook 'dnewman-elisp-mode-hook 'dnewman-set-proportial-font)
;;   (add-hook 'dnewman-html-mode-hook 'dnewman-set-proportial-font)
;;   (add-hook 'dnewman-css-mode-hook 'dnewman-set-proportial-font)
;;   (add-hook 'dnewman-js-mode-hook 'dnewman-set-proportial-font)
;;   (add-hook 'html-mode-hook 'dnewman-set-proportial-font)
;;   (add-hook 'nxml-mode-hook 'dnewman-set-proportial-font)
;;   (add-hook 'dnewman-elisp-mode-hook 'dnewman-set-proportial-font)
;;   (add-hook 'js-mode-hook 'dnewman-set-proportial-font)
;;   (add-hook 'css-mode-hook 'dnewman-set-proportial-font))

(progn
  (setq enable-recursive-minibuffers t)

  ;; Save minibuffer history
  (savehist-mode 1)

;; big minibuffer height, for ido to show choices vertically
(setq max-mini-window-height 0.5)

  ;; minibuffer, stop cursor going into prompt
  (customize-set-variable
   'minibuffer-prompt-properties
   (quote (read-only t cursor-intangible t face minibuffer-prompt))))

;;; --------------------

;; remember cursor position
(if (version< emacs-version "25.0")
    (progn
      (require 'saveplace)
      (setq-default save-place t))
  (save-place-mode 1))

;;; --------------------
;;; editing related

;; make typing delete/overwrites selected text
(delete-selection-mode 1)

(setq shift-select-mode nil)

;; set highlighting brackets
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

(progn
  ;; minibuffer enhanced completion
  (require 'icomplete)
  (icomplete-mode 1)
  ;; show choices vertically
  (setq icomplete-separator "\n")
  (setq icomplete-hide-common-prefix nil)
  (setq icomplete-in-buffer t)
  (define-key icomplete-minibuffer-map (kbd "<right>") 'icomplete-forward-completions)
  (define-key icomplete-minibuffer-map (kbd "<left>") 'icomplete-backward-completions))

(progn
  ;; make buffer switch command do suggestions, also for find-file command
  (require 'ido)
  (ido-mode 1)

  ;; show choices vertically
  (if (version< emacs-version "25")
      (progn
        (make-local-variable 'ido-separator)
        (setq ido-separator "\n"))
    (progn
      (make-local-variable 'ido-decorations)
      (setf (nth 2 ido-decorations) "\n")))

  ;; show any name that has the chars you typed
  (setq ido-enable-flex-matching t)
  ;; use current pane for newly opened file
  (setq ido-default-file-method 'selected-window)
  ;; use current pane for newly switched buffer
  (setq ido-default-buffer-method 'selected-window)
  ;; stop ido from suggesting when naming new file
  (when (boundp 'ido-minor-mode-map-entry)
    (define-key (cdr ido-minor-mode-map-entry) [remap write-file] nil)))

;;; --------------------
;; indentation, tab

(electric-indent-mode 0)

(set-default 'tab-always-indent 'complete)

;; no mixed tab space
(setq-default indent-tabs-mode nil)
 ; gnu emacs 23.1, 24.4.1 default is t

;; 4 is more popular than 8.
(setq-default tab-width 4)

;;; --------------------

(progn
  ;; org-mode
  ;; make “org-mode” syntax color code sections
  (setq org-src-fontify-natively t)
  (setq org-startup-folded nil)
  (setq org-return-follows-link t)
  (setq org-startup-truncated nil))

;;; --------------------

;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))

;;; --------------------

(progn
 ;; Make whitespace-mode with very basic background coloring for whitespaces.
  ;; http://ergoemacs.org/emacs/whitespace-mode.html
  (setq whitespace-style (quote (face spaces tabs newline space-mark tab-mark newline-mark )))

  ;; Make whitespace-mode and whitespace-newline-mode use “¶” for end of line char and “▷” for tab.
  (setq whitespace-display-mappings
        ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
        '(
          (space-mark 32 [183] [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
          (newline-mark 10 [182 10]) ; LINE FEED,
          (tab-mark 9 [9655 9] [92 9]) ; tab
          )))

;;; --------------------

(setq hippie-expand-try-functions-list
      '(
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        ;; try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol
        try-complete-file-name-partially
        try-complete-file-name
        ;; try-expand-all-abbrevs
        ;; try-expand-list
        ;; try-expand-line
        ))

;;; --------------------

(setq use-dialog-box nil)

;;; --------------------

;; convenient
(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'rs 'replace-string)

(defalias 'lcd 'list-colors-display)
(defalias 'ds 'desktop-save)
(defalias 'dt 'desktop-save)
(defalias 'dsm 'desktop-save-mode)

(defalias 'elm 'emacs-lisp-mode)
(defalias 'hm 'html-mode)
(defalias 'jsm 'js-mode)
(defalias 'fm 'fundamental-mode)
(defalias 'ssm 'shell-script-mode)
(defalias 'om 'org-mode)

(defalias 'xnp 'dnewman-new-page)

(when (fboundp 'magit-status)
  (defalias 'ms 'magit-status))

(when (fboundp 'dnewman-find-count)
  (defalias 'xfc 'dnewman-find-count))

(defalias 'xcm 'dnewman-css-mode)
(defalias 'xem 'dnewman-elisp-mode)
(defalias 'xhm 'dnewman-html-mode)
(defalias 'xjm 'dnewman-js-mode)
(defalias 'xcm 'dnewman-clojure-mode)

;; no want tpu-edt
(defalias 'tpu-edt 'forward-char)
(defalias 'tpu-edt-on 'forward-char)

;;; --------------------

(defun dnewman-save-all-unsaved ()
  "Save all unsaved files. no ask.
Version 2019-11-05"
  (interactive)
  (save-some-buffers t ))

(add-hook 'focus-out-hook 'dnewman-save-all-unsaved)

;; ---------------------------
;; Bell (no annoying beeps)
(setq ring-bell-function
      (lambda ()
        (let ((orig-fg (face-foreground 'mode-line)))
          (set-face-foreground 'mode-line "#F2804F")
          (run-with-idle-timer 0.1 nil
                               (lambda (fg) (set-face-foreground 'mode-line fg))
                               orig-fg))))

;; HH====================================================================

;; set default font
(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (when (member "Consolas" (font-family-list))
    (set-frame-font "Consolas" t t)))
 ((string-equal system-type "darwin") ; macOS
  (when (member "Menlo" (font-family-list))
    (set-frame-font "Menlo" t t)))
 ((string-equal system-type "gnu/linux") ; linux
  (when (member "DejaVu Sans Mono" (font-family-list))
    (set-frame-font "DejaVu Sans Mono" t t))))
