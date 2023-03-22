#!/bin/bash
#Init all functions in developing
git submodule update --init --recursive

# git clone git@github.com:Peize-Liu/CommitFormatTest.git
cp ./prepare-commit-msg ./.git/hooks
cp ./prepare-commit-msg ./.git/modules/PX4-Autopilot/hooks
cp ./prepare-commit-msg ./.git/modules/NxtPX4-Hardware/hooks