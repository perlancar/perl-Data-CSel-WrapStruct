package Data::CSel::WrapStruct::Array;

# DATE
# VERSION

sub new {
    my ($class, $data, $parent) = @_;
    bless [$data, $parent], $class;
}

sub value {
    $_[0][0];
}

sub parent {
    $_[0][1];
}

sub children {
    if (@_ > 1) {
        $_[0][2] = $_[1];
    }
    $_[0][2];
}

sub length {
    scalar @{ $_[0][0] };
}

1;
# ABSTRACT: Wrap an array ref

=for Pod::Coverage .*
