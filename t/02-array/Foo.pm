package Foo;

use Moose;

__PACKAGE__->meta->make_immutable;

no Moose;

=head2 bar

=cut

sub bar {
  my ( $self, $what ) = @_;
  
  $self->baz ( $what, uc $what );
  
  return $self;
}

=head2 baz

=cut

sub baz {
  my ( $self, $first, $second ) = @_;
  
  return $first .. $second;
}

1;
