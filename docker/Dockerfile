FROM lsstsqre/centos:7-stack-lsst_distrib-v15_0
MAINTAINER EiffL <fr.eiffel@gmail.com>

# Activate the stack environment
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib \
    && conda install -y numba \
    && pip install fitsio esutil \
    && pip install git+https://github.com/esheldon/meds \
    && pip install git+https://github.com/EiffL/medsdm.git@cmdline-tool \
    && pip install git+https://github.com/esheldon/ngmix

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["bash", "/entrypoint.sh"]
