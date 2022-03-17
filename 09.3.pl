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

# File 09.3.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# С помощью алгоритма преобразования Шварца прочитайте список слов и отсортируйте их в алфавитном порядке.
# При этом не учитываются регистры символов и знаки пунктуации.

use File::Find;
use Time::Local;
use DDP;
use Benchmark;

sub read_file
{
    my @words;
    my %sorted;
    my @result;

    open my $fh, '<', $ARGV[0] or die "S!";
    while (<$fh>)
    {
        s/^(\d+\.*\w*\D*)//g;
        s/^([\-? | \.? | \w]*):\s+\w*\.*/$1/g;
        s/^([\-? | \.? | \w]*)\s+\w*\s+/$1/g;
        s/^(\w*\.?)\s+(\w*)/$1$2/g;
        push @words, $_;
    }
    close($fh);

    map {
        foreach my $name (sort keys %sorted)
        {
            push @result, $name;
        }
    };

    map{ $sorted{$_} = 1 }, @words;

    p @result;
}

read_file();

=begin text


 $ perl 09.3.pl IntermediatePerlDownloads/8.Filehandle.References/8.2-data-file.txt



=end text

#

=cut

# Верный ответ из книги:

