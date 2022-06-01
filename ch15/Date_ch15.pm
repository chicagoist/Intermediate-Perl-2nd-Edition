package Date_ch15 {
    use v5.10;
    # use FindBin qw($Bin);
    # use lib "$Bin"; # в подкаталоге
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

    # use Moose;
    # use namespace::autoclean;
    #
    # __PACKAGE__->meta->make_immutable;

    #use base qw(Exporter);
    use Exporter qw(import);
    our @EXPORT = qw(today);
    our @EXPORT_OK = qw(
        number_to_day_name
        number_to_mon_name
        date_10
    );

    our %EXPORT_TAGS = (
        all => [ @EXPORT, @EXPORT_OK ],
        today => [ qw( today date_10 ) ],
        days => [ qw(number_to_day_name) ],
        months => [ qw(number_to_mon_name) ],
    );

    sub new { bless [], shift };

    our @day = qw(арк дип уап сен поп сеп кир);
    our @month = qw(диз под бод род сип уакс лин сен кун физ нап деп);

    sub number_to_day_name {
        #my $self = shift;
        my $num = shift;
        $num -= 1;
        if ($num >= 0 && $num <= 6) {
            return $day[$num];
        }
        else {
            print "Invalid number";
            exit;
        }

    }

    sub number_to_mon_name {
        #my $self = shift;
        my $num_month = shift;
        my $num = $num_month - 1;
        die $num_month , " is not a valid month number" unless $num >= 0 and $num <= 11;
        return $month[$num];
    }

    sub today {
        my $self = shift;
        my($sec, $min, $hour, $mday, $mon, $year, $wday) = localtime;
        my $today = sprintf("Сегодня %s, %s %d, %d", number_to_day_name($wday), number_to_mon_name($mon), $mday, 1900+$year);
        return $today;
    }


    sub date_10 {
        #my $self = shift;
        my $date_today = localtime()."\n";
        return $date_today;
    }

    sub AUTOLOAD {
        my $self = shift;
        my $arg = shift;
        our $AUTOLOAD;
        my ($sec, $min, $hour, $day, $mon, $yr, $dow) = localtime;

        # say $AUTOLOAD;
        (my $method = $AUTOLOAD) =~ s/.*:://s; # remove package name

        if ($method eq "day") {
            eval q{ sub day { return number_to_day_name($arg);  } };
            die $@ if $@;
            goto &day;
        }
        elsif ($method eq "month") {
            eval q{ sub month { number_to_mon_name($arg); } };
            die $@ if $@;
            goto &month;
        }


    }



}
1;