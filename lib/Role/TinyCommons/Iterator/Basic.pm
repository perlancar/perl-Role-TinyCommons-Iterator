package Role::TinyCommons::Iterator::Basic;

# AUTHORITY
# DATE
# DIST
# VERSION

use Role::Tiny;

### required

requires 'get_next_item';
requires 'has_next_item';
requires 'get_iterator_pos';

### provided

1;
# ABSTRACT: A basic iterator

=head1 SYNOPSIS

In your class:

 package YourClass;
 use Role::Tiny;
 with 'Role::TinyCommons::Iterator::Basic';

 sub new { ... }

 # implement required methods
 sub get_next_item { ... }
 sub try_get_next_item { ... }
 sub has_next_item { ... }

In your class user's code:

 use YourClass;

 my $obj = YourClass->new(...);

 # iterate
 my @items;
 while ($obj->has_next_item) {
     push @items, $obj->get_next_item;
 }


=head1 DESCRIPTION

This role provides a basic iterator that's unidirectional, non-resettable, and
non-circular. For a bidirectional iterator, see
L<Role::TinyCommons::Iterator::Bidirectional>. For a resettable iterator, see
L<Role::TinyCommons::Iterator::Resettable>. For a circular iterator, see
L<Role::TinyCommons::Iterator::Circular>


=head1 REQUIRED METHODS

=head2 get_next_item

Usage:

 while ($obj->has_next_item) {
     push @items, $obj->get_next_item;
 }

Get the next item. Must throw an exception (string based, "StopIteration") if
there is no more item to get. Usually used with L</has_next_item> to check first
if there is stil another item to get.

=head2 has_next_item

Usage:

 while ($obj->has_next_item) {
     push @items, $obj->get_next_item;
 }

Check whether iterator has another item.

=head2 get_iterator_pos

Usage:

 my $pos = $obj->get_iterator_pos;

Return the iterator's current position, which is a non-negative integer. The
first item has the position 0.


=head1 PROVIDED METHODS

None.


=head1 SEE ALSO

This role is loosely based on L<Array::Iterator>, but the method names have been
made with "verb"+"object" naming style to be more verbose and less likely clash
with your other methods. The "StopIteration" name comes from Python.
