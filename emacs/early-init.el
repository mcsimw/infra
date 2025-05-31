;; -*- lexical-binding: t;-*-

(setq package-enable-at-startup nil
      package-quickstart        nil
      package-archives          nil
      package-archive-contents  nil)

(setq package-user-dir
      (expand-file-name "elpa" temporary-file-directory))

(dolist (cmd '(package-install package-delete))
	(advice-add cmd :override
		(lambda (&rest _)
			(interactive)
            	(user-error "Package management is handled by Nix – command disabled."))))

(advice-add 'package-refresh-contents :override
	(lambda (&optional _)
		(interactive)
			(message "Archives disabled – nothing to refresh.")))

(add-hook 'kill-emacs-hook
	(lambda ()
		(when (file-directory-p package-user-dir)
			(delete-directory package-user-dir 'recursive))))
