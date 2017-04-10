#!/usr/bin/perl -w

use lib '/home/cbeger/xDT_parser/xDT'; # remove this line when modules are included in a package

use xDT::Parser;

use Data::Dumper;

my $parser = xDT::Parser->new();
$parser->open(shift);

while (my $record = $parser->next()) {
    print join("\t", $record->getRecordType()->getName(), $record->getLength(), $record->getValue()). "\n";
}

$parser->close();