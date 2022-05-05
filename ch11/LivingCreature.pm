use v5.10;

package LivingCreature {
    our $VERSION = '0.01';

    use utf8::all 'GLOBAL';
    use strict;
    use warnings FATAL => 'all';
    use utf8;
    binmode(STDIN, ':utf8');
    binmode(STDOUT, ':utf8');
    use Bundle::Camelcade;# for Intellij IDEA

    sub speak {
        my $class = shift;
        if (@_) {
            print "$class speak: "."@_\n";
        }
        else {
            print "$class speak: ".$class->sound."\n";
        }
    }

    sub sound {
        die 'You have to define sound() in a subclass'
    }


    1;
}