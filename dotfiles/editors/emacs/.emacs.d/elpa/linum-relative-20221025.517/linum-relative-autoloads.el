;;; linum-relative-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "linum-relative" "linum-relative.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from linum-relative.el

(autoload 'linum-relative-toggle "linum-relative" "\
Toggle between linum-relative and linum." t nil)

(autoload 'linum-relative-mode "linum-relative" "\
Display relative line numbers for current buffer.

This is a minor mode.  If called interactively, toggle the
`Linum-Relative mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `linum-relative-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(put 'linum-relative-global-mode 'globalized-minor-mode t)

(defvar linum-relative-global-mode nil "\
Non-nil if Linum-Relative-Global mode is enabled.
See the `linum-relative-global-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `linum-relative-global-mode'.")

(custom-autoload 'linum-relative-global-mode "linum-relative" nil)

(autoload 'linum-relative-global-mode "linum-relative" "\
Toggle Linum-Relative mode in all buffers.
With prefix ARG, enable Linum-Relative-Global mode if ARG is positive;
otherwise, disable it.

If called from Lisp, toggle the mode if ARG is `toggle'.
Enable the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

Linum-Relative mode is enabled in all buffers where `(lambda nil
\(unless (linum-relative-in-helm-p) (linum-relative-mode 1)))' would do
it.

See `linum-relative-mode' for more information on Linum-Relative
mode.

\(fn &optional ARG)" t nil)

(autoload 'helm-linum-relative-mode "linum-relative" "\
Turn on `linum-relative-mode' in helm.

This is a minor mode.  If called interactively, toggle the
`Helm-Linum-Relative mode' mode.  If the prefix argument is
positive, enable the mode, and if it is zero or negative, disable
the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `helm-linum-relative-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(register-definition-prefixes "linum-relative" '("helm--turn-on-linum-relative" "linum-relative"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; linum-relative-autoloads.el ends here
