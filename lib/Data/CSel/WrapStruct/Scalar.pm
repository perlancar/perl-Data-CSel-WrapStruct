package Data::CSel::WrapStruct::Scalar;

# DATE
# VERSION

sub new {
    my ($class, $data_ref, $parent) = @_;
    bless [$data_ref, $parent];
}

sub value {
    ${$_[0][0]};
}

sub parent {
    $_[0][1];
}

sub children {
    [];
}

1;
# ABSTRACT: Wrap a scalar

=for Pod::Coverage .*
