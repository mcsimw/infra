;; -*- lexical-binding: t;-*-

;; Disable GUI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 0)

;; Disable startup screen
(setq inhibit-startup-screen t)

;; No blinking cursor
(blink-cursor-mode -1)

;; Disable tooltips
(tooltip-mode -1)

;; No bell
(setq ring-bell-function 'ignore)

(load-theme 'modus-vivendi t)

;; Do NOT try to install anything here. Just configure it.
(use-package magit
  :defer t)

(use-package vertico
  :init
  (vertico-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(set-face-attribute 'default nil
					:family "Luculent"
					:height 120)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
