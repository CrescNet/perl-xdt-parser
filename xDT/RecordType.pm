package xDT::RecordType;

use Moose;
use namespace::autoclean;
use Carp;

use constant {
	TYPES => {
		'8000' => 'Record Type',
		'8100' => 'Record Length',
		'9206' => 'Used Character Set',
		'9218' => 'Version GDT',
		'3000' => 'Patient Number',
		'3104' => 'Title',
		'3101' => 'Surname',
		'3102' => 'Firstname',
		'3103' => 'Date of Birth',
		'3110' => 'Gender (1=male)',
		'3107' => 'Street',
		'3106' => 'Zip-Code Place',
		'3105' => 'Insurance Number',
		'2002' => 'Health Insurance',
		'5098' => 'BSNR',
		'0201' => 'BSNR',
		'5099' => 'LANR',
		'0212' => 'LANR',
		'8405' => 'Information about Patient',
		'6200' => 'Examination Date',
		'8402' => 'Device and Process Specific Characteristic Map',
		'8432' => 'Date of Collection',
		'8439' => 'Time of Collection',
		'2017' => 'End of Object',
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