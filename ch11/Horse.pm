use v5.10;

package Horse {
    our $VERSION = '0.01';
    use parent qw(Animal);
    use utf8::all 'GLOBAL';
    use strict;
    use warnings FATAL => 'all';
    use utf8;
    binmode(STDIN, ':utf8');
    binmode(STDOUT, ':utf8');
    use Bundle::Camelcade;# for Intellij IDEA


    sub set_name {
        my $self = shift;
        $self->{Name} = shift;
    }

    sub sound {
        "иго го!!";
    }

    # sub name {
    #     my $self = shift;
    #     $$self;
    # }


    # sub speak {
    #     my $self = shift;
    #     $self->SUPER::speak();
    # }

    ## в классе Animal
    sub DESTROY {
        my $self = shift;
        #print '[объект ', $self->name, " уничтожен.]\n";
        #$self->SUPER::DESTROY;
        $self->SUPER::DESTROY if $self->can( 'SUPER::DESTROY' );
        #print "[", $self->name, " отправлен на фабрику для переработки.]\n";
    }

    1;
}