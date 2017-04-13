#!/usr/bin/perl -w

use Moose;
use Data::Dumper;

use xDT::Parser;


my $parser = xDT::Parser->new();
$parser->open(shift);

while (my $object = $parser->nextObject()) {
    last if ($object->isEmpty());
    
    print _extractData($object). "\n";
}

$parser->close();


sub _extractData {
    my $object = shift // croak('Error: parameter $object missing.');
    
    return sprintf(
        '%s: %s %s (%s, %s) - %s',
        $object->getValue('patientNumber'), $object->getValue('firstname'), $object->getValue('surname'),
        $object->getValue('birthdate'), $object->getValue('gender'), $object->getValue('specificMap')
    );
}