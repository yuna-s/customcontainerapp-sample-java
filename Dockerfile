FROM mcr.microsoft.com/azure-app-service/java:11-java11_stable

ENV PORT 80
EXPOSE 80 2222

ARG JAR_FILE=./complete/target/spring-boot-complete-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} app.jar

#ssh
# Install OpenSSH and set the password for root to "Docker!". In this example, "apk add" is the install instruction for an Alpine Linux-based image.
RUN apk add openssh \
     && echo "root:Docker!" | chpasswd 

# Copy the sshd_config file to the /etc/ssh/ directory
COPY sshd_config /etc/ssh/

# Copy and configure the ssh_setup file
RUN mkdir -p /tmp
COPY ssh_setup.sh /tmp
RUN chmod +x /tmp/ssh_setup.sh \
    && (sleep 1;/tmp/ssh_setup.sh 2>&1 > /dev/null)

COPY init.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/init.sh


#ENTRYPOINT ["java", "-Dserver.port=80", "-jar", "/app.jar"]
ENTRYPOINT ["/usr/local/bin/init.sh"]


## install tcpping
# ENV BIN_DIR=/usr/bin
# WORKDIR ${BIN_DIR}

# RUN apk --update add tcptraceroute bc && rm -rf /var/cache/apk/*
# RUN wget http://www.vdberg.org/~richard/tcpping
# RUN chmod 755 tcpping 


# docker command
# VSCode のコマンドパレットから docker build
# tag name:
# yunasugimotoappsregistry.azurecr.io/spring-boot-docker:latest
# cf.
# https://docs.microsoft.com/ja-jp/azure/app-service/quickstart-custom-container?tabs=java&pivots=container-linux#create-and-build-image
# https://docs.microsoft.com/ja-jp/azure/app-service/configure-custom-container?pivots=container-linux#enable-ssh
