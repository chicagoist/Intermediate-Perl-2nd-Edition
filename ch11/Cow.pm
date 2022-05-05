use v5.10;

package Cow {
    our $VERSION = '0.01';
    #use parent qw(Animal);
    use Moose;
    extends("Animal");

    use utf8::all 'GLOBAL';
    use strict;
    use warnings FATAL => 'all';
    use utf8;
    binmode(STDIN, ':utf8');
    binmode(STDOUT, ':utf8');
    use Bundle::Camelcade;# for Intellij IDEA

    sub sound {
        "му у у у!!";
    }

    override speak => sub {

        super();
    };

    # sub speak {
    #     my $self = shift;
    #     $self->SUPER::speak();
    # }

    1;
}