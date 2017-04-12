package xDT::Record;

use Moose;
use namespace::autoclean;

use xDT::RecordType;

has 'length' => (
	is            => 'ro',
	isa           => 'Str',
	required      => 1,
	reader        => 'getLength',
	documentation => 'The length of this records value (there are 2 extra symbols at the end of the string).'
);

has 'recordType' => (
	is            => 'ro',
	isa           => 'xDT::RecordType',
	required      => 1,
	reader        => 'getRecordType',
	handles       => {
		getAccessor  => 'getAccessor',
		getLabels    => 'getLabels',
		getId        => 'getId',
		getType      => 'getType',
		getMaxLength => 'getLength',
		isObjectEnd  => 'isObjectEnd',
	},
	documentation => 'The record type of this record.'
);

has 'value' => (
	is            => 'ro',
	isa           => 'Maybe[Str]',
	reader        => 'getValue',
	documentation => 'The value of this record as string.'
);


around BUILDARGS => sub {
	my ($orig, $class, $line) = @_;

	return $class->$orig(
		length     => substr($line, 0, 3),
		recordType => xDT::RecordType->new(substr($line, 3, 4)),
		value      => substr($line, 7),
	);
};


__PACKAGE__->meta->make_immutable;

1;