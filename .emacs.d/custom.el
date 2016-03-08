(require-package 'sr-speedbar)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-width 20)
(setq dframe-update-speed t)
(global-set-key (kbd "<f5>") (lambda()
          (interactive)
          (sr-speedbar-toggle)))
;(add-hook 'after-init-hook '(lambda () (sr-speedbar-toggle)));;开启程序即启用