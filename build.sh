#!/bin/sh

cd chef-repo && rm -fr cookbooks && sh setup-berks.sh
cd .. && docker build -t ubuntu:build .
