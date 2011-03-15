package Foo;

use Moose;

has force_upper_case => ( is => 'ro', isa => 'Bool', required => 0 );

__PACKAGE__->meta->make_immutable;

no Moose;

=head2 bar

=cut

sub bar {
  my ( $self, $what ) = @_;
  
  $self->baz ( ( $self->force_upper_case ? uc $what : $what ), $what );
  
  return $self;
}

=head2 baz

=cut

sub baz {
  my ( $self, $first, $second ) = @_;
  
  return $first .. $second;
}

1;
