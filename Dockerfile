# Inherit from the main guacamole official image
FROM guacamole/guacamole:1.5.4

# Make directories to support adding in jars
USER root
RUN mkdir -p /opt/guacamole/lib
RUN mkdir -p /opt/guacamole/extensions
RUN mkdir -p /tmp
WORKDIR /tmp

# Download jar that supports saml (Azure Entra ID)
RUN curl -O https://archive.apache.org/dist/guacamole/1.5.4/binary/guacamole-auth-sso-1.5.4.tar.gz
RUN tar -xvzf /tmp/guacamole-auth-sso-1.5.4.tar.gz
RUN cp /tmp/guacamole-auth-sso-1.5.4/saml/guacamole-auth-sso-saml-1.5.4.jar /opt/guacamole/extensions/

# Download jar that supports DB (postgres) authentication
RUN curl -O https://archive.apache.org/dist/guacamole/1.5.4/binary/guacamole-auth-jdbc-1.5.4.tar.gz
RUN tar -xvzf /tmp/guacamole-auth-jdbc-1.5.4.tar.gz
RUN cp /tmp/guacamole-auth-jdbc-1.5.4/postgresql/guacamole-auth-jdbc-postgresql-1.5.4.jar /opt/guacamole/extensions/

# Download jar that supports DB (postgres)
RUN curl -O https://jdbc.postgresql.org/download/postgresql-42.6.2.jar
RUN cp /tmp/postgresql-42.6.2.jar /opt/guacamole/lib/
RUN rm -rf /tmp/*

# Now last 3 lines from the official image that actually start the guacamole service
USER guacamole
EXPOSE 8080
CMD ["/opt/guacamole/bin/start.sh"]