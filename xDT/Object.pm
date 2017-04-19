package xDT::Object;

use Moose;
use v5.10;
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
        nextRecord    => 'shift',
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

    return grep { $_->getAccessor() eq $accessor } $self->getRecords();
}

sub getValue {
    my $self     = shift;
    my $accessor = shift // croak('Error: parameter $accessor missing.');
    my @records  = $self->get($accessor);
    
    return undef unless @records;
    return map { $_->getValue() } @records;
}


__PACKAGE__->meta->make_immutable;

1;