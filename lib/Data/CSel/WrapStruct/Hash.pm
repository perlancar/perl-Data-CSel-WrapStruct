package Data::CSel::WrapStruct::Hash;

# DATE
# VERSION

sub new {
    my ($class, $data, $parent) = @_;
    bless [$data, $parent]; # $keys, $children
}

sub value {
    $_[0][0];
}

sub parent {
    $_[0][1];
}

sub _keys {
    if (@_ > 1) {
        $_[0][2] = $_[1];
    }
    $_[0][2];
}

sub children {
    if (@_ > 1) {
        $_[0][3] = $_[1];
    }
    $_[0][3];
}

sub length {
    scalar @{ $_[0][2] };
}

1;
# ABSTRACT: Wrap a hashref

=head1 DESCRIPTION

Some notes:

=over

=item * The children are hash values, ordered by keys

=back
