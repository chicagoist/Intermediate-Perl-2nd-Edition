#!/usr/bin/perl -w

use 5.10.0;
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

# File 09.4.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Измените подпрограмму рекурсивного вывода содержимого каталога так, чтобы имена вложенных
# каталогов отображались с отступами. Пустые каталоги должны отображаться как:

# sandbar, пустой каталог

# а непустые каталоги должны выводиться со всем своим содержимым, с отступом в два пробела:

# uss_minnow, with contents:
#    anchor
#    broken_radio
#    galley, with contents:
#        captain_crunch_cereal
#        gallon_of_milk
#        tuna_fish_sandwich
#    life_preservers

use File::Find;
use Time::Local;
use DDP;
use Benchmark;

sub data_for_path {
    my $path = shift;
    if (-f $path or -l $path) {  # files or symbolic links
        return undef;
    }
    if (-d $path)
    {
        my %directory;
        opendir PATH, $path or die "Cannot opendir $path: $!";
        my @names = readdir PATH;
        closedir PATH;
        for my $name (@names)
        {
            next if $name eq '.' or $name eq '..';
            $directory{$name} = data_for_path("$path/$name");
        }
        return \%directory;
    }
    warn "$path is neither a file nor a directory\n";
    return undef;
}


sub read_directorys
{
    my $path = shift;
    my $data = shift;
    my $prefix = shift || "";
    print "$prefix$path";
    if (not defined $data)
    {
        # обычный файл
        print "\n";
        return;
    }
    my %directory = %{$data};
    if (%directory)
    {
        print ", содержит:\n";
        for (sort keys %directory)
        {
            read_directorys($_, $directory{$_}, "$prefix  ");
        }
    }
    else
    {
        print ", пустой каталог\n";
    }
}

read_directorys('.', data_for_path('.'));

=begin text


 $ perl 09.4.pl



=end text

#

=cut

# Верный ответ из книги:

# my @dictionary_sorted =
# map $_−>[0],sort { $a−>[1] cmp $b−>[1] }
# map {
# my $string = $_;
# $string =~ s/\P{Letter}//g;  # remove nonletters
# $string = fc( $string );     # a proper case
# fold[ $_, $string ];
# }
# @input_list;

