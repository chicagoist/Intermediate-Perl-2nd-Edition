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

# File 09.2.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Ознакомьтесь с описанием модуля Benchmark, входящего в состав дистрибутива Perl.
# Напишите программу, с помощью которой можно было бы ответить на вопрос:
# «Насколько эффективнее оказалась реализация примера из первого упражнения на основе преобразования Шварца?»

use File::Find;
use Time::Local;
use DDP;
use Benchmark;
my $count = 0;

timethese($count, {
    'Scwartz' => sub {
my @sorted =
map $_->[0],
sort { $a->[1] <=> $b->[1] }
map [ $_, -s $_ ],
glob "~/*";
}
});

timethese($count, {
    'Normal' => sub {
        my @sorted = sort { -s $a <=> -s $b } glob "~/*";
    }
});

=begin text


 $ perl 09.2.pl

  Benchmark: running Scwartz for at least 3 CPU seconds...
   Scwartz:  4 wallclock secs ( 0.67 usr +  3.30 sys =  3.97 CPU) @ 3629.72/s (n=14410)
 Benchmark: running Normal for at least 3 CPU seconds...
    Normal:  3 wallclock secs ( 0.20 usr +  2.88 sys =  3.08 CPU) @ 1026.30/s (n=3161)

=end text

#

=cut

# Верный ответ из книги:

;

