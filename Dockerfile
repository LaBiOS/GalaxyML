#FROM quay.io/bgruening/galaxy:18.09
FROM quay.io/bgruening/galaxy:19.05 
MAINTAINER Fabiano Menegidio <fabiano.menegidio@biology.bio.br>

ENV GALAXY_CONFIG_BRAND="GalaxyML"
ENV GALAXY_CONFIG_CONDA_AUTO_INSTALL=True
ENV GALAXY_CONFIG_CONDA_AUTO_INIT=True
ENV PYTHONWARNINGS="ignore:Please.upgrade::pip._internal.cli.base_command"
ENV PYTHONWARNINGS="ignore:DEPRECATION"

### ADD Tools Galaxy
ADD config/tools/tools_ml_1.yaml $GALAXY_ROOT/tools_1.yaml

ADD config/galaxy/tool_conf.xml $GALAXY_ROOT/config/
ADD config/galaxy/dependency_resolvers_conf.xml $GALAXY_ROOT/config/

RUN df -h \
    && install-tools $GALAXY_ROOT/tools_1.yaml \
    #&& /tool_deps/_conda/bin/conda clean --tarballs --yes > /dev/null \
    && /tool_deps/_conda/bin/conda clean -tipsy \
    && rm /export/galaxy-central/ -rf \
    && df -h

VOLUME ["/export/", "/var/lib/docker", "/data/"]

# Expose port 80 (webserver), 21 (FTP server), 8800 (Proxy)
EXPOSE :80
EXPOSE :21
EXPOSE :22
EXPOSE :8800

# Autostart script that is invoked during container start
CMD ["/usr/bin/startup"]
