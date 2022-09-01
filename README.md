# A reproducible LFS build
Building your own Linux distribution from scratch is a lot of fun. It's also a pain in the ass when you mess up compiling some tool and need to start over from scratch, as each rebuild is another opportunity to make a new error, requiring you to repeat your Sysyphean task of debugging and rebuilding.

Inspired by [this series](https://www.youtube.com/watch?v=IXA0GNTLf_Q), I've written shell scripts that automate this process for me. Please note that I've only tested these scripts on my own setup (running Alpine TK from a bootable USB on a custom-built PC with an x86\_64 processor and an M.2 SSD with about 2TB of storage). To run these scripts on a different setup, you'll need to adjust them to fit your system.

Additionally, because LFS is meant to be customizable, there are a lot of decision points where I made a choice based on my own needs/goals. You may wish to make a different decision, so I'd highly recommend working with the [LFS book](https://www.linuxfromscratch.org/lfs/view/stable/index.html) to figure out where you would like to choose an alternative route and change the scripts accordingly.

## Setup
Because I'm building on a bootable USB, every time I power off the computer, I have to set up Alpine anew, which means reinstalling any packages needed to complete the rest of the build. This repository includes a script (`install-development-packages.sh`) to do just that, It also includes some packages used only for developing this repo, such as `vim` and the GitHub CLI. I'd recommend installing all of the packages (although you can adjust your `~/.vimrc` file to fit your preferences) so that you can make your own repo to reflect your customizations. To that end, you should set up your build environment with the following steps:
  1. Obtain a USB stick with adequate storage. I bought a 32GB Sandisk, but you can probably make do with less, as Alpine has a pretty small profile, and you'll be installing packages into RAM.
  2. Download your chosen image from [alpinelinux.org](https://alpinelinux.org/downloads), although you can choose a different distro if you are willing to adjust some of the scripts. (At a minimum, this would require changing all the lines with `apk add ...` to the appropriate syntax for your distribution.)
  3. Burn the ISO to the USB. For Alpine, see [these instructions](https://docs.alpinelinux.org/user-handbook/0.1a/Installing/medium.html#using-the-image).
  4. Boot the USB on the computer you plan to use for building LFS. If the computer has an Ethernet connection to the internet, your life will be much easier, although Alpine has [instructions for getting Wifi working](https://docs.alpinelinux.org/user-handbook/0.1a/Installing/manual.html#_networking) if needed. If not using Alpine, look up the documentation for your chosen distribution.
  5. Set up Alpine using the `setup-alpine` script. The defaults should be adequate for each of the options, although you may wish to choose an apk mirror that's closer to you. See [Alpine's docs](https://docs.alpinelinux.org/user-handbook/0.1a/Installing/setup_alpine.html) for more details, or look up the documentation for your chosen distribution.
  6. Install git with `apk update && apk upgrade && apk add git` (or the equivalent for your distribution). Configure git with your name and email (`git configure --global user.name "<Your Name>" && git configure --global user.email "<Your Email>"`).
  7. Clone this repository with `git clone https://github.com/ethanscorey/lfs.git` (replacing the URL with the URL to your repository if you followed the suggestion above to create your own fork of the repo).
  8. Run `setup.sh <PATH_TO_LFS_DISK> <PASSWORD_FOR_LFS_USER>`, then run `version-check.sh` and make sure all of the necessary packages are installed. See the [LFS book](https://www.linuxfromscratch.org/lfs/view/stable/chapter02/hostreqs.html) for more details. **If you are building for a system with a non-x86_64 processor, edit the line `export LFS_TGT=x86_64-lfs-linux-gnu` before running this script. If you ran it without making this change, run it again.**\

At this point, you should be logged in as the `lfs` user (confirm that you see `lfs` in your bash prompt), and the target system should be mounted. You can confirm this by runnnning `fdisk -l`. You should also confirm that `$LFS` and `$LFS_TGT` have been set to the correct values by running `echo $LFS $LFS_TGT`.

## Building the Cross-Compilation Toolchain
TKTK

## Building the System
TKTK

## Building in Stages
LFS is meant to be built in one session, but if you have to reboot the system, make sure to follow steps 4-8 from above. However, if you have already compiled packages to the target system, you may wish to avoid repeating those steps. To do that, make sure to **comment out the line `source setup-disk.sh "$LFS_DISK"` in the `setup.sh` script**. Failure to do so will reformat your disk, resulting in data loss.
