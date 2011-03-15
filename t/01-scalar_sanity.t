BEGIN {
  $ENV{PERL5LIB} = 't/01-scalar';
}

use TAP::Harness;
use Test::More tests => 1;

my $harness = TAP::Harness->new ({ verbosity => -3 });
my $tappa   = $harness->runtests ( 't/01-scalar/expected.t' );

is ( $tappa->all_passed, 1, 'expected passes' );
