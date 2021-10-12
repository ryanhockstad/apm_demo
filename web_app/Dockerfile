FROM openjdk:17-alpine
COPY ./ca.crt .
RUN keytool -keystore /opt/openjdk-17/lib/security/cacerts -storepass changeit -noprompt -trustcacerts -importcert -alias elastic_cert -file ca.crt
CMD /bin/sh