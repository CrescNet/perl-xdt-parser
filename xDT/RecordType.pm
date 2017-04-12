package xDT::RecordType;

use Moose;
use namespace::autoclean;
use Carp;
use XML::Simple;
use File::Basename;

use constant {
	LENGTH => 4,
};

has id => (
	is            => 'ro',
	isa           => 'Str',
	required      => 1,
	reader        => 'getId',
	trigger       => \&_checkId,
	documentation => 'Unique identifier of this record type.',
);

has labels => (
	is            => 'ro',
	isa           => 'Maybe[HashRef[Str]]',
	reader        => 'getLabels',
	documentation => 'The human readable labels of this record type. Language is used as key value.',
);

has accessor => (
	is            => 'ro',
	isa           => 'Str',
	required      => 1,
	reader        => 'getAccessor',
	documentation => 'Short string for easy access to this record via xDT::Object.',
);

has length => (
	is            => 'ro',
	isa           => 'Maybe[Str]',
	reader        => 'getLength',
	documentation => 'Get max length of this record type.',
);

has type => (
	is            => 'ro',
	isa           => 'Maybe[Str]',
	reader        => 'getType',
	documentation => 'Corresponds to xDT record type string.'
);

around BUILDARGS => sub {
	my $orig  = shift;
	my $class = shift;

	if (@_ == 1 && !ref $_[0]) {
		return $class->$orig(_extractParametersFromConfigFile($_[0]));
	} else {
		my %params = @_;
		return $class->$orig(_extractParametersFromConfigFile($params{'id'}));
	}
};


sub isObjectEnd {
	my $self = shift;

	return $self->getId == 8201;
}

sub _extractParametersFromConfigFile {
	my $id = shift // croak('Error: parameter $id missing.');

	my $xml = new XML::Simple(
		KeyAttr    => { RecordType => 'id', label => 'lang' },
		ForceArray => 1,
		ContentKey => '-content',
	);
	my $config = $xml->XMLin(File::Basename::dirname(__FILE__). '/Configuration/RecordTypes.xml')
		->{RecordType}->{$id};
	
	return (
		id       => $id,
		labels   => $config->{label},
		type     => $config->{type},
		accessor => $config->{accessor} // $id,
		length   => $config->{length},
	);
}


sub _checkId {
	my ($self, $id) = @_;

	croak(sprintf("Error: attribute 'id' has length %d (should be %d).", length $id, LENGTH))
		unless (length $id == LENGTH);
}


__PACKAGE__->meta->make_immutable;

1;