use Test::Class::Moose::Load 't/lib';
use Test::Class::Moose::Runner;
use Test::More;

unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => "Author tests not required for installation" );
}

Test::Class::Moose::Runner->new->runtests;