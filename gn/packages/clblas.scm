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

(define-module (gn packages clblas)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix packages)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages bootstrap)
  #:use-module (gnu packages base)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages image)
  #:use-module (gnu packages video)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages mpi)
  #:use-module (gnu packages ruby)
  #:use-module (gnu packages web)
  #:use-module (gnu packages python)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages zip)  
  #:use-module (gnu packages linux))

(define-public clblas
  (package
    (name "clblas")
    (version "2.10")
    (source (origin
             (method url-fetch)
             (uri (string-append "https://github.com/clMathLibraries/clBLAS/archive/v"
                                 version ".tar.gz"))
             (sha256
              (base32
               "0adlb02lqzrklfybhnv4n0p37mvkvdi3vqiwa05x2mv05ywnr93j"))))
    (build-system cmake-build-system)    
    (arguments `(#:tests? #f 
                 #:configure-flags '("../clBLAS-2.10/src" "-DBUILD_SHARED_LIBS=ON" "-DCMAKE_BUILD_TYPE=Release" "-DBUILD_TEST=OFF")))
    (native-inputs `(("autoconf" ,autoconf)
        ("automake" ,automake)
        ("cmake" ,cmake)
        ("gfortran" ,gfortran)
        ("libtool" ,libtool)
        ("pkg-config" ,pkg-config)))
    (inputs `(("curl" ,curl)
       ("dbus" ,dbus)
       ("boost" ,boost)
       ("enca" ,enca)
       ("eudev" ,eudev)
       ("fftw-openmpi" ,fftw-openmpi)
       ("glew" ,glew)       
       ("libcap" ,libcap)
       ("libjpeg" ,libjpeg)
       ("libltdl" ,libltdl)
       ("libtiff" ,libtiff)
       ("mesa-utils" ,mesa-utils)
       ("openmpi" ,openmpi)
       ("ocl-icd" ,ocl-icd)
       ("opencl-headers" ,opencl-headers)
       ("randrproto" ,randrproto)
       ("libxrandr" ,libxrandr)
       ("xineramaproto" ,xineramaproto)
       ("libxinerama" ,libxinerama)
       ("libxcursor" ,libxcursor)
       ("python" ,python-2)))       
    (home-page "http://www.glfw.org/")
    (synopsis "glfw is an Open Source, multi-platform library for creating windows with OpenGL contexts and receiving input and events.")
    (description "glfw is an Open Source, multi-platform library for creating windows with OpenGL contexts and receiving input and events.")
    (license (list l:gpl2
                   l:asl2.0))))
    
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
             ("ruby" ,ruby)
             ("libtool" ,libtool)
             ("opencl-headers" ,opencl-headers)
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
    (license (list l:gpl2
                   l:ruby))))
    
(define-public opencl-headers
(let ((commit "c1770dc"))
  (package
    (name "opencl-headers")
    (version (string-append "2.1-" commit ))
    (source (origin
              (method git-fetch)
              (uri (git-reference
              (url "https://github.com/KhronosGroup/OpenCL-Headers.git")
              (commit commit)))
              (file-name (string-append name "-" commit))
              (sha256
               (base32
                "0m9fkblqja0686i2jjqiszvq3df95gp01a2674xknlmkd6525rck"))))
    (propagated-inputs '())
    (inputs '())
    (native-inputs '())
    (build-system gnu-build-system)
    (arguments
     '(#:phases
       (modify-phases %standard-phases
         (delete 'configure)
         (delete 'build)
         (delete 'check)
         (replace 'install
                  (lambda* (#:key outputs #:allow-other-keys)
                    (copy-recursively "." (string-append
                                                 (assoc-ref outputs "out")
                                                 "/include/CL")))))))
    (synopsis "The Khronos OpenCL headers")
    (description "This package provides the Khronos OpenCL headers")
    (home-page "https://www.khronos.org/registry/cl/")
    (license (list l:gpl2)))))
    

