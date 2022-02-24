#!/usr/bin/perl -w

use 5.10.0;
# use CGI;
use Encode qw(decode_utf8);
use Encode qw(decode encode);
BEGIN{$_ = map Encode::decode(\$_, 1)}
# BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
use open qw(:std :encoding(UTF-8));
use utf8::all 'GLOBAL';
use Encode::Locale;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use IPC::System::Simple;
use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');

use Data::Dumper;
use Bundle::Camelcade;# for Intellij IDEA
use POSIX ();
use File::Spec;
use Cwd;

# File 08.1.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Напишите программу, которая будет выводить число, месяц, год и день недели, но при этом она должна дать пользователю
# возможность выбирать, записывать ли данные в файл, в скалярную переменную или одновременно и в файл, и в переменную.
# Независимо от того, какой вариант выберет пользователь, вывод должен производиться единственным обращением к функции
# print. Если пользователь предпочтет вывод в скалярную переменную, программа должна выводить ее содержимое на экран
# перед завершением работы.

use File::Find;
use Time::Local;

my $time_list = localtime() . "\n";
my $string_log = '';


open(my $fh_string, '>>', \$string_log) or die "Cannot open string $string_log: $!";
binmode $fh_string;

open(my $fh_file, '>>', "IntermediatePerlDownloads/5.References.And.Scoping/coconet_backup.dat")
    or die "Cannot open file 'coconet_backup.dat' : $!";
binmode $fh_file;

print "If you want save time date to File enter 1\nIf you want save time date to Variable enter 2\nIf you want save time date to File and Variable both enter 3 :";

chomp(my $answer = <STDIN>);
#
# unless ($answer > 3 || $answer < 1)
# {
#     if ($answer == 1)
#     {
#         print $fh_file $time_list;
#         close($fh_string);
#         close($fh_file);
#     }
#     elsif ($answer == 2)
#     {
#         print $fh_string $time_list;
#         close($fh_string);
#         close($fh_file);
#         print "\n".$string_log;
#     }
#     elsif ($answer == 3)
#     {
#         print $fh_string $time_list;
#         print $fh_file $time_list;
#         close($fh_string);
#         close($fh_file);
#         print "\n".$string_log;
#
#     }
#     else
#     {
#         0;
#     }
# }

unless ($answer > 3 || $answer < 1)
{
    my @FSH = ($fh_file, $fh_string, [$fh_file, $fh_string] );
    my %FHS = ();



    if ($answer == 1)
    {

        $FHS{$answer} = $fh_file;

    }
    elsif ($answer == 2)
    {
        $FHS{$answer} = $fh_string;

    }
    elsif ($answer == 3)
    {

        $FHS{$answer} =  $fh_string;
        print {$FSH[2][0]} $time_list;

    }
    else
    {
        0;
    }

    print {$FHS{$answer}}  $time_list;
    close($fh_string);
    close($fh_file);
    print "\n".$string_log if $string_log;
}




=begin text


 $ perl 08.1.pl




=end text

#

=cut

# Верный ответ из книги:

