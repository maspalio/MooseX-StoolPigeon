package MooseX::StoolPigeon;

use warnings;
use strict;

use Data::Dumper::Simple; $Data::Dumper::Indent = $Data::Dumper::Sortkeys = $Data::Dumper::Purity = $Data::Dumper::Deepcopy = 1;
use Moose;

has mxsp_class   => ( is => 'ro', isa => 'Str',      required => 1 );
has mxsp_sub     => ( is => 'ro', isa => 'Str',      required => 1 );
has mxsp_options => ( is => 'ro', isa => 'HashRef',  required => 1 );
has mxsp_cases   => ( is => 'rw', isa => 'ArrayRef', required => 0 );

=head1 NAME

MooseX::StoolPigeon - Create a test file from a Moose class sub

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

Create a test file from -- most likely -- another one at higher level.

This module is meant to be used during refactoring sessions.

For example, let there be a Foo L<Moose> class with 'bar' sub. This sub is covered with a test like:

    use Test::More;
    
    my @cases = (
        { stimulus => $whatever, expected => $whatever },
        ...
    );
    
    plan tests => scalar @cases;
    
    use Foo;
    
    my $foo = Foo->new;
    
    for my $case ( @cases ) {
        is_deeply ( $foo->bar ( $case->{stimulus}, $case->{expected} );
    }

If for example 'bar' sub calls 'baz' sub (or if a set of 'bar' lines of code can be refactored into 'baz' sub)
then one way to generate a test file at 'baz' boundary using 'bar' stimulus is:

    ...
    
    plan tests => scalar @cases;
    
    use MooseX::StoolPigeon;

    my $foo = MooseX::StoolPigeon->new ({ mxsp_class => 'Foo', mxsp_sub => 'baz' });
    
    for my $case ( @cases ) {
        is_deeply ( $foo->bar ( $case->{stimulus}, $case->{expected} );
    }
    
    $foo->mxsp_to_test_file;

Which creates by default t/baz.t test file.

=head1 SUBROUTINES/METHODS

=cut

=head2 BUILDARGS

Moose stuff. Please ignore.

=cut

sub BUILDARGS {
  my ( $self, $option ) = @_;
  
  extends $option->{mxsp_class};

  around $option->{mxsp_sub} => sub {
    my ( $sub, $self, @options ) = @_;

    my @returned = $self->$sub ( @options );

    push @{$self->{mxsp_cases}}, { stimulus => \@options, expected => \@returned };

    return @returned;
  };

  $option->{mxsp_options} = $option;
  
  return $option;
}

no Moose;

=head2 mxsp_to_test_file

  $self->mxsp_to_test_file ({ file => $file })

Creates a test file from recorded stimulus/expected pairs.
File name is t/watched_sub.t unless overridden with file option.
Returns self.

=cut

sub mxsp_to_test_file {
  my ( $self, $option ) = @_;
  
  my $file = $option->{file} ? $option->{file} : 't/' . $self->mxsp_sub . '.t';
  
  if ( open my $fh, '>', $file ) {
    print $fh $self->mxsp_as_test_string;
  }
  else {
    die $!;
  }
  
  return $self;
}

=head2 mxsp_as_test_string

  $string = $self->mxsp_as_test_string ()

Creates a test from recorded stimulus/expected pairs.

=cut

sub mxsp_as_test_string {
  my ( $self ) = @_;
  
  my $class = $self->mxsp_class;
  my $sub   = $self->mxsp_sub;
  
  return "# no use cases!\n" unless $self->mxsp_cases;
  
  my @cases = @{$self->mxsp_cases};

  return
    "use Test::More;\n" .
    "\n" .
    "use $class;\n" .
    "\n" .
    "my " . Dumper ( \@cases ) .
    "\n" .
    "plan ( tests => scalar \@\$cases );\n" .
    "\n" .
    "my \$id = $class->new ({ " . join ( ", ", map { "$_ => " . $self->mxsp_options->{$_} } sort grep { ! m/^mxsp_/ } keys %{$self->mxsp_options} ) . " });\n" .
    "\n" .
    "for my \$case ( \@\$cases ) {\n" .
    "  my \@got      = \$id->$sub ( \@{\$case->{stimulus}} );\n" .
    "  my \$expected = \$case->{expected};\n" .
    "  \n" .
    "  is_deeply ( \\\@got, \$expected, \$expected );\n" .
    "}\n"
  ;
}

=head1 AUTHOR

Xavier Caron, C<< <xav at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-moosex-stoolpigeon at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=MooseX-StoolPigeon>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc MooseX::StoolPigeon

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=MooseX-StoolPigeon>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/MooseX-StoolPigeon>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/MooseX-StoolPigeon>

=item * Search CPAN

L<http://search.cpan.org/dist/MooseX-StoolPigeon/>

=back

=head1 ACKNOWLEDGEMENTS

To L<Moose> folks.

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Xavier Caron.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of MooseX::StoolPigeon
