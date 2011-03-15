BEGIN {
  unshift @INC, 't/01-scalar';
}

use File::Slurp qw( slurp );
use Foo;
use MooseX::StoolPigeon;
use Test::More tests => 3;

my $mxsp = MooseX::StoolPigeon->new ({ mxsp_class => 'Foo', mxsp_sub => 'baz' });

$mxsp->bar ( $_ ) for 'a' .. 'f';

my $expected = slurp ( 't/01-scalar/expected.t' );

is ( $mxsp->mxsp_as_test_string, $expected, 'as string' );

{
  $mxsp->mxsp_to_test_file ({ file => '/tmp/01-scalar.t' });

  my $got = slurp ( '/tmp/01-scalar.t' );

  is ( $got, $expected, 'to named file' );
}

{
  unlink 't/baz.t';

  $mxsp->mxsp_to_test_file;

  my $got = slurp ( 't/baz.t' );

  is ( $got, $expected, 'to file' );
  
  unlink 't/baz.t';
}
