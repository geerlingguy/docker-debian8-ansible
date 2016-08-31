FROM debian:jessie-backports
MAINTAINER Jeff Geerling

ENV DEBIAN_FRONTEND noninteractive

# Install Ansible via backports.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       --default-release jessie-backports \
       ansible \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

COPY initctl_faker .
RUN chmod +x initctl_faker && rm -fr /sbin/initctl && ln -s /initctl_faker /sbin/initctl

# Install Ansible inventory file
RUN mkdir -p /etc/ansible \
    && echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts
