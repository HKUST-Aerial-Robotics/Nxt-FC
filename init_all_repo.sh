#!/bin/bash
#Init all functions in developing
git submodule update --init --recursive

git clone git@github.com:Peize-Liu/CommitFormatTest.git
cp ./CommitFormatTest/prepare-commit-msg ./.git/hooks
cp ./CommitFormatTest/prepare-commit-msg ./.git/modules/NxtPX4-Hardware/hooks
cp ./CommitFormatTest/prepare-commit-msg ./.git/modules/NxtPX4-Hardware/hooks