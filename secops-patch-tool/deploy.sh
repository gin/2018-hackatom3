#!/bin/sh

################################################################################
# Overview:
#   Blue-green deployment for cosmos-sdk to sentry and validator nodes
#
# Quick start:
#   Build cosmos-sdk
#   $ cd cosmos-sdk && git checkout <TAG>
#   $ make get_tools && make get_vendor_deps && make install
#
#   $ sh ~/2018-hackatom/secops-patch-tool/deploy.sh
#
################################################################################

# Checks for unset variables and environmental variables
set -u

gobin=$GOBIN    # Assumes gaiad and gaiacli is here after building
version=$($GOBIN/gaiad version)

mkdir ~/cosmos/$version
rm ~/cosmos/current
ln -s ~/cosmos/$version ~/cosmos/current
mv $gobin/gaia* ~/cosmos/current
~/cosmos/current/gaiad start --pruning=everything
