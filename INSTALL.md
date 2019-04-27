# Installation

See http://caffe.berkeleyvision.org/installation.html for the latest
installation instructions.

Basic install Instructions (Barebones instructions to compile and run google test):
1) run cp Makefile.config.example Makefile.config

2) run make -f [makefile_name] -j4 all

3) run make -f [makefile_name] -j4 test

4) run make -f [makefile_name] runtest

Detail Install Instructions:
1) run cp Makefile.config.example Makefile.config

The steps here become slightly system specific. You might need to adjust 
certain parts of the Makefile.config that differ from system to system, but I will
details the parts that relate to add LAB-HERO support. 

In Makefile.config the variable BLAS must be defined as open:
BLAS=open

This forces openblas to be used. If you are using a manually compiled version 
of openblas you will need to specify the path to the blas library like so:
BLAS_INCLUDE := /home/cwwoods/openblas/include
BLAS_LIB := /home/cwwoods/openblas/lib

This caused some bugs for me if openblas was also installed via a package manager. I would
leave those variables commented out so the default location is used instead.

Next we must edit Makefile_labhero to also include LAB-HERO. Open Makefile_labhero 
and go to approximately line 386. This is a conditional statement in the Makefile to 
decide which BLAS library to compile with.  

The following needs to be your conditional part for openblas:
else ifeq ($(BLAS), open)
    # OpenBLAS
    BLAS_LIB += $(HOME)/lab-hero/src/x86-64/strassend
    LIBRARIES += labhero_cblas
    LIBRARIES += openblas 

Its likely that this will be similar to how it already is, but BLAS_LIB += should be set equal
to the path to your lab-hero static library .a file. This can be wherever you want it to be. Additionally
LIBRARIES needs labhero_cblas appended to it so it knows to add it to -l when compiling. 

After all this run steps 2 - 4 of the basic install instructions. You may need to solve system specific issues.

In order to test caffe on a true net I would follow this tutorial:
http://caffe.berkeleyvision.org/gathered/examples/cifar10.html
(DONT FORGET TO DO THE STEP THAT PREPARES THE DATASET)

Once you have run that tutorial your dataset will be prepared and you can run the following scripts
./examples/cifar10/gdb_test.sh
./examples/cifar10/train_cifar.sh

gdb_test.sh is train_cifar, but it runs it through gdb instead. These must be run from CAFFE_ROOT_DIR.
It is also work noting that you will want to edit the script files to change where logs are stored. By default it
goes to /home/cwwoods/caffe-for-blis/logs but this should be changed to your path. 

