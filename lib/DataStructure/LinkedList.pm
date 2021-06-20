# A linked list data-structure.

package DataStructure::LinkedList;

use strict;
use warnings;
use utf8;
use feature ':5.24';
use feature 'signatures';
no warnings 'experimental::signatures';

use DataStructure::LinkedList::Node;

=pod

=head1 NAME

DataStructure::LinkedList

=head1 SYNOPSIS

A linked list data-structure, written in pure Perl.

See also L<DataStructure::DoubleList> for a double-linked list version that
offers a richer interface.

=head1 DESCRIPTION

=head2 CONSTRUCTOR

C<DataStructure::LinkedList->new()>

Creates an empty list.

=cut

sub new ($class) {
  return bless { size => 0, first => undef}, $class;
}

=pod

=head2 METHODS

All the functions below are class methods that should be called on a
B<DataStructure::LinkedList> object.

=head3 I<first()>

Returns the first L<DataStructure::LinkedList::Node> of the list, or B<undef> if
the list is empty.

=cut

sub first ($self) {
  return $self->{first};
}

=pod

=head3 I<unshift($value)>

Adds a new node at the beginning of the list with the given value. Returns the
newly added node.

For conveniance, I<push()> can be used as a synonym of I<unshift()>.

=cut

sub unshift ($self, $value) {
  my $new_node = DataStructure::LinkedList::Node->new($self, $self->{first}, $value);
  $self->{first} = $new_node;
  $self->{size}++;
  return $new_node;
}

sub push ($self, $value) {
  return $self->unshift($value);
}

=pod

=head3 I<shift()>

Removes the first node of the list and returns its value. Returns B<undef> if
the list is empty. Note that the method can also return B<undef> if the first
node’s value is B<undef>

For conveniance, I<pop()> can be used as a synonym of I<shift()>.

=cut

sub shift ($self) {
  return unless defined $self->{first};
  my $old_first = $self->first();
  $self->{first} = $old_first->next();
  return $old_first->_delete_first();
}

sub pop ($self) {
  $self->shift();
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
  while ($next) {
    my $cur = $next;
    $next = $cur->{next};
    undef %{$cur};
  }
  return;
}

1;
