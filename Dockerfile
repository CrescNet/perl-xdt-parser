FROM perl
LABEL MAINTAINER Christoph Beger <christoph.beger@medizin.uni-leipzig.de>

RUN cpanm Carton

WORKDIR /xdt-parser

COPY cpanfile* ./
RUN carton install

COPY config ./config
COPY lib ./lib
COPY t/ ./t
