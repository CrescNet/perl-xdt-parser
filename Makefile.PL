use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'xDT::Parser',
    AUTHOR           => q{Christoph Beger <christoph.beger@imise.uni-leipzig.de>},
    VERSION_FROM     => 'lib/xDT/Parser.pm',
    ABSTRACT_FROM    => 'lib/xDT/Parser.pm',
    LICENSE          => 'MIT',
    PL_FILES         => {},
    MIN_PERL_VERSION => '5.006',
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '0',
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        'Moose' => 0,
        'XML::Simple' => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'xDT-Parser-*' },
);
