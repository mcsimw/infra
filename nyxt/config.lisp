(define-configuration buffer
					  ((default-mode
						 (pushnew 'nyxt/mode/emacs:emacs-mode %slot-value%))))
(define-configuration browser
  ((theme theme:+dark-theme+ :doc "Setting dark theme.
The default is theme:+light-theme+.")))
