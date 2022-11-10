;;; coffee.emacs-theme.el --- A warm theme for GNU emacs

;;; Copyright (C) 2022-2023

;;; Version: 1.1
;;; Author: Ari Archer <ari.web.xyz@gmail.com>, Coffee-theme <ari.web.xyz@gmail>
;;; URL: https://github.com/coffee-theme/coffee.emacs

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;; Commentary:
;; A warm theme for GNU emacs
;;; Code:

(deftheme coffee.emacs
  "A warm theme for GNU emacs")

(custom-theme-set-faces
 'coffee.emacs
 '(cursor ((t (:background "#fdf4c1"))))
 '(fringe ((t (:background "#262220"))))
 '(mode-line ((t (:foreground "#262220" :background "#7c6f64"))))
 '(region ((t (:background "#504945"))))
 '(secondary-selection ((t (:background "#3e3834"))))
 '(font-lock-builtin-face ((t (:foreground "#d3869b"))))
 '(font-lock-comment-face ((t (:foreground "#7c6f64"))))
 '(font-lock-function-name-face ((t (:foreground "#b8bb26"))))
 '(font-lock-keyword-face ((t (:foreground "#af5f5f"))))
 '(font-lock-string-face ((t (:foreground "#b8bb26"))))
 '(font-lock-type-face ((t (:foreground "#d3869b"))))
 '(font-lock-constant-face ((t (:foreground "#d3869b"))))
 '(font-lock-variable-name-face ((t (:foreground "#83a598"))))
 '(minibuffer-prompt ((t (:foreground "#b8bb26" :bold t))))
 '(font-lock-warning-face ((t (:foreground "#af5f5f" :weight bold))))
 '(linum-highlight-face ((t (:weight bold :inherit default))))
 '(link ((t (:foreground "#87afaf"))))
 '(highlight ((t (:background "#87afaf" :foreground "#3e3834"))))
 '(isearch ((t (:background "#bb6868" :foreground "#f9f6e8"))))
 '(default ((t (:background "#262220" :foreground "#fdf4c1"))))
 '(indent-guide-face ((t (:foreground "#464240" :slant normal)))))

;;;###autoload
(and load-file-name
    (boundp 'custom-theme-load-path)
    (add-to-list 'custom-theme-load-path
                 (file-name-as-directory
                  (file-name-directory load-file-name)))
    (add-to-list 'default-frame-alist '(foreground-color . "#fdf4c1"))
    (add-to-list 'default-frame-alist '(background-color . "#262220"))
)

(provide-theme 'coffee.emacs)
