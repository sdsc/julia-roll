ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

NAME           = sdsc-julia
VERSION        = 1.1.0
RELEASE        = 0
PKGROOT        = /opt/julia

SRC_SUBDIR     = julia

SOURCE_NAME    = julia
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = julia-$(VERSION)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No\nAutoProv:No
RPM.PREFIX     = $(PKGROOT)
