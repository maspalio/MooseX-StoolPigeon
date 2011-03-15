#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'MooseX::StoolPigeon' ) || print "Bail out!
";
}

diag( "Testing MooseX::StoolPigeon $MooseX::StoolPigeon::VERSION, Perl $], $^X" );
