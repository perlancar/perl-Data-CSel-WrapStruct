#!perl

use 5.010;
use strict;
use warnings;
use Test::More 0.98;

use Data::CSel qw(csel);
use Data::CSel::WrapStruct qw(wrap_struct unwrap_tree);

my $data = [
    0,
    1,
    [2, ["two","dua"], {url=>"http://example.com/two.jpg"}, ["even","prime"]],
    3,
    [4, ["four","empat"], {}, ["even"]],
];
my $tree = wrap_struct($data);

test_csel(
    expr   => "Hash",
    opts   => {class_prefixes=>['Data::CSel::WrapStruct']},
    tree   => $tree,

    result_unwrapped_nodes => [{url=>"http://example.com/two.jpg"}, {}],
);

test_csel(
    expr   => "Hash[length=0]",
    opts   => {class_prefixes=>['Data::CSel::WrapStruct']},
    tree   => $tree,

    result_unwrapped_nodes => [{}],
);

test_csel(
    expr   => "Hash[length>0]",
    opts   => {class_prefixes=>['Data::CSel::WrapStruct']},
    tree   => $tree,

    result_unwrapped_nodes => [{url=>"http://example.com/two.jpg"}],
);

test_csel(
    name   => "modify value of scalar",
    expr   => 'Scalar[value="even"]',
    opts   => {class_prefixes=>['Data::CSel::WrapStruct']},
    tree   => $tree,
    after_csel => sub {
        my ($res_nodes) = @_;
        for (@{$res_nodes}) {
            $_->value("GENAP");
        }
    },

    result_unwrapped_nodes => ["GENAP", "GENAP"],
    result_struct => [
        0,
        1,
        [2, ["two","dua"], {url=>"http://example.com/two.jpg"}, ["GENAP","prime"]],
        3,
        [4, ["four","empat"], {}, ["GENAP"]],
    ],
);

DONE_TESTING:
done_testing;

sub test_csel {
    my %args = @_;

    my $opts = $args{opts} // {};
    my @res_nodes = csel($opts, $args{expr}, $args{tree});
    if ($args{after_csel}) { $args{after_csel}->(\@res_nodes) }

    subtest +($args{name} // $args{expr}) => sub {
        if (exists $args{result_unwrapped_nodes}) {
            my $result_unwrapped_nodes = unwrap_tree(\@res_nodes);
            is_deeply($result_unwrapped_nodes, $args{result_unwrapped_nodes}, "result_unwrapped_nodes")
                or diag explain $result_unwrapped_nodes;
        }

        if (exists $args{result_struct}) {
            my $result_struct = unwrap_tree($args{tree});
            is_deeply($result_struct, $args{result_struct}, "result_struct")
                or diag explain $result_struct;
        }
    };
}
