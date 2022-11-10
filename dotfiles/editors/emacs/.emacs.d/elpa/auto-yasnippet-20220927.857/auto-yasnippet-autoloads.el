;;; auto-yasnippet-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "auto-yasnippet" "auto-yasnippet.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from auto-yasnippet.el

(autoload 'aya-create "auto-yasnippet" "\
Create a snippet from the text between BEG and END.
When the bounds are not given, use either the current region or line.

Remove `aya-marker' prefixes, write the corresponding snippet to
`aya-current', with words prefixed by `aya-marker' as fields, and
mirrors properly set up.

\(fn &optional BEG END)" t nil)

(autoload 'aya-create-one-line "auto-yasnippet" "\
A simplistic `aya-create' to create only one mirror.
You can still have as many instances of this mirror as you want.
It's less flexible than `aya-create', but faster.
It uses a different marker, which is `aya-marker-one-line'.
You can use it to quickly generate one-liners such as
menu.add_item(spamspamspam, \"spamspamspam\")" t nil)

(autoload 'aya-expand "auto-yasnippet" "\
Insert the last yasnippet created by `aya-create'.

Optionally use PREFIX to set any field as `$0' for wrapping the
current region. (`$0' also sets the exit point after `aya-expand'
when there's no active region.) When PREFIX is it defaults to 1.

For example let's say the second field in a snippet is where you
want to wrap the currently selected region.

Use `M-2' \\[aya-expand].

If we use this text as a snippet:

```~lang
~code
````'

and assume the selected region as:

`let somePrettyComplexCode = \"Hello World!\"'

we'd do `M-2' \\[aya-expand] which allows us to
fill in `~lang' as `javascript' and wraps our
code into the code-fences like this.

```javascript
let somePrettyComplexCode = \"Hello World!\"
```

Hint: if you view the current snippet(s) in history with
`aya-expand-from-history'. The snippets are shown with their
fields numbered.

In our example the snippet looks like like this:

\\`\\`\\`$1⤶$2⤶\\`\\`\\`⤶

\(fn &optional PREFIX)" t nil)

(autoload 'aya-expand-from-history "auto-yasnippet" "\
Select and insert a yasnippet from the `aya-history'.
The selected snippet will become `aya-current'
and will be used for consecutive `aya-expand' commands.

When PREFIX is given, the corresponding field number is
modified to make it the current point after expansion.

\(fn &optional PREFIX)" t nil)

(autoload 'aya-delete-from-history "auto-yasnippet" "\
Select and delete one or more snippets from `aya-history'.
If the selected snippet is also `aya-current', it will be replaced
by the next snippet in history, or blank if no other history items
are available." t nil)

(autoload 'aya-open-line "auto-yasnippet" "\
Call `open-line', unless there are abbrevs or snippets at point.
In that case expand them.  If there's a snippet expansion in progress,
move to the next field.  Call `open-line' if nothing else applies." t nil)

(autoload 'aya-yank-snippet "auto-yasnippet" "\
Insert current snippet at point.
To save a snippet permanently, create an empty file and call this." t nil)

(autoload 'aya-yank-snippet-from-history "auto-yasnippet" "\
Insert snippet from history at point." t nil)

(register-definition-prefixes "auto-yasnippet" '("aya-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; auto-yasnippet-autoloads.el ends here
