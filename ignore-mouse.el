;;; ignore-mouse.el --- Ignore mouse inputs globally  -*- lexical-binding: t -*-

;; URL: https://github.com/dradetsky/ignore-mouse
;; Version: 0.0.1
;; Package-Requires: ((emacs "24.3"))

;; This file is NOT part of GNU Emacs.

;; SPDX-License-Identifier: WTFPL

;;; Commentary:

;; TODO

;;; Code:

(require 'cl-lib)

(defgroup ignore-mouse nil
  "Ignore mouse inputs globally."
  :prefix "ignore-mouse-"
  :group 'mouse)

(defcustom ignore-mouse-mode-lighter " NoMouse"
  "Mode-line lighter for `ignore-mouse-global-mode'."
  :group 'ignore-mouse
  :type 'string)

(defconst ignore-mouse/base-events
  '("mouse" "down-mouse" "up-mouse" "drag-mouse"))
(defconst ignore-mouse/wheel-events
  '("wheel-down" "wheel-up" "wheel-left" "wheel-right"))
(defconst ignore-mouse/touch-events '("pinch"))

(defun ignore-mouse/gen-numbered (elist n)
  (cl-loop for s in elist
           nconc (cl-loop for k from 1 to n
                          collect (concat s "-" (int-to-string k)))))

(defun ignore-mouse/anglefy (elist)
  (mapcar (lambda (x) (concat "<" x ">")) elist))

(defconst ignore-mouse/default-event-ids
  (ignore-mouse/anglefy
   (append (ignore-mouse/gen-numbered ignore-mouse/base-events 7)
           ignore-mouse/wheel-events
           ignore-mouse/touch-events)))

(defun ignore-mouse/apply-to (map &optional arg-elist)
  (let ((elist (or arg-elist ignore-mouse/default-event-ids)))
    (cl-loop for e in elist
             do (keymap-set map e (lambda (_prompt) [])))))

(defun ignore-mouse/unapply-to (map &optional arg-elist)
  (let ((elist (or arg-elist ignore-mouse/default-event-ids)))
    (cl-loop for e in elist
             do (keymap-unset map e))))

(defvar ignore-mouse-event-ids ignore-mouse/default-event-ids
  "List of event ids to be ignored, as in \\='(\"<mouse-1>\").")

;;;###autoload
(define-minor-mode ignore-mouse-global-mode
  "Ignore mouse globally."
  :require 'ignore-mouse
  :lighter 'ignore-mouse-mode-lighter
  :global t
  (if ignore-mouse-global-mode
      (ignore-mouse/apply-to input-decode-map ignore-mouse-event-ids)
    (ignore-mouse/unapply-to input-decode-map ignore-mouse-event-ids)))

(provide 'ignore-mouse)

;;; ignore-mouse.el ends here
