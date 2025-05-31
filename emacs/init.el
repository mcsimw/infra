;; -*- lexical-binding: t; -*-
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode)

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t
      initial-scratch-message nil)
		    
(setq ring-bell-function 'ignore)

(load-theme 'modus-vivendi)

(use-package eat)

(global-prettify-symbols-mode t)

(setq make-backup-file nil)
(setq auto-save-default nil)




(set-frame-font "Lucida Console 12")

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

