BEGIN {
  unshift @INC, 't/04-caseless';
}

use File::Slurp qw( slurp );
use Foo;
use MooseX::StoolPigeon;
use Test::More tests => 1;

my $mxsp = MooseX::StoolPigeon->new ({ mxsp_class => 'Foo', mxsp_sub => 'baz' });

#$mxsp->bar ( $_ ) for 'a' .. 'f';

my $expected = slurp ( 't/04-caseless/expected.t' );

is ( $mxsp->mxsp_as_test_string, $expected, 'as string' );
