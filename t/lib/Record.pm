package TestsFor::xDT::Record;
use Test::Class::Moose;
use xDT::Record;
use xDT::RecordType;

sub test_constructor {
    my $test = shift;

    isa_ok my $record = xDT::Record->new("01380006311\r\n"), 'xDT::Record';
    $record->setRecordType(xDT::RecordType->new(8000));
    is $record->getId, 8000, '... id should be 8000';
    is $record->getLength, '013', '... length should be 013';
    is $record->getValue, '6311', '... value should be "6311"';
}

1;