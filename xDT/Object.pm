package xDT::Object;

use Moose;
use namespace::autoclean;
use Carp;

use xDT::Record;


has 'records' => (
    is      => 'rw',
    isa     => 'ArrayRef[xDT::Record]',
    traits  => ['Array'],
    default => sub { [ ] },
    handles => {
        getRecords    => 'elements',
        addRecord     => 'push',
        mapRecords    => 'map',
        recordCount   => 'count',
        sortedRecords => 'sort',
    },
    documentation => 'A collection of logical associated records.',
);


sub isEmpty {
    my $self = shift;

    return $self->recordCount == 0;
}

sub get {
    my $self     = shift;
    my $accessor = shift // croak('Error: parameter $accessor missing.');

    foreach my $record ($self->getRecords()) {
        return $record if ($record->getAccessor() eq $accessor);
    }
}


__PACKAGE__->meta->make_immutable;

1;