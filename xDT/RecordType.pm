package xDT::RecordType;

use Moose;
use namespace::autoclean;
use Carp;

use constant {
	TYPES => {
		'8000' => 'Record type',
		'8100' => 'Record length',
		'9206' => 'Used character set',
		'9218' => 'Version GDT',
		'3000' => 'Patient number',
		'3101' => 'Surname',
		'3102' => 'Firstname',
		'3103' => 'Date of birth',
		'3110' => 'Gender (1=male)',
		'8405' => 'Information about patient',
		'6200' => 'Examination date',
		'8402' => 'Device and process specific characteristic map',
		'8432' => 'Date of collection',
		'8439' => 'Time of collection',
	},
	LENGTH => 4,
};

has nr => (
	is            => 'ro',
	isa           => 'Str',
	required      => 1,
	reader        => 'getNr',
	trigger       => \&_checkNr,
	documentation => 'Unique identifier of this record type.',
);


around BUILDARGS => sub {
	my $orig  = shift;
	my $class = shift;

	if (@_ == 1 && !ref $_[0]) {
		return $class->$orig(nr => $_[0]);
	} else {
	   return $class->$orig(@_);
	}
};


sub getName {
	my $self = shift;

	return TYPES->{$self->getNr()} // $self->getNr();
}


sub _checkNr {
	my ($self, $nr) = @_;

	croak(sprintf("Error: attribute 'nr' has length %d (should be %d).", length $nr, LENGTH))
		unless (length $nr == LENGTH);
}


__PACKAGE__->meta->make_immutable;

1;