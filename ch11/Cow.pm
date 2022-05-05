package Cow {
    #use parent qw(Animal);
    use Moose;
    extends("Animal");

    use v5.10;
    # use CGI;
    # use POSIX;
    # use Encode qw(decode_utf8);
    # use Encode qw(decode encode);
    #= BEGIN{@ARGV=map Encode::decode(#\$_,1),@ARGV;}
    # BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
    # use open qw(:std :encoding(UTF-8));
    use utf8::all 'GLOBAL';
    # use Encode::Locale;
    # use Encode;
    # use diagnostics;
    use strict;
    use warnings FATAL => 'all';
    use autodie qw(:all);
    use utf8;
    binmode(STDIN, ':utf8');
    binmode(STDOUT, ':utf8');
    use Data::Dumper;
    use Bundle::Camelcade;# for Intellij IDEA
    use YAML;
    use DDP;

    # use parent qw(Animal);
    # use Animal;
    # our @ISA = qw(Animal);


    sub sound {
        "му у у у!!";
    }

    override speak => sub {
        # my $self = shift;
        # $self->SUPER::speak();
        super();
    };

    # sub speak {
    #     my $class = shift;
    #     Animal::speak($class);
    # }

    1;
}