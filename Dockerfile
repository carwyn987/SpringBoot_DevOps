FROM redhat/ubi9

# environment setup
ENV JAVA_HOME=/usr/lib/jvm/java-23-openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# java setup
RUN bash <<EOF

dnf -y module enable java:23
dnf -y install maven
dnf -y install java-23-openjdk-devel
dnf clean all
groupadd -r myusergroup
useradd -m -g myusergroup myuser
mkdir -p /home/myuser/app
chown myuser:myusergroup /home/myuser/app

EOF

# set up user
USER myuser
WORKDIR /home/myuser/app

ENTRYPOINT ["/bin/bash"]

