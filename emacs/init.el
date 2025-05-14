;; -*- lexical-binding: t;-*-


(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 0)
(menu-bar-mode -1)


(setq visible-bell t)



(load-theme 'modus-vivendi  t)


(use-package command-log-mode)

(column-number-mode)
(global-display-line-numbers-mode t)

(set-frame-font "Spleen 12" nil t)
