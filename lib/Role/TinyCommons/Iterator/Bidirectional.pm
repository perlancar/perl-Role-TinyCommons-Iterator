package Role::TinyCommons::Iterator::Bidirectional;

# AUTHORITY
# DATE
# DIST
# VERSION

use Role::Tiny;
use Role::Tiny::With;

with 'Role::TinyCommons::Iterator::Basic';

### required

requires 'has_prev_item';
requires 'get_prev_item';

### provided

1;
# ABSTRACT: A bidirectional iterator

=head1 DESCRIPTION

A bidirectional iterator is just like a L<basic
iterator|Role::TinyCommons::Iterator::Basic> except that it has
L</get_prev_item> in addition to C<get_next_item> and L</has_prev_item> in
addition to C<get_prev_item>.


=head1 ROLES MIXED IN

L<Role::TinyCommons::Iterator::Basic>


=head1 REQUIRED METHODS

=head2 get_prev_item

=head2 has_prev_item


=head1 PROVIDED METHODS

No additional provided methods.


=head1 SEE ALSO

L<Role::TinyCommons::Iterator::Basic>
