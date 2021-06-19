# -*- coding: utf-8; mode: tcl; c-basic-offset: 4; indent-tabs-mode: nil; tab-width: 4; truncate-lines: t -*- vim:fenc=utf-8:et:sw=4:ts=4:sts=4
#
# Usage:
# PortGroup     boost_provider 1.0
#
# This port group provides support for boost ports, encapsulating shared logic, etc.

namespace eval boost_provider {}

options boost_provider.version
default boost_provider.version ""

proc boost_provider::version {} {
    return [option boost_provider.version]
}

proc boost_provider::version_nodot {} {
    set ver [boost_provider::version]
    set ver_nodot ""

    if { ${ver} ne "" } {
        set ver_nodot
            [string map {. {}} ${ver}]
    }

    return ${ver_nodot}
}

proc boost_provider::configure_build {} {
    set ver [boost_provider::version]

    if { ${ver} eq "" } {
        ui_msg "boost_provider::configure_build called; no version configured yet"
    } else {
        ui_msg "boost_provider::configure_build called; version configured: ${ver}"
    }
}

port::register_callback boost_provider::configure_build

#boost_provider::configure_build

proc boost_provider::set_params {option action args} {
    if { ${action} ne "set" } {
        return 0
    }

    boost_provider::configure_build
}

option_proc boost_provider.version boost_provider::set_params

