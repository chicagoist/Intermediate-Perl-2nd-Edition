package MyDate {
    use v5.10;
    use FindBin qw($Bin);
    use lib "$Bin"; # в подкаталоге
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
    use Bundle::Camelcade; # for Intellij IDEA
    use YAML;
    use DDP;

    use Carp qw(croak);

    sub new {
        my $self = shift;
        bless [], $self;
    }

    sub AUTOLOAD {
        our $AUTOLOAD;
        my ($sec, $min, $hour, $day, $mon, $yr, $dow) = localtime;

        # say $AUTOLOAD;
        (my $method = $AUTOLOAD) =~ s/.*:://s; # remove package name

        if ($method eq "day") {
            eval q{ sub day { return $day;  } };
            die $@ if $@;
            goto &day;
        }
        elsif ($method eq "month") {
            eval q{ sub month { return $mon + 1; } };
            die $@ if $@;
            goto &month;
        }
        elsif ($method eq "year") {
            eval q{ sub year { return $yr + 1900; } };
            die $@ if $@;
            goto &year;
        }
        else {
            croak ref $_[0]," does not know how to $method\n";
        }
    }

    sub UNIVERSAL::debug {
        my $self = shift;
        my $time = localtime();

        print "[$time] @_ \n";

    }

    sub DESTROY {
        shift;
    }

}
1;