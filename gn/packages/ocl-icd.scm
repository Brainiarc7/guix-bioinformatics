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

(define-module (gn packages ocl-icd)
  #:use-module ((guix licenses))
  #:use-module (gnu packages)
  #:use-module (gnu packages autotools)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages base)
  #:use-module (gnu packages ruby)
  #:use-module (gnu packages zip)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages bootstrap)
  #:use-module (guix git-download))

(define-public ocl-icd
  (package
   (name "ocl-icd")
   (version "2.2.9")
   (source (origin
             (method url-fetch)
             (uri (string-append "https://forge.imag.fr/frs/download.php/716/ocl-icd-"
                                 version ".tar.gz"))
             (file-name (string-append name "-" version ".tar.gz"))
             (sha256
              (base32
               "1rgaixwnxmrq2aq4kcdvs0yx7i6krakarya9vqs7qwsv5hzc32hc"))))
    (inputs `(("zip" ,zip)
             ("autoconf" ,autoconf)
             ("automake" ,automake)
             ("libtool" ,libtool)
             ("ruby" ,ruby)
             ("libgcrypt" ,libgcrypt)))                                              
    (build-system gnu-build-system)
     (arguments
     '(#:phases (modify-phases %standard-phases
                    (add-after 'unpack `bootstrap
                      (lambda _
                        (zero? (system* "autoreconf" "-vfi")))))))    
    (home-page "https://forge.imag.fr/projects/ocl-icd/")
    (synopsis "OpenCL implementations are provided as ICD (Installable Client Driver).")
    (description "OpenCL implementations are provided as ICD (Installable Client Driver).
    An OpenCL program can use several ICD thanks to the use of an ICD Loader as provided by this project.
    This free ICD Loader can load any (free or non free) ICD")
    (license (list gpl2))))