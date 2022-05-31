#!/usr/bin/perl -w

use 5.10.0;

use FindBin qw($Bin);
use lib "$Bin/ch14"; # в подкаталоге

# use CGI;
use Encode qw(decode_utf8);
use Encode qw(decode encode);
BEGIN{ $_ = map Encode::decode(\$_, 1) }
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

#require 'Date_10.pm';
use MyDate;

# File 14.2.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/

# Добавьте в сценарий, который вы написали в первом упражнении, функцию UNIVERSAL::debug.
# Эта функция должна выводить текущее время и текст сообщения, которое должно передаваться
# ей во входном аргументе. Вызовите метод debug объекта MyDate. Что произошло?
# Как это согласуется с механизмом работы AUTOLOAD?

my $date = MyDate->new();

$date->debug("Привет!");


=begin text

$ perl 14.2.pl

 [Tue May 31 11:13:20 2022] Привет!




=end text

#

=cut

