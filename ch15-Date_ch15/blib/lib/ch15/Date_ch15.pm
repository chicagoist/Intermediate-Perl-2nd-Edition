package ch15::Date_ch15;

use 5.034000;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);
our $VERSION = '0.01';
use Carp qw(croak);
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



1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

ch15::Date_ch15 - Perl extension for blah blah blah

=head1 SYNOPSIS

  use ch15::Date_ch15;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for ch15::Date_ch15, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

A. U. Thor, E<lt>legioner@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2022 by A. U. Thor

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.34.0 or,
at your option, any later version of Perl 5 you may have available.


=cut
