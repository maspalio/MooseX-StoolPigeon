BEGIN {
  unshift @INC, 't/02-array';
}

use File::Slurp qw( slurp );
use Foo;
use MooseX::StoolPigeon;
use Test::More tests => 2;

my $mxsp = MooseX::StoolPigeon->new ({ mxsp_class => 'Foo', mxsp_sub => 'baz' });

$mxsp->bar ( $_ ) for 'a' .. 'f';

my $expected = slurp ( 't/02-array/expected.t' );

is ( $mxsp->mxsp_as_test_string, $expected );

$mxsp->mxsp_to_test_file ({ file => '/tmp/02-array.t' });

my $got = slurp ( '/tmp/02-array.t' );

is ( $got, $expected );
