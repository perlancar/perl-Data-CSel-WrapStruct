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

sub has_key {
    exists $_[0][0]{$_[1]};
}

sub key {
    $_[0][0]{$_[1]};
}

1;
# ABSTRACT: Wrap a hashref

=for Pod::Coverage ^(parent|children)$

=head1 DESCRIPTION

Some notes:

=over

=item * The children are hash values, ordered by keys

=back


=head1 METHODS

=head2 new($hash, $parent) => obj

=head2 value() => hash

Return the hash.

=head2 length() => int

The number of keys. An empty hash will return 0.

=head2 has_key($key) => bool

Return true if hash has a key with value of C<$key>. Equivalent to:

 exists($hash->{$key})

=head2 key($key) => any

Retrieve the value of a hash key. Equivalent to:

 $hash->{$key}

=head2
