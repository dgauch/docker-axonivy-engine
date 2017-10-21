#!/bin/bash

cd /opt/AxonIvyEngine

# Build the database config
[ -z "$AXONIVY_SERVER_DB_URL" ] && export AXONIVY_SERVER_DB_URL=jdbc:postgresql://${DB_PORT_5432_TCP_ADDR}:${DB_PORT_5432_TCP_PORT}/AxonIvySystemDatabase
[ -z "$AXONIVY_SERVER_DB_USER" ] && export AXONIVY_SERVER_DB_USER=postgres

# Copy the license optionally provided by the data volume at /data. If there is no license, we just run in demo mode
if [ $(find /data -maxdepth 1 -type f -name '*.lic' -not -name ".*" | wc -l) -eq 1 ]; then
    find /data -maxdepth 1 -type f -name '*.lic' -not -name ".*" -exec cp {} configuration \;

    jre/bin/java -cp lib/ivy/*:lib/shared/* \
        ch.ivyteam.ivy.server.configuration.ServerConfigurationTool -configDb org.postgresql.Driver $AXONIVY_SERVER_DB_URL $AXONIVY_SERVER_DB_USER $AXONIVY_SERVER_DB_PASS;

    jre/bin/java -cp lib/ivy/*:lib/shared/* \
            ch.ivyteam.ivy.server.configuration.ServerConfigurationTool -createDb;

        jre/bin/java -cp lib/ivy/*:lib/shared/* \
                ch.ivyteam.ivy.server.configuration.ServerConfigurationTool --serverProperty WebServer.HTTP.Port=8081;

    jre/bin/java -cp lib/ivy/*:lib/shared/* \
        ch.ivyteam.ivy.server.configuration.ServerConfigurationTool -createAdmin AxonIvy AxonIvy;
fi

bin/AxonIvyEngine
