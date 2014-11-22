ROLLNAME        = julia
VERSION        :=$(shell bash version.sh -v)
RELEASE        :=$(shell bash version.sh -h)
COLOR           = firebrick

REDHAT.ROOT     = $(CURDIR)
