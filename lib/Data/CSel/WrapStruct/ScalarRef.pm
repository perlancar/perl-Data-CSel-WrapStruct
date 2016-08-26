package Data::CSel::WrapStruct::ScalarRef;

# DATE
# VERSION

sub new {
    my ($class, $data, $parent) = @_;
    bless [$data, $parent];
}

sub value {
    $_[0][0];
}

sub parent {
    $_[0][1];
}

sub children {
    [];
}

1;
# ABSTRACT: Wrap a scalar ref
