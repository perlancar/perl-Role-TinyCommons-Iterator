package Role::TinyCommons::Iterator::Circular;

# AUTHORITY
# DATE
# DIST
# VERSION

use Role::Tiny;
use Role::Tiny::With;

with 'Role::TinyCommons::Iterator';

### required

### provided

sub get_all_items {
    my $self = shift;

    my $orig_pos = $self->get_iterator_pos;
    my @items;
    while (1) {
        push @items, $self->get_next_item;
        last if $self->get_iterator_pos == $orig_pos;
    }
    @items;
}

sub get_item_count {
    my $self = shift;

    my $orig_pos = $self->get_iterator_pos;
    my $count = 0;
    while (1) {
        $self->get_next_item;
        $count++;
        last if $self->get_iterator_pos == $orig_pos;
    }
    $count;
}

sub each_item {
    my ($self, $coderef) = @_;

    my $orig_pos = $self->get_iterator_pos;
    my $pos = $orig_pos;
    while (1) {
        my $item = $self->get_next_item;
        my $res = $coderef->($item, $self, $pos);
        return 0 unless $res;
        $pos = $self->get_iterator_pos;
        last if $pos == $orig_pos;
    }
    return 1;
}

1;
# ABSTRACT: A cicular iterator

=head1 DESCRIPTION

A circular iterator is just like a L<regular
iterator|Role::TinyCommons::Iterator> except that it will never run out of items
(unless it is empty). When the last item has been retrieved, the index will just
move back to the beginning; C<get_iterator_index> will return 0 again and
C<get_next_item> will retrieve the first item.


=head1 ROLES MIXED IN

L<Role::TinyCommons::Iterator>


=head1 REQUIRED METHODS

No additional required methods.


=head1 PROVIDED METHODS

=head2 get_all_items

=head2 get_item_count

=head2 each_item


=head1 SEE ALSO

L<Role::TinyCommons::Iterator>

L<Role::TinyCommons::Iterator::Resettable>
