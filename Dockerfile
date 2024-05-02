# Inherit from the main guacamole official image
FROM guacamole/guacamole:1.5.5

# Make directories to support adding in jars
USER root
RUN mkdir -p /etc/guacamole/lib
RUN mkdir -p /etc/guacamole/extensions
RUN mkdir -p /tmp
WORKDIR /tmp

# Download jar that supports saml (Azure Entra ID)
RUN curl -O https://archive.apache.org/dist/guacamole/1.5.5/binary/guacamole-auth-sso-1.5.5.tar.gz
RUN tar -xvzf /tmp/guacamole-auth-sso-1.5.5.tar.gz
RUN cp /tmp/guacamole-auth-sso-1.5.5/saml/guacamole-auth-sso-saml-1.5.5.jar /etc/guacamole/extensions/

# Download jar that supports DB (postgres) authentication
RUN curl -O https://archive.apache.org/dist/guacamole/1.5.5/binary/guacamole-auth-jdbc-1.5.5.tar.gz
RUN tar -xvzf /tmp/guacamole-auth-jdbc-1.5.5.tar.gz
RUN cp /tmp/guacamole-auth-jdbc-1.5.5/postgresql/guacamole-auth-jdbc-postgresql-1.5.5.jar /etc/guacamole/extensions/

# Download jar that supports DB (postgres)
RUN curl -O https://jdbc.postgresql.org/download/postgresql-42.6.2.jar
RUN cp /tmp/postgresql-42.6.2.jar /etc/guacamole/lib/
RUN rm -rf /tmp/*

# Now last 3 lines from the official image that actually start the guacamole service
WORKDIR /etc/guacamole
USER guacamole
EXPOSE 8080
CMD ["/opt/guacamole/bin/start.sh"]
