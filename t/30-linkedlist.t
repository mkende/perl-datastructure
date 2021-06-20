use strict;
use warnings;
use utf8;

use Scalar::Util qw(weaken);
use Test::More;

BEGIN { use_ok('DataStructure::LinkedList') }

my $l = DataStructure::LinkedList->new();
isa_ok($l, 'DataStructure::LinkedList');

cmp_ok($l->size(), '==', 0, 'empty size');
ok(!defined($l->first()), 'no first on empty list');
ok(!defined($l->shift()), 'cannot shift empty list');

my $f = $l->unshift('abc');
isa_ok($f, 'DataStructure::LinkedList::Node');
cmp_ok($l->size(), '==', 1, 'size 1');

my $g = $l->first();
isa_ok($g, 'DataStructure::LinkedList::Node');
cmp_ok($f, '==', $g, 'node compare');
is($f->value(), 'abc', 'value abc');

$f = $l->unshift('def');
cmp_ok($l->size(), '==', 2, 'size 2');
$g = $l->first();
cmp_ok($f, '==', $g, 'node compare 2');
is($f->value(), 'def', 'value def');
$f = $f->next();
is($f->value(), 'abc', 'value abc again');

is($l->shift(), 'def', 'shift def');
cmp_ok($l->size(), '==', 1, 'size 1 again');
is($f->value(), 'abc', 'node still works');
$g = $l->first();
cmp_ok($f, '==', $g, 'node compare 2');

ok(!defined $f->next(), 'no next after last node');
is($l->pop(), 'abc', 'pop abc (synonym for shift');
cmp_ok($l->size(), '==', 0, 'size 0');
ok(!defined $l->shift(), 'shift after last');
cmp_ok($l->size(), '==', 0, 'size 0 again');

my $weak_ref;
{
  my $l = DataStructure::LinkedList->new();
  $l->unshift('abc');
  $l->unshift('def');
  my $f = $l->first;
  $weak_ref = $l;
  weaken($weak_ref);
}
ok(!defined $weak_ref, 'garbage collection');

done_testing();
