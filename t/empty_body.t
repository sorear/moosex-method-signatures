use strict;
use warnings;
use Test::More;

{
    package Foo;

    use Moose;
    use MooseX::Method::Signatures;

    method empty() { }
    method empty_with_arg($foo) { }
}

my $o = Foo->new;

sub retvals {
    return scalar(@_);
}

is(retvals($o->empty), 0, "Empty method returns no values in list context");
ok(!defined($o->empty), "Empty method returns undef in scalar context");

is(retvals($o->empty_with_arg(42)), 0,
    "Argument processing does not leak into list returns");
ok(!defined($o->empty_with_arg(42)),
    "Argument processing does not leak into scalar returns");

done_testing;
