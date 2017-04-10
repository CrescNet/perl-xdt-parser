package xDT::Record;

use Moose;
use namespace::autoclean;

use xDT::RecordType;

has 'length' => (
	is       => 'ro',
	isa      => 'Str',
	required => 1,
	reader   => 'getLength',
);

has 'recordType' => (
	is       => 'ro',
	isa      => 'xDT::RecordType',
	required => 1,
	reader   => 'getRecordType',
);

has 'value' => (
	is     => 'ro',
	isa    => 'Str',
	reader => 'getValue',
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