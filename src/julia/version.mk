NAME           = julia
VERSION        = 0.3.2
RELEASE        = 1
PKGROOT        = /opt/julia

SRC_SUBDIR     = julia

SOURCE_NAME    = julia
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = 0.3.2_8227746b95
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = julia

TAR_GZ_PKGS       = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
