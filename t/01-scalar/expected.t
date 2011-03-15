use Test::More;

use Foo;

my $cases = [
  {
    'expected' => [
      'a-A'
    ],
    'stimulus' => [
      'a',
      'A'
    ]
  },
  {
    'expected' => [
      'b-B'
    ],
    'stimulus' => [
      'b',
      'B'
    ]
  },
  {
    'expected' => [
      'c-C'
    ],
    'stimulus' => [
      'c',
      'C'
    ]
  },
  {
    'expected' => [
      'd-D'
    ],
    'stimulus' => [
      'd',
      'D'
    ]
  },
  {
    'expected' => [
      'e-E'
    ],
    'stimulus' => [
      'e',
      'E'
    ]
  },
  {
    'expected' => [
      'f-F'
    ],
    'stimulus' => [
      'f',
      'F'
    ]
  }
];

plan ( tests => scalar @$cases );

my $id = Foo->new ({  });

for my $case ( @$cases ) {
  my @got      = $id->baz ( @{$case->{stimulus}} );
  my $expected = $case->{expected};
  
  is_deeply ( \@got, $expected, $expected );
}
