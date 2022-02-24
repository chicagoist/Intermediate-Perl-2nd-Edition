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
use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;
use Bundle::Camelcade; # for Intellij IDEA
use POSIX();
use File::Spec;
use Cwd;
use Business::ISBN;
#use constant LIB_DIR => '/home/legioner/lib/perl5/site_perl/5.34.0';
#use lib LIB_DIR;

# File 03.2.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Попробуйте выполнить интерпретацию ISBN этой книги, который вы найдете на
# последней странице обложки (0596102062).
# Установите модуль Business::ISBN  из CPAN и воспользуйтесь им для извлечения
# кода страны и кода издателя из указанного числа.

my $dir =  cwd();
my $isbn = '0596102062';
# Account for / and \ on Win32 and non-Win32 systems
# ($^O =~ /Win32/) ? ($dir = getcwd) =~ s/\//\\/g : ($dir = getcwd); # for with pragma use POSIX;

# print "Enter your ISBN number : ";
# chomp($isbn = <STDIN>);
my $isbn10 = Business::ISBN->new($isbn);

print Dumper $isbn10;

print "Code of publisher = " . $isbn10->publisher_code , "\n";
# print "Code of country = " . $isbn->Business::ISBN::Data::country_code , "\n";


=begin text

  $ perl 03.2.pl
   $VAR1 = bless( {
                 'valid' => 1,
                 'article_code' => '10206',
                 'publisher_code' => '596',
                 'isbn' => '0596102062',
                 'group_code' => '0',
                 'common_data' => '0596102062',
                 'checksum' => '2',
                 'prefix' => '',
                 'input_isbn' => '0596102062',
                 'type' => 'ISBN10'
               }, 'Business::ISBN10' );

 Code of publisher = 596



=end text

=cut


# Верный ответ из книги:

# Не думаю, что вы столкнетесь с серьезными проблемами при установке модуля.
# Но если это произойдет, можете обратиться с вопросами к Брайану, поскольку
# он является автором этого модуля, как и автором программы cpan, которую вы
# наверняка будете использовать для установки модуля. После установки модуля
# нам остается лишь следовать примеру из документации к нему. Наша программа
# принимает номер ISBN в виде аргумента командной строки и создает новый объект
# ISBN, который сохраняется в виде переменной $isbn. Затем мы просто делаем все
# в соответствии с примером из документации.

# use Business::ISBN;
# my $isbn = Business::ISBN >new( $ARGV[0] );
# print "ISBN: " . $isbn->as_string . "\n";
# print "Код страны: " . $isbn->country_code . "\n";
# print "Код издательства: " . $isbn->publisher_code . "\n";

#