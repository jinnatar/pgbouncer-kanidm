from opensuse/tumbleweed:latest
RUN rpm --import https://build.opensuse.org/projects/server:database:postgresql/signing_keys/download?kind=gpg
RUN zypper -n addrepo https://download.opensuse.org/repositories/server:database:postgresql/openSUSE_Tumbleweed/server:database:postgresql.repo
RUN zypper -n refresh
RUN zypper -n install kanidm-unixd-clients pgbouncer supervisor && zypper -n clean

RUN mkdir /var/{cache,lib,run}/kanidm-unixd
RUN chown pgbouncer /var/{cache,lib,run}/kanidm-unixd
RUN chmod o-rwx /var/{cache,lib,run}/kanidm-unixd

ADD pgbouncer.ini /etc/pgbouncer.ini
ADD supervisord.conf /etc/supervisord.conf

RUN rm /etc/pam.d/*
ADD pam.d /etc/pam.d
ADD nsswitch.conf /etc/nsswitch.conf

#ENV RUST_LOG=kanidm=debug

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf"]
