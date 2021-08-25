#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
This sample script opens a ODF file using OpenOffice.org and
exports it as PDF.
"""
#
# Copyright (c) 2008 by Hartmut Goebel <h.goebel@goebel-consult.de>
# Licenced under the GNU General Public License v3 (GPLv3)
# see file LICENSE-gpl-3.0.txt
#
# Based on some ideas from LX-office's 'oo-uno-convert-pdf.py'
# (see <http:///www.lx-office.org>).
#
# This is just a sample script for openoffice-python. If you are
# looking for a converter which supports more formats, you may have a
# look at <http://www.artofsolving.com/opensource/pyodconverter>
# (which does not use openoffiec-python).
#

import openoffice.interact
import unohelper
from com.sun.star.beans import PropertyValue

import sys
import os.path

def write_pdf(doc, pdf_filename):
    out_props = (
        PropertyValue("FilterName", 0, "writer_pdf_Export", 0),
        PropertyValue("Overwrite", 0, True, 0),
        )
    pdf_filename = os.path.expanduser(pdf_filename)
    pdf_filename = os.path.abspath(pdf_filename)
    pdf_url = unohelper.systemPathToFileUrl(pdf_filename)
    print >> sys.stderr, pdf_url
    doc.storeToURL(pdf_url, out_props)


def convert2pdf(odf_filename, pdf_filename=None, opts=None):
    desktop = openoffice.interact.Desktop(host=opts.host, port=opts.port)
    # If the file does not exist, this will fail with:
    # openoffice.interact.IllegalArgumentException: URL seems to be
    #                      an unsupported one.
    # (where the module name is missleading!)
    doc = desktop.openFile(odf_filename, hidden=True)
    if not pdf_filename:
        pdf_filename = os.path.splitext(odf_filename)[0] + '.pdf'
    write_pdf(doc, pdf_filename)
    doc.dispose()
    if opts.tear_down:
        print >> sys.stderr, "Tear down is not yet implemented."
        #desktop.teardown()

if __name__ == '__main__':
    import optparse
    parser = optparse.OptionParser('%prog [options] ODF-Filename [PDF-Filename]')
    parser.add_option('--tear-down', action='store_true',
                      help="tear down OOo after convertion")
    group = parser.add_option_group('To connect to already running server use:')
    group.add_option('--host',  #default='localhost',
                     help="hostname/ip of server (default: %default)")
    group.add_option('--port',  default=2002, type=int,
                     help="port the server is listening on (default: %default)")

    opts, args = parser.parse_args()
    if len(args) == 0 or len(args) > 2:
        parser.error('expects one or two arguments')
    if not opts.host:
        opts.port = None
    convert2pdf(*args, **{'opts': opts})
