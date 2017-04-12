#!/usr/bin/perl -w

use lib '/home/cbeger/xDT_parser/xDT'; # remove this line when modules are included in a package

use xDT::Parser;

use Data::Dumper;

my $parser = xDT::Parser->new();
$parser->open(shift);

while (my $object = $parser->nextObject()) {
    last if ($object->isEmpty());
    
    $Data::Dumper::Sortkeys = 1;
    print Dumper($object);
    print Dumper($object->get('collectionDate'));
}

$parser->close();