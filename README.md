# githooks

This code generates global handlers for githooks that allow more control over hooks:

* Support for multiple scripts per hook globally
* Calls global hooks AND repo hooks
* Support ignoring git repo hooks in `.githookignore`

## Installation

Running `make install` does the following:

* installs your global hooks into `$HOME/.config/githooks`
* sets your global git config for hooks to this folder `$HOME/.config/githooks`
If you want to install your hooks in a different path:

`PREFIX=$HOME/src/githooks make install`

## Contrib

Scripts that can be put in your global githooks can be found in ./contrib
