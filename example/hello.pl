#!perl -w
use 5.14.0;
use AnyEvent::Impl::Wx;
use AnyEvent;

package HelloWorld {
    use parent qw(Wx::App);
    use Hash::FieldHash;

    my %frame;

    sub OnInit {
        my($self) = @_;

        my $frame = Wx::Frame->new(
            undef, # no parent window
            -1,    # no window id
            'Hello, wxWidgets!',
            [-1, -1], # position
            [400, 200], # size
        );
        my $panel = Wx::Panel->new($frame);
        my $label = Wx::StaticText->new(
            $panel,
            -1,
            'Welcome to the world of WxWidgets!',
            [20, 20],
        );
        $frame->Show();

        $frame{$self} = $frame;
        return 1;
    }
}

my $app = HelloWorld->new();

my $w0 = AnyEvent->timer(
    after    => 5,
    interval => 1,
    cb    => sub {
        say 'Hi!';
    },
);
my $w1 = AE::timer(
    10, 0.5, sub {
        say 'Hello!';
        undef $w;
    });

$app->MainLoop();

