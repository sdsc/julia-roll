# SDSC "julia" roll


## Overview

This roll bundles... julia 

For more information about the various packages included in the julia roll please visit their official web pages:

- <a href="http://julialang.org" target="_blank"></a> is is a high-level, high-performance dynamic programming language for technical computing, with syntax that is familiar to users of other technical computing environments.


## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must
download the appropriate julia source file(s) using a machine that does
have Internet access and copy them into the `src/<package>` directories on your
Rocks development machine.


## Dependencies

The sdsc-roll must be installed on the build machine, since the build process
depends on make include files provided by that roll.

The roll sources assume that modulefiles provided by the SDSC gnucompiler-roll
and python-roll are available, but it will build without them as long as the
environment variables they provide are otherwise defined.

The build process requires the MKL libraries and assumes that the MKL
modulefile provided by the SDSC intelmpi-roll is available 
(note that previously, the MKL library and the intel compiler were provided
by the intel-roll).  It will build without
the modulefile as long as the environment variables it provides are otherwise
defined.


## Building

To build the julia-roll, execute this on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make 2>&1 | tee build.log
```

A successful build will create the file `julia-*.disk1.iso`.  If you built
the roll on a Rocks frontend, proceed to the installation step. If you built the
roll on a Rocks development appliance, you need to copy the roll to your Rocks
frontend before continuing with installation.


## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll julia
% cd /export/rocks/install
% rocks create distro
```

Subsequent installs of compute and login nodes will then include the contents
of the julia-roll.  To avoid cluttering the cluster frontend with unused
software, the julia-roll is configured to install only on compute and
login nodes. To force installation on your frontend, run this command after
adding the julia-roll to your distro

```shell
% rocks run roll julia host=NAME | bash
```

where NAME is the DNS name of a compute or login node in your cluster.

In addition to the software itself, the roll installs julia environment
module files in:

```shell
/opt/modulefiles/applications/julia
```


## Testing

The julia-roll includes a test script which can be run to verify proper
installation of the roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/julia.t 
```
