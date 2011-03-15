use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'MooseX::StoolPigeon',
    AUTHOR              => q{Xavier Caron <xav@cpan.org>},
    VERSION_FROM        => 'lib/MooseX/StoolPigeon.pm',
    ABSTRACT_FROM       => 'lib/MooseX/StoolPigeon.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Data::Dumper::Simple' => 0.11,
        'Moose'                => 1.24,
    },
    BUILD_REQUIRES => {
        'File::Slurp'          => 9999.13,
        'Test::Fatal'          => 0.003,
        'Test::More'           => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'MooseX-StoolPigeon-*' },
);
