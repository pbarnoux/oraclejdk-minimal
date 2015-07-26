FROM debian:jessie
MAINTAINER Pierre Barnoux <pbarnoux@gmail.com>

ENV JAVA_HOME="/usr/local/jdk1.8.0_45"

# curl requires 10 MB while wget needs 30+ MB
RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl && \
# Download Oracle JDK tarball
	curl -qo /tmp/jdk.tar.gz \
		--retry 3 \
		--location \
		--cacert /etc/ssl/certs/GeoTrust_Global_CA.pem \
		--header "Cookie: oraclelicense=accept-securebackup-cookie;" \
		http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.tar.gz && \
# Uncompress tarball
	tar zxvf /tmp/jdk.tar.gz -C /usr/local && \
# Create links
	ln -s ${JAVA_HOME}/bin/java /usr/bin/java && \
	ln -s ${JAVA_HOME}/bin/javac /usr/bin/javac && \
	ln -s ${JAVA_HOME}/bin/jar /usr/bin/jar && \
# Clear sources to save space
	rm -rf ${JAVA_HOME}/src.zip ${JAVA_HOME}/javafx-src.zip ${JAVA_HOME}/man && \
# Clean various caches
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /tmp/* /var/tmp/*

CMD ["/bin/bash"]

