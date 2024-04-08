### pgbouncer & kanidm-unixd combined for PAM auth.

Things you definitely need to provide:
- Volume mount in `/etc/kanidm` to configure kanidm upstream

Things you may want to override:
- Override with a volume `/etc/pgbouncer.ini`, the defaults are tuned for Patroni w/ Consul.
