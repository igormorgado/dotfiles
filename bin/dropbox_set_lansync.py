#!/usr/bin/env python
# Python script to enable or disable dropbox LAN-sync
# This file written by Andrew Scheller, 2010-11-09

import sys
import os
from pyDropboxValues import *

dbfile, dbfnver = GetConfigDbFilename()
connection = GetDbConnection(dbfile)
dbver = GetDbVersion(dbfnver, connection)

if dbver == 0:
	key = 'p2p_enabled'
elif dbver == 1:
	key = 'p2p_enabled'
else:
	raise Exception('Unhandled DB schema version %d' % dbver)

try:
	if len(sys.argv) == 2 and sys.argv[1] in ('on', 'off'):
		enable_lansync = (sys.argv[1] == 'on')
		if dbver == 0:
			value = enable_lansync
		elif dbver == 1:
			value = 1 if enable_lansync else 0
		else:
			raise Exception('Unhandled DB schema version %d' % dbver)
		WriteDbValue(connection, dbver, key, value)
	else:
		print "Usage: %s <on|off>" % os.path.basename(sys.argv[0])
except Exception as detail:
	print "An error occured: %s" % detail
finally:
	connection.close()

