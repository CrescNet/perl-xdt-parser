#!/usr/bin/perl -w

use Moose;
use Data::Dumper;

use xDT::Parser;


my $parser = xDT::Parser->new();
$parser->open(shift);

while (my $object = $parser->nextObject()) {
    last if ($object->isEmpty());
    
    $Data::Dumper::Sortkeys = 1;
    print Dumper($object);
    print Dumper($object->get('collectionDate'));
}

$parser->close();