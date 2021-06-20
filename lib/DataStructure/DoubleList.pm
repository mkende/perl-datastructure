# A double-linked list data-structure.

package DataStructure::DoubleList;

use strict;
use warnings;
use utf8;
use feature ':5.24';
use feature 'signatures';
no warnings 'experimental::signatures';

use DataStructure::DoubleList::Node;

=pod

=head1 NAME

DataStructure::DoubleList

=head1 SYNOPSIS

A double-linked list data-structure, written in pure Perl.

See also L<DataStructure::LinkedList> for a non double-linked list version.

=head1 DESCRIPTION

=head2 CONSTRUCTOR

C<DataStructure::DoubleList->new()>

Creates an empty list.

=cut

sub new ($class) {
  return bless { size => 0, first => undef, last => undef}, $class;
}

=pod

=head2 METHODS

All the functions below are class methods that should be called on a
B<DataStructure::DoubleList> object.

=head3 I<first()>

Returns the first L<DataStructure::DoubleList::Node> of the list, or B<undef> if
the list is empty.

=cut

sub first ($self) {
  return $self->{first};
}

=pod

=head3 I<last()>

Returns the last L<DataStructure::DoubleList::Node> of the list, or B<undef> if
the list is empty.

=cut

sub last ($self) {
  return $self->{last};
}

=pod

=head3 I<push($value)>

Adds a new node at the end of the list with the given value. Returns the newly
added node.

=cut

sub push ($self, $value) {
  my $new_node = DataStructure::DoubleList::Node->new($self, $self->{last}, undef, $value);
  $self->{last}{next} = $new_node if defined $self->{last};
  $self->{last} = $new_node;
  $self->{first} = $new_node unless defined $self->{first};
  $self->{size}++;
  return $new_node;
}


=pod

=head3 I<unshift($value)>

Adds a new node at the beginning of the list with the given value. Returns the
newly added node.

=cut

sub unshift ($self, $value) {
  my $new_node = DataStructure::DoubleList::Node->new($self, undef, $self->{first}, $value);
  $self->{first}{prev} = $new_node if defined $self->{first};
  $self->{first} = $new_node;
  $self->{last} = $new_node unless defined $self->{last};
  $self->{size}++;
  return $new_node;
}

=pod

=head3 I<pop()>

Removes the last node of the list and returns its value. Returns B<undef> if the
list is empty. Note that the method can also return B<undef> if the last node’s
value is B<undef>

=cut

sub pop ($self) {
  return $self->{last}->delete if defined $self->{last};
  return;
}


=pod

=head3 I<shift()>

Removes the first node of the list and returns its value. Returns B<undef> if
the list is empty. Note that the method can also return B<undef> if the first
node’s value is B<undef>

=cut

sub shift ($self) {
  return $self->{first}->delete if defined $self->{first};
  return;
}


=pod

=head3 I<size()>

Returns the number of nodes in the list.

=cut

sub size ($self) {
  return $self->{size};
}

sub DESTROY ($self) {
  my $next = $self->{first};
  while (defined $next) {
    my $cur = $next;
    $next = $cur->{next};
    undef %{$cur};
  }
  return;
}

1;
