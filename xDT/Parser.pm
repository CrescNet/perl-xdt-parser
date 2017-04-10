package xDT::Parser;

use Moose;
use namespace::autoclean;
use FileHandle;
use Carp;

use xDT::Record;


has 'fh' => (
    is            => 'rw',
    isa           => 'FileHandle',
    documentation => q{The filehandle the parser will use to read xDT data.},
);


sub open {
    my ($self, $file) = @_;

    croak("Error: provided file '$file' does not exist or is not readable.")
        unless (-f $file);

    my $fh = FileHandle->new($file, 'r')
        or croak("Error: could not open filehandle $file.");
    
    $self->fh($fh);
}

sub close {
    my $self = shift;

    close $self->fh;
}

sub next {
    my $self = shift;

    my $line = $self->fh->getline() or return undef;

    return xDT::Record->new($line);
}


__PACKAGE__->meta->make_immutable;

1;