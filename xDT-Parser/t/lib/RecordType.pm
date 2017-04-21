package TestsFor::xDT::RecordType;
use Test::Class::Moose;
use xDT::RecordType;

sub test_constructor_hash_params {
	my $test = shift;

	can_ok 'xDT::RecordType', 'new';
	isa_ok my $recordType = xDT::RecordType->new(id => 8000), 'xDT::RecordType';
	is $recordType->getId(), 8000, '... and the id should be correct';
}

sub test_constructor_array_params {
	my $test = shift;

	isa_ok my $recordType = xDT::RecordType->new(8000), 'xDT::RecordType';
	is $recordType->getId(), 8000, '... and the id should be correct';
}

sub test_should_set_instance_attributes {
	my $test = shift;

	isa_ok my $recordType = xDT::RecordType->new(8000), 'xDT::RecordType';
	is $recordType->getId(), 8000, '... the id should be correct';
	ok $recordType->getLabels(), '... the labels should be an hash';
	is $recordType->getAccessor(), 'identification', '... the accessor should be "identification"';
	is $recordType->getType(), 'alnum', '... the type should be "alnum"';
	is $recordType->getLength(), 4, '... the length should be 4';
}

sub test_should_be_object_end {
	my $test = shift;

	isa_ok my $recordType = xDT::RecordType->new(8201), 'xDT::RecordType';
	is $recordType->isObjectEnd(), 1, '... 8201 should be end of object';
}

sub test_should_not_be_object_end {
	my $test = shift;

	isa_ok my $recordType = xDT::RecordType->new(8000), 'xDT::RecordType';
	ok !$recordType->isObjectEnd(), '... 8000 should not be end of object';
}

sub test_id_should_not_be_too_long {
	my $test = shift;

	my $success = eval { xDT::RecordType->new(99999) };
	ok !$success, '... too long id should result in error';
}

1;