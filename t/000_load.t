#!perl -w
use strict;
use Test::More tests => 1;

BEGIN {
    use_ok 'AnyEvent::Impl::Wx';
}

diag "Testing AnyEvent::Impl::Wx/$AnyEvent::Impl::Wx::VERSION";
