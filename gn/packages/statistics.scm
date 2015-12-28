(define-module (gn packages statistics)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system perl)
  #:use-module (guix build-system python)
  #:use-module (guix build-system ruby)
  #:use-module (guix build-system r)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages base)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cpio)
  #:use-module (gnu packages file)
  #:use-module (gnu packages java)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages machine-learning)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages popt)
  #:use-module (gnu packages protobuf)
  #:use-module (gnu packages python)
  #:use-module (gnu packages ruby)
  #:use-module (gnu packages statistics)
  #:use-module (gnu packages tbb)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages vim)
  #:use-module (gnu packages web)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages zip)
  #:use-module (gnu packages bootstrap)
  #:use-module (srfi srfi-1))

(define-public r-rcppeigen
(package
  (name "r-rcppeigen")
  (version "0.3.2.5.1")
  (source
    (origin
      (method url-fetch)
      (uri (cran-uri "RcppEigen" version))
      (sha256
        (base32
          "1j41kyr2xsq0ha3dhd0iz62kghkvhnf8zp15qb4kgj6www086b4s"))))
  (properties `((upstream-name . "RcppEigen")))
  (build-system r-build-system)
  (propagated-inputs
    `(("r-matrix" ,r-matrix)
      ("r-rcpp" ,r-rcpp)
      ("r-stats" ,r-stats)
      ("r-utils" ,r-utils)))
  (home-page "http://eigen.tuxfamily.org")
  (synopsis
    "'Rcpp' Integration for the 'Eigen' Templated Linear Algebra Library")
  (description
    "R and 'Eigen' integration using 'Rcpp'. 'Eigen' is a C++ template library for linear algebra: matrices, vectors, numerical solvers and related algorithms.  It supports dense and sparse matrices on integer, floating point and complex numbers, decompositions of such matrices, and solutions of linear systems.  Its performance on many algorithms is comparable with some of the best implementations based on 'Lapack' and level-3 'BLAS'. .  The 'RcppEigen' package includes the header files from the 'Eigen' C++ template library (currently version 3.2.5).  Thus users do not need to install 'Eigen' itself in order to use 'RcppEigen'. .  Since version 3.1.1, 'Eigen' is licensed under the Mozilla Public License (version 2); earlier version were licensed under the GNU LGPL version 3 or later. 'RcppEigen' (the 'Rcpp' bindings/bridge to 'Eigen') is licensed under the GNU GPL version 2 or later, as is the rest of 'Rcpp'.")
  (license #f)))


(define-public r-matrix
(package
  (name "r-matrix")
  (version "1.2-3")
  (source
    (origin
      (method url-fetch)
      (uri (cran-uri "Matrix" version))
      (sha256
        (base32
          "11zi02hj083jh20lnxsiimnx4brksavbv7dmkp659w33cfzsnnwg"))))
  (properties `((upstream-name . "Matrix")))
  (build-system r-build-system)
  (propagated-inputs
    `(("r-graphics" ,r-graphics)
      ("r-grid" ,r-grid)
      ("r-lattice" ,r-lattice)
      ("r-methods" ,r-methods)
      ("r-stats" ,r-stats)
      ("r-utils" ,r-utils)))
  (home-page
    "http://Matrix.R-forge.R-project.org/")
  (synopsis
    "Sparse and Dense Matrix Classes and Methods")
  (description
    "Classes and methods for dense and sparse matrices and operations on them using 'LAPACK' and 'SuiteSparse'.")
  (license gpl2+)))
