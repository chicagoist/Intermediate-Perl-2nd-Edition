#!/usr/bin/perl -w

use 5.10.0;
# use CGI;
# use Encode qw(decode_utf8);
# use Encode qw(decode encode);
#= BEGIN{@ARGV=map Encode::decode(#\$_,1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
# use open qw(:std :encoding(UTF-8));
# use utf8::all 'GLOBAL';
# use Encode::Locale;
# use Encode;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use IPC::System::Simple;
use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;
use Bundle::Camelcade;# for Intellij IDEA
use POSIX ();
use File::Spec;
use Cwd;

# File 07.1.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Профессор обновил некоторые файлы в понедельник днем и, к несчастью, забыл,
# какие именно. Это случается с ним постоянно. Он хочет, чтобы вы написали подпрограмму
# с именем gather_mtime_between,
#
# которой можно было бы передать начальную и конечную дату и время временного интервала
# и которая возвращала бы две ссылки на подпрограммы. Первая из них должна с помощью
# модуля File::Find отыскать все файлы, которые были изменены в течение указанного интервала,
# а вторая должна возвращать список найденных файлов.

use File::Find;
use Time::Local;

my $target_dow = 1;# Sunday is 0, Monday is 1, ...
my @starting_directories = (".");

sub gather_mtime_between
{
    my($start_time, $stop_time) = @_;
    my @list_of_files;

    return ( sub {
        my $mtime = (stat $_)[9];
        unless (defined $mtime) {
            warn "Unable to get information about $File::Find::name: $!,missed\n";
            return;
        }
        push @list_of_files, $File::Find::name if $mtime < $stop_time && $mtime > $start_time;
    }, sub {return  @list_of_files});


}

my $seconds_per_day = 24 * 60 * 60;
my ($sec, $min, $hour, $day, $mon, $yr, $dow) = localtime;
my $start = timelocal(0, 0, 0, $day, $mon, $yr);# midnight today

while ($dow != $target_dow)
{
    # Back up one day
    $start -= $seconds_per_day;# hope no DST! :-)
    if (--$dow < 0)
    {
        $dow += 7;
    }
}
my $stop = $start + $seconds_per_day;

my ($gather, $yield) = gather_mtime_between($start, $stop);
find($gather, "@starting_directories");
my @files = $yield->();


for my $file (@files)
{
    my $mtime = (stat $file)[9];# mtime via slice
    my $when = localtime $mtime;
    print "$when: $file\n";
}




=begin text


 $ perl 07.1.pl




=end text

#

=cut

# Верный ответ из книги:

