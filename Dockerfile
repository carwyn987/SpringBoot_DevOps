FROM rockylinux:9

# environment setup
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# package setup with heredoc for min(layers)
RUN bash <<EOF

dnf -y module enable java:23
dnf -y groupinstall "Development Tools"
dnf -y install maven \
               java-21-openjdk-devel \
               sudo \
               man \
               vim \
               wget \
               tree \
               net-tools \
               && dnf clean all

EOF

# Create the user and group dynamically based on the host user's UID and GID
# Pass these values when running the container, otherwise defaults to 1000:1000
ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd -g $USER_GID myusergroup && \
    useradd -u $USER_UID -g myusergroup -m myuser && \
    echo "myuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    mkdir -p /home/myuser/app && \
    chown myuser:myusergroup /home/myuser/app

# set up user
USER myuser
WORKDIR /home/myuser/app

ENTRYPOINT ["/bin/bash"]

