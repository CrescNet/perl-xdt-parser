#!/usr/bin/perl -w

use Moose;
use Time::Piece;
use Data::Dumper;

use xDT::Parser;


my $parser = xDT::Parser->new;
$parser->open(shift);

while (my $object = $parser->nextObject) {
	last if $object->isEmpty;
	
	print _extractCoreData($object). "\n";
	print _extractMeasurements($object). "\n";
}

$parser->close();


sub _extractCoreData {
	my $object = shift // croak('Error: parameter $object missing.');
	
	return sprintf(
		'%s: %s %s (%s, %s)',
		$object->getValue('patientNumber'), $object->getValue('firstname'), $object->getValue('surname'),
		$object->getValue('birthdate'), $object->getValue('gender')
	);
}

sub _extractMeasurements {
	my $object = shift // croak('Error: parameter $object missing.');
	my @measurements = ();
	my $measurement = ();

	while (my $record = $object->nextRecord) {
		last unless defined $record;

		if ($record->getAccessor eq 'testIdentification') {
			push @measurements, $measurement if defined $measurement->{testIdentification};
			$measurement = ();
			$measurement->{testIdentification} = $record->getValue;
		} else {
			foreach my $accessor ('collectionDate', 'collectionTime', 'result', 'unit') {
				next unless $record->getAccessor eq $accessor;
				$measurement->{$accessor} = $record->getValue;
			}	
		}
	}
	push @measurements, $measurement;

	return join "\n", map {
		my $date = Time::Piece->strptime($_->{collectionDate}, '%d%m%Y')->ymd;
		$date. " - $_->{testIdentification}: $_->{result} $_->{unit}"
	} @measurements;
}