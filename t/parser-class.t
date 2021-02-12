#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

use xDT::Parser;

plan tests => 5;

can_ok 'xDT::Parser', 'new';
can_ok 'xDT::Parser', 'open';
can_ok 'xDT::Parser', 'close';
can_ok 'xDT::Parser', 'next_object';

subtest 'should parse string', sub {
	isa_ok my $parser = xDT::Parser->new, 'xDT::Parser';
	$parser->open(string => 
		"01380006311\n014810000176\n01092063\n014921802.10\n01030002\n0173101Testmann\n0173102Thorsten\n"
		. "017310306101970\n017620016052011\n0158402SONO00\n017843216052011\n0158439161859"
	), 'should parse string';

	isa_ok my $object = $parser->next_object, 'xDT::Object';
	is $object->get_value(3101)->[0], 'Testmann', '3101 as expected';

	$parser->close;
};

done_testing;
