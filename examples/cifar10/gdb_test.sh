#!/usr/bin/env sh
set -e

TOOLS=./build/tools

gdb --args $TOOLS/caffe train \
  --solver=examples/cifar10/cifar10_quick_solver.prototxt $@ \
  2>&1 | tee /home/cwwoods/caffe-for-blis/logs/gdb_report.txt

# reduce learning rate by factor of 10 after 8 epochs
# $TOOLS/caffe train \
    # --solver=examples/cifar10/cifar10_quick_solver_lr1.prototxt \
    # --snapshot=examples/cifar10/cifar10_quick_iter_4000.solverstate $@
