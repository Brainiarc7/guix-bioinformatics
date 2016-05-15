;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2016 Dennis Mungai <dmngaie@gmail.com>
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

(define-module (gn packages openfyba)
  #:use-module ((guix licenses))
  #:use-module (gnu packages)
  #:use-module (gnu packages autotools)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages base)
  ;;#:use-module (gnu packages tls)
  #:use-module (gnu packages zip)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages bootstrap)
  #:use-module (guix git-download))

(define-public openfyba
  (package
   (name "openfyba")
   (version "4.1.1")
   (source (origin
             (method url-fetch)
             (uri (string-append "https://github.com/kartverket/fyba/archive/"
                                 version ".tar.gz"))
             (file-name (string-append name "-" version ".tar.gz"))
             (sha256
              (base32
               "0ya1agi78d386skq353dk400fl11q6whfqmv31qrkn4g5vamixlr"))))
    (inputs `(("zip" ,zip)
             ("autoconf" ,autoconf)
             ("automake" ,automake)
             ("libtool" ,libtool)
             ("libgcrypt" ,libgcrypt)))                                              
    (build-system gnu-build-system)
     (arguments
     '(#:phases (modify-phases %standard-phases
                    (add-after 'unpack `bootstrap
                      (lambda _
                        (zero? (system* "autoreconf" "-vfi")))))))    
    (home-page "http://labs.kartverket.no/sos/")
    (synopsis "source code release of the FYBA library")
    (description "OpenFYBA is the source code release of the FYBA library.")
    (license (list gpl2))))
