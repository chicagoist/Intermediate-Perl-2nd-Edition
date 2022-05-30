package Animal {
    use v5.10;
    use FindBin qw($Bin);
    use lib "$Bin";# в подкаталоге
    our $VERSION = '0.01';
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

    #use Moose;
    use Moose::Role;
    use Moose::Util::TypeConstraints;
    use namespace::autoclean;

    requires qw(sound default_color);

    enum 'ColorStr' => [qw( white brown black grey spotted)];

    has 'name' => (is => 'rw');
    has 'color' => (
        is => 'ro',
        isa => 'ColorStr',
        writer => '_private_set_color',
        default => sub { shift->default_color }
    );



    sub speak {
        my $self = shift;
        print $self->name, " goes ", $self->sound, "\n";
    }

    }
1;