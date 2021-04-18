package Role::TinyCommons::Iterator::Resettable;

# AUTHORITY
# DATE
# DIST
# VERSION

use Role::Tiny;
use Role::Tiny::With;

with 'Role::TinyCommons::Iterator';

### required

requires 'reset_iterator';

### provided

sub get_all_items {
    my $self = shift;

    $self->reset_iterator;
    my @items;
    while ($self->has_next_item) {
        push @items, $self->get_next_item;
    }
    @items;
}

sub get_item_count {
    my $self = shift;

    $self->reset_iterator;
    my $count = 0;
    while ($self->has_next_item) {
        $self->get_next_item;
        $count++;
    }
    $count;
}

sub each_item {
    my ($self, $coderef) = @_;

    $self->reset_iterator;
    my $pos = 0;
    while ($self->has_next_item) {
        my $item = $self->get_next_item;
        my $res = $coderef->($item, $self, $pos);
        return 0 unless $res;
        $pos++;
    }
    return 1;
}

1;
# ABSTRACT: A resettable iterator

=head1 DESCRIPTION

A resettable iterator is just like a L<regular
iterator|Role::TinyCommons::Iterator> except that it has L</reset_iterator> to
reset the iterator back to the beginning.


=head1 ROLES MIXED IN

L<Role::TinyCommons::Iterator>


=head1 REQUIRED METHODS

=head2 reset_iterator

Reset the iterator, which means the subsequent C<get_next_item()> should get the
first item again, and the subsequent C<get_iterator_pos()> right before any
getting of more items should return 0.


=head1 PROVIDED METHODS

=head2 get_all_items

Usage:

 my @items = $obj->get_all_items;

Return a list containing all the items. Equivalent to:

 do {
     $obj->reset_iterator;
     my @items;
     while ($obj->has_next_item) {
         push @items, $obj->get_next_item;
     }
     @items;
 }

=head2 get_item_count

Usage:

 my $count = $obj->get_item_count;

Return the number of items. Equivalent to:

 do {
     $obj->reset_iterator;
     my $count = 0;
     while ($obj->has_next_item) {
         $obj->get_next_item;
         $count++;
     }
     $count;
 }

=head2 each_item

Usage:

 $obj->each_item($coderef);

Call C<$coderef> for each item. If C<$coderef> returns false, will immediately
return false and skip the rest of the items. Otherwise, will return true.
Equivalent to:

 $obj->reset_iterator;
 my $pos = 0;
 while ($obj->has_next_item) {
     my $item = $obj->get_next_item;
     my $res = $coderef->($item, $obj, $pos);
     return 0 unless $res;
     $pos++;
 }
 return 1;


=head1 SEE ALSO

L<Role::TinyCommons::Iterator>
