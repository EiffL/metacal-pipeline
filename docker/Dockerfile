FROM lsstsqre/centos:7-stack-lsst_distrib-v15_0
MAINTAINER EiffL <francois.lanusse@gmail.com>

# Activate the stack environment
RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib \
    && conda install -y numba \
    && pip install fitsio esutil \
    && pip install git+https://github.com/esheldon/meds \
    && pip install git+https://github.com/EiffL/medsdm.git@cmdline-tool \
    && pip install git+https://github.com/esheldon/ngmix

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib \
    && conda install -y -c conda-forge pybind11 \
    && pip install galsim

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib \
    && pip install git+https://github.com/esheldon/covmatrix@v0.9.0

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib \
    && pip install git+https://github.com/esheldon/coaddsim@5881c1bc471222b3eda45bf5961d28c45c1da591

RUN source /opt/lsst/software/stack/loadLSST.bash && setup lsst_distrib \
    && pip install git+https://github.com/EiffL/ngmixer

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["bash", "/entrypoint.sh"]
