#!/usr/bin/perl -w


use 5.10.0;
# use CGI;
# use POSIX;
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
use Bundle::Camelcade;# for Intellij IDEA
use YAML;


{
    print "\n\n\t# ССЫЛКИ НА ДЕСКРИПТОРЫ ФАЙЛОВ\n\n";

    my %handlepairs;
    foreach my $file (glob('*.txt'))
    {
        #print $file."\n";
        (my $out = $file) =~ s/\.txt$/.out/;
        #print $out, "\n";
        $handlepairs{$file} = $out;

    }

    foreach (sort keys  %handlepairs) {
        say "$_ => $handlepairs{$_}";

    }








}