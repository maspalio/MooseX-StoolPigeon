BEGIN {
  $ENV{PERL5LIB} = 't/02-array';
}

use TAP::Harness;
use Test::More tests => 1;

my $harness = TAP::Harness->new ({ verbosity => -3 });
my $tappa   = $harness->runtests ( 't/02-array/expected.t' );

is ( $tappa->all_passed, 1, 'expected passes' );
