#FROM quay.io/bgruening/galaxy:18.09
FROM quay.io/bgruening/galaxy:19.05 
MAINTAINER Fabiano Menegidio <fabiano.menegidio@biology.bio.br>

ENV GALAXY_CONFIG_BRAND="GalaxyML"
ENV GALAXY_CONFIG_CONDA_AUTO_INSTALL=True
ENV GALAXY_CONFIG_CONDA_AUTO_INIT=True
ENV PYTHONWARNINGS="ignore:Please.upgrade::pip._internal.cli.base_command"
ENV PYTHONWARNINGS="ignore:DEPRECATION"

VOLUME ["/export/", "/var/lib/docker", "/data/"]

# Expose port 80 (webserver), 21 (FTP server), 8800 (Proxy)
EXPOSE :80
EXPOSE :21
EXPOSE :22
EXPOSE :8800

# Autostart script that is invoked during container start
CMD ["/usr/bin/startup"]
