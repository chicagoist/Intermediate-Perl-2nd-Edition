package RaceHorse::Racer {
    use v5.10;
    use FindBin qw($Bin);
    use lib "$Bin"; # в подкаталоге
    our $VERSION = '0.04';
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
    use Bundle::Camelcade; # for Intellij IDEA
    use YAML;
    use DDP;

    use Moose::Role;
    use namespace::autoclean;
    requires qw(name);

    has $_ => (is => 'rw', default => 0)foreach qw(wins places shows losses);

    sub won    { my $self = shift; $self->wins($self->wins + 1) }
    sub placed { my $self = shift; $self->places($self->places + 1) }
    sub showed { my $self = shift; $self->shows($self->shows + 1) }
    sub lost   { my $self = shift; $self->losses($self->losses + 1) }

    sub standings {
        my $self = shift;
        join ", ", map { $self->$_ . " $_" } qw(wins places shows losses);
    }



    sub UNIVERSAL::fandango {
       # warn 'объект ', shift, " может станцевать фанданго!\n";
        goto &standings;
    }
    #__PACKAGE__->meta->make_immutable;
}
1;