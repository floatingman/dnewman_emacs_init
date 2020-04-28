(require 'package)
(package-initialize)

(require 'ido)

;; more stuff

(defun dnewman-get-fullpath (@file-relative-path)
  "Return the full path of *file-relative-path, relative to caller's file location.

Example: If you have this line
 (dnewman-get-fullpath \"../xyz.el\")
in the file at
 /home/mary/emacs/emacs_lib.el
then the return value is
 /home/mary/xyz.el
Regardless how or where emacs_lib.el is called.

This function solves 2 problems.

① If you have file A, that calls the `load' on a file at B, and B calls `load' on file C using a relative path, then Emacs will complain about unable to find C. Because, emacs does not switch current directory with `load'.

To solve this problem, when your code only knows the relative path of another file C, you can use the variable `load-file-name' to get the current file's full path, then use that with the relative path to get a full path of the file you are interested.

② To know the current file's full path, emacs has 2 ways: `load-file-name' and `buffer-file-name'. If the file is loaded by `load', then `load-file-name' works but `buffer-file-name' doesn't. If the file is called by `eval-buffer', then `load-file-name' is nil. You want to be able to get the current file's full path regardless the file is run by `load' or interactively by `eval-buffer'."

  (concat (file-name-directory (or load-file-name buffer-file-name)) @file-relative-path)
)

;; --------------------------------------------------
;; load the plain emacs settings

(load (dnewman-get-fullpath "dnewman_emacs_settings"))


;; more here

;; --------------------------------------------------
;; load files

;;(load (dnewman-get-fullpath "dnewman_emacs_abbr"))
;;(load (dnewman-get-fullpath "dnewman_emacs_keybinding"))
;;(load (dnewman-get-fullpath "dnewman_emacs_keybinding_mode_specific"))
;;(load (dnewman-get-fullpath "dnewman_emacs_settings_external_packages"))
;;(load (dnewman-get-fullpath "dnewman_emacs_file_association"))
;;(load (dnewman-get-fullpath "dnewman_emacs_html"))
;; more here
;;(load (dnewman-get-fullpath "dnewman_emacs_misc"))
