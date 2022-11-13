;;; coffee.emacs-theme.el --- A warm theme for GNU emacs

;;; Copyright (C) 2022-2023

;;; Version: 1.2
;;; Author: Ari Archer <ari.web.xyz@gmail.com>, Coffee-theme <ari.web.xyz@gmail.com>
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
 '(indent-guide-face ((t (:foreground "#464240" :slant normal))))
 '(show-paren-match ((t (:weight bold))))
 '(show-paren-mismatch ((t (:foreground "#af5f5f" :weight bold))))
 '(helm-ff-directory ((t (:extend t :foreground "#87afaf"))))
 '(helm-selection ((t (:extend t :slant italic :weight bold))))
 '(header-line ((t (:inherit mode-line :background "#262220" :foreground "#ddd0c0" :box nil))))
 '(ansi-color-green ((t (:background "#87875f" :foreground "#87875f"))))
 '(ansi-color-faint ((t (:foreground "#8f9494"))))
 '(ansi-color-bright-black ((t (:background "#8f9494" :foreground "#8f9494"))))
 '(ansi-color-cyan ((t (:background "#6d978a" :foreground "#6d978a"))))
 '(ansi-color-bright-red ((t (:background "#bb6868" :foreground "#bb6868"))))
 '(ansi-color-bright-green ((t (:background "#849155" :foreground "#849155"))))
 '(ansi-color-bright-yellow ((t (:background "#c5c563" :foreground "#c5c563"))))
 '(ansi-color-magenta ((t (:background "#cd7998" :foreground "#cd7998"))))
 '(ansi-color-bright-white ((t (:background "#ddd0c0" :foreground "#ddd0c0"))))
 '(ansi-color-bright-cyan ((t (:background "#7ca296" :foreground "#7ca296"))))
 '(ansi-color-bright-blue ((t (:background "#87afaf" :foreground "#87afaf"))))
 '(ansi-color-red ((t (:background "#af5f5f" :foreground "#af5f5f"))))
 '(ansi-color-yellow ((t (:background "#bcbc6c" :foreground "#bcbc6c"))))
 '(ansi-color-black ((t (:background "#262220" :foreground "#262220"))))
 '(ansi-color-white ((t (:background "#bbbbbb" :foreground "#bbbbbb"))))
 '(ansi-color-bright-magenta ((t (:background "#c987a0" :foreground "#c987a0"))))
 '(ansi-color-blue ((t (:background "#666c7f" :foreground "#666c7f"))))
 '(default ((t (:background "#262220" :foreground "#fdf4c1")))))

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
