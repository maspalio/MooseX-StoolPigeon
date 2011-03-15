BEGIN {
  unshift @INC, 't/03-options';
}

use File::Slurp qw( slurp );
use Foo;
use MooseX::StoolPigeon;
use Test::More tests => 2;

my $mxsp = MooseX::StoolPigeon->new ({ mxsp_class => 'Foo', mxsp_sub => 'baz', force_upper_case => 1 });

$mxsp->bar ( $_ ) for 'a' .. 'f';

my $expected = slurp ( 't/03-options/expected.t' );

is ( $mxsp->mxsp_as_test_string, $expected );

$mxsp->mxsp_to_test_file ({ file => '/tmp/03-options.t' });

my $got = slurp ( '/tmp/03-options.t' );

is ( $got, $expected );
