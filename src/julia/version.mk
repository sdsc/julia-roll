NAME           = sdsc-julia
VERSION        = 0.3.11
RELEASE        = 2
PKGROOT        = /opt/julia

SRC_SUBDIR     = julia

SOURCE_NAME    = julia
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)_483dbf5279
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = julia

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
