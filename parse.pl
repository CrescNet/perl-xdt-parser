#!/usr/bin/perl -w

use lib '/home/cbeger/xDT_parser/xDT'; # remove this line when modules are included in a package

use xDT::Parser;

use Data::Dumper;

my $parser = xDT::Parser->new();
$parser->open(shift);

while (my $recordSet = $parser->nextRecordSet()) {
    last if ($recordSet->isEmpty());
    print Dumper($recordSet);
}

$parser->close();