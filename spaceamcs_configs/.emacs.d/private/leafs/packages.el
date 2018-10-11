;;; packages.el --- leafs layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author:  <wquf1@A003101-PC06>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `leafs-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `leafs/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `leafs/pre-init-PACKAGE' and/or
;;   `leafs/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst leafs-packages
  '(chinese-pyim)
  "The list of Lisp packages required by the leafs layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun leafs/init-chinese-pyim()
  (setq default-input-method "pyim")
  ; (use-package pyim
  ;   :ensure nil
  ;   :demand t
  ;   :config
  ;   (use-package pyim-basedict
  ;     :ensure nil
  ;     :config (pyim-basedict-enable))
  ;   (setq default-input-method "pyim")
  ;   (setq pyim-default-scheme 'quanpin)
  ;   (setq pyim-isearch-mode 1)
  ;   (setq pyim-page-tooltip 'popup)
  ;   (setq pyim-page-length 9)
  ;   (add-hook 'emacs-startup-hook
  ;           #'(lambda () (pyim-restart-1 t)))
  ;   (global-set-key (kbd "C-\\") 'toggle-input-method)
  ; )
)
;;; packages.el ends here
