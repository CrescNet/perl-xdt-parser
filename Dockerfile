FROM perl
LABEL MAINTAINER Christoph Beger <christoph.beger@imise.uni-leipzig.de>

RUN cpanm Carton

WORKDIR /xdt-parser

COPY config ./
COPY cpanfile* ./
COPY lib ./
COPY t ./

RUN carton install
