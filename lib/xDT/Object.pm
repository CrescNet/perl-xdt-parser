package xDT::Object;

use v5.10;
use Moose;

use xDT::Record;

=head1 NAME

xDT::Object - Instances of this module are collections of xDT records.

=head1 VERSION

Version 1.00

=cut

our $VERSION = '1.00';


=head1 SYNOPSIS

Instances should be used to aggregate records for a single patient.
Each object should starts and ends with respective record types of the used xDT version.

    use xDT::Object;

    my @records = (); # should be an array of xDT::Record instances
    my $object  = xDT::Object->new();
    $object->add_record(@records);

    say 'Patient number: '. $object->get_value('patient_number');
    say 'Birthdate: '. $object->get_value('birthdate');

=head1 ATTRIBUTES

=head2 records

An ArrayRef to xDT::Record instances.

=cut

has 'records' => (
    is      => 'rw',
    isa     => 'ArrayRef[xDT::Record]',
    traits  => ['Array'],
    default => sub { [ ] },
    handles => {
        get_records    => 'elements',
        add_record     => 'push',
        map_records    => 'map',
        record_count   => 'count',
        sorted_records => 'sort',
        next_record    => 'shift',
    },
    documentation => q{A collection of logical associated records.},
);

=head1 SUBROUTINES/METHODS

=head2 is_empty

Checks if this object has any records.

=cut

sub is_empty {
    my $self = shift;

    return $self->record_count == 0;
}

=head2 get($accessor)

This function returns all records of the object with have the given accessor.

=cut

sub get {
    my $self     = shift;
    my $accessor = shift // die 'Error: parameter $accessor missing.';
    my ($record) = grep { $_->get_accessor() eq $accessor } $self->get_records();

    return $record;
}

=head2 get_value($accessor)

In contrast to xDT::Object->get(), this function returns the values of records, returned by xDT::Object->get().

=cut

sub get_value {
    my $self     = shift;
    my $accessor = shift // die 'Error: parameter $accessor missing.';
    my $record   = $self->get($accessor);
    
    return undef unless $record;
    return $record->get_value;
}

=head2 get_records

Corresponse to the elements function.

=cut

=head2 add_record

Corresponse to the push function.

=cut

=head2 map_records

Corresponse to the map function.

=cut

=head2 record_count

Correpsonse to the count function.

=cut

=head2 sorted_records

Corresponse to the sort function.

=cut

=head2 next_record

Corresponse to the shift function.

=cut

=head1 AUTHOR

Christoph Beger, C<< <christoph.beger at imise.uni-leipzig.de> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-xdt-parser at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=xDT-Parser>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc xDT::Object


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=xDT-Parser>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/xDT-Parser>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/xDT-Parser>

=item * Search CPAN

L<http://search.cpan.org/dist/xDT-Parser/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2017 Christoph Beger.

This program is released under the following license: MIT


=cut

__PACKAGE__->meta->make_immutable;

1; # End of xDT::Object
