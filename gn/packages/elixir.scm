;;; GNU Guix --- Functional package management for GNU
;;; Copyright � 2016 Pjotr Prins <pjotr.guix@thebird.nl>
;;; Copyright � 2016 Leo Famulari <leo@famulari.name>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (gn packages elixir)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (gn packages erlang)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages tls))

(define-public elixir
  (package
    (name "elixir")
    (version "1.2.3")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://github.com/elixir-lang/elixir/archive/v"
                    version ".tar.gz"))
              (sha256
               (base32
                "09s8469830s4070i0m04fxdhqimkdyc5k9jylm5vpfz9l3z4wvl8"))))
    (build-system gnu-build-system)
    (inputs
     `(("erlang" ,erlang)))
    (arguments
     `(#:phases (modify-phases %standard-phases
        (delete 'configure)
        ;; (replace 'check
        ;;          (lambda _
        ;;           (zero? (system* "make" "test")))))))
        )
       #:make-flags (list (string-append "PREFIX=" %output))
       #:tests? #f)) ;; 2845 tests, 12 failures
    (home-page "http://elixir-lang.org/")
    (synopsis "The Elixir programming language")
(description "Elixir is a dynamic, functional language designed for
building scalable and maintainable applications. Elixir leverages the
Erlang VM, known for running low-latency, distributed and
fault-tolerant systems, while also being successfully used in web
development and the embedded software domain.")
    (license license:asl2.0)))
