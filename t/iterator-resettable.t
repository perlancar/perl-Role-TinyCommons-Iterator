#!perl

use 5.010001;
use strict;
use warnings;
use Test::Exception;
use Test::More 0.98;

use FindBin '$Bin';
use lib "$Bin/lib";

use Local::Array::Iterator::Resettable;

my $iter = Local::Array::Iterator::Resettable->new(1,2,3);

my @items; while ($iter->has_next_item) { push @items, $iter->get_next_item }
is_deeply(\@items, [1,2,3]);
ok(!$iter->has_next_item);
dies_ok { $iter->get_next_item };
$iter->reset_iterator;
@items = (); for (1..2) { push @items, $iter->get_next_item }
is_deeply(\@items, [1,2]);

done_testing;
