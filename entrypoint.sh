#!/bin/sh
chown -R choreouser:choreo /app/worker
chown -R choreouser:choreo /app/data
exec node server/server.js
