package TestsFor::xDT::RecordType;
use Test::Class::Moose;
use xDT::RecordType;

sub test_constructor_hash_params {
	my $test = shift;

	can_ok 'xDT::RecordType', 'new';
	isa_ok my $record_type = xDT::RecordType->new(id => 8000), 'xDT::RecordType';
	is $record_type->get_id(), 8000, '... and the id should be correct';
}

sub test_constructor_array_params {
	my $test = shift;

	isa_ok my $record_type = xDT::RecordType->new(8000), 'xDT::RecordType';
	is $record_type->get_id(), 8000, '... and the id should be correct';
}

sub test_should_set_instance_attributes {
	my $test = shift;

	isa_ok my $record_type = xDT::RecordType->new(8000), 'xDT::RecordType';
	is $record_type->get_id(), 8000, '... the id should be correct';
	is $record_type->get_accessor(), '8000', '... the accessor should be "8000"';
}

sub test_should_be_object_end {
	my $test = shift;

	isa_ok my $record_type = xDT::RecordType->new(8201), 'xDT::RecordType';
	is $record_type->is_object_end(), 1, '... 8201 should be end of object';
}

sub test_should_not_be_object_end {
	my $test = shift;

	isa_ok my $record_type = xDT::RecordType->new(8000), 'xDT::RecordType';
	ok !$record_type->is_object_end(), '... 8000 should not be end of object';
}

sub test_id_should_not_be_too_long {
	my $test = shift;

	my $success = eval { xDT::RecordType->new(99999) };
	ok !$success, '... too long id should result in error';
}

1;