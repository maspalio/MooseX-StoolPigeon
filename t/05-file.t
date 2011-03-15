BEGIN {
  unshift @INC, 't/01-scalar';
}

use Foo;
use MooseX::StoolPigeon;
use Test::Fatal;
use Test::More tests => 2;

my $mxsp = MooseX::StoolPigeon->new ({ mxsp_class => 'Foo', mxsp_sub => 'baz' });

$mxsp->bar ( $_ ) for 'a' .. 'f';

like ( exception { $mxsp->mxsp_to_test_file ({ file => '/bwaah/daah.t'  }) }, qr/^No such file or directory at/, 'to unwriteable file' );
is   ( exception { $mxsp->mxsp_to_test_file ({ file => '/tmp/05-file.t' }) }, undef,                             'to writeable file'   );
