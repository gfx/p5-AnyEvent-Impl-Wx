package AnyEvent::Impl::Wx;
use 5.010_000;
use AnyEvent (); BEGIN { AnyEvent::common_sense() }
use warnings;

our $VERSION = '0.01';

push @AnyEvent::REGISTRY, [ __PACKAGE__, __PACKAGE__ ];

sub io {
    my(undef, %args) = @_;
    AnyEvent::Impl::Wx::IO::register(
        $args{fh}, $args{poll}, $args{cb},
    );
}

sub timer {
    my(undef, %args) = @_;
    AnyEvent::Impl::Wx::Timer::register(
        $args{after}, $args{interval}, $args{cb},
    );
}

package AnyEvent::Impl::Wx::IO;
use Wx qw(:socket);
use Wx::Event qw(EVT_SOCKET_INPUT EVT_SOCKET_OUTPUT);

sub register {
    my($fh, $poll, $cb) = @_;
    ...;
    bless { }, __PACKAGE__;
}

package AnyEvent::Impl::Wx::Timer;
use Wx::Timer;
use Wx::Event qw(EVT_TIMER);

sub register {
    my($after, $interval, $cb) = @_;
    state $id = 0;
    ++$id;

    my $timer = Wx::Timer->new(Wx::wxTheApp(), $id);
    $timer->Start( ($after * 1000) // 1, 1 );

    EVT_TIMER(Wx::wxTheApp(), $id, sub {
        state $first = 1;
        if($first and defined $interval) {
            $timer->Start( ($interval * 1000) // 1, 0 );
            $first = 0;
        }
        else {
            $cb->();
        }
    });

    bless { timer => $timer }, __PACKAGE__;
}

sub DESTROY {
    my($self) = @_;
    $self->{timer}->Stop();
}

1;
__END__

=head1 NAME

AnyEvent::Impl::Wx - Perl extention to do something

=head1 VERSION

This document describes AnyEvent::Impl::Wx version 0.01.

=head1 SYNOPSIS

    use AnyEvent::Impl::Wx;

=head1 DESCRIPTION

# TODO

=head1 INTERFACE

=head2 Functions

=head3 C<< hello() >>

# TODO

=head1 DEPENDENCIES

Perl 5.8.1 or later.

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 SEE ALSO

L<perl>

=head1 AUTHOR

<<YOUR NAME HERE>> E<lt><<YOUR EMAIL ADDRESS HERE>>E<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2011, <<YOUR NAME HERE>>. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
