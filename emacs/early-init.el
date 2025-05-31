;; -*- lexical-binding: t;-*-

;; Your original block (unchanged)
(setq package-enable-at-startup nil      ; skip auto-init
      package-quickstart        nil      ; skip quick-start cache
      package-archives          nil      ; zero archives
      package-archive-contents  nil)     ; zero cached metadata

;; Put any scratch files in /tmp, not ~/.emacs.d/
(setq package-user-dir
      (expand-file-name "elpa" temporary-file-directory)) ; /tmp/elpa/

;; Block installs & deletes with a clear error
(dolist (cmd '(package-install package-delete))
	(advice-add cmd :override
		(lambda (&rest _)
			(interactive)
            	(user-error "Package management is handled by Nix – command disabled."))))

;; Refresh does nothing (archives are nil anyway)
(advice-add 'package-refresh-contents :override
	(lambda (&optional _)
		(interactive)
			(message "Archives disabled – nothing to refresh.")))

;; Clean up the throw-away /tmp/elpa on exit
(add-hook 'kill-emacs-hook
	(lambda ()
		(when (file-directory-p package-user-dir)
			(delete-directory package-user-dir 'recursive))))
