;;; ignore-mouse-test.el --- test suite -*- lexical-binding: t -*-

;;; TODO: dox

(require 'ignore-mouse)
(require 'buttercup)

(describe "ignore-mouse/gen-numbered"
  (it "makes mouse-1"
    (expect (ignore-mouse/gen-numbered ignore-mouse/base-events 7)
            :to-contain
            "mouse-1"))

  (it "makes other ids"
    (let ((result (ignore-mouse/gen-numbered ignore-mouse/base-events 7)))
      (expect result :to-contain "mouse-7")
      (expect result :to-contain "down-mouse-2")
      (expect result :to-contain "drag-mouse-3"))))

(describe "ignore-mouse/anglefy"
  (it "makes <mouse-1>"
    (let ((result0 (ignore-mouse/gen-numbered ignore-mouse/base-events 7)))
      (expect (ignore-mouse/anglefy result0)
              :to-contain
              "<mouse-1>"))))

(describe "ignore-mouse/default-event-ids"
  (it "has some stuff"
    (print ignore-mouse/default-event-ids)
    (expect ignore-mouse/default-event-ids :to-contain "<mouse-1>")
    (expect ignore-mouse/default-event-ids :to-contain "<pinch>")))
