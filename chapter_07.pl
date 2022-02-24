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
    print "\n\n\t# ССЫЛКИ НА ПОДПРОГРАММЫ\n\n";

    print "# Ссылки на именованные подпрограммы\n\n";

    sub professor_greets
    {
        my $person = shift;
        print "Профессор: Насколько я понимаю, вы $person!\n";
    }

    sub skipper_greets
    {
        my $person = shift;
        print "Шкипер: Эй, $person!\n";
    }

    sub gilligan_greets
    {
        my $person = shift;
        if ($person eq "Шкипер")
        {
            print "Джиллиган: Сэр, $person!\n";
        }
        else
        {
            print "Джиллиган: Привет, $person!\n";
        }
    }



    skipper_greets("Джиллиган");
    gilligan_greets("Шкипер");
    skipper_greets('Профессор');
    gilligan_greets('Профессор');
    professor_greets('Джиллиган');
    professor_greets('Шкипер');


    # Разыменование ссылки на подпрограмму напоминает процедуру разыменования любых других ссылок.
    # Для начала рассмотрим способ, которым мы воспользовались бы, ничего не зная о ссылках (включая
    # необязательный символ амперсанда):

    # & skipper_greets ( 'Джиллиган' )

    # Теперь заменим имя подпрограммы на имя ссылки, окруженное фигурными скобками:

    # & { $ref_to_greeter } ( 'Джиллиган' )

    # Эта конструкция вызывает подпрограмму, на которую в настоящий момент ссылается $ref_to_greeter,
    # и передает ей единственный аргумент: имя Джиллиган. Однако такая форма записи выглядит несколько
    # уродливо, вам не кажется? К счастью, здесь применимы те же правила упрощения, что и для обычных
    # ссылок. Если в фигурных скобках стоит обычная скалярная переменная, их можно просто опустить:

    # & $ref_to_greeter ( 'Джиллиган' )

    # Можно даже воспользоваться оператором стрелки:

    # $ref_to_greeter -> ( 'Джиллиган' )

    # Последняя форма записи особенно удобна, когда ссылка находится внутри большой структуры данных.
    #

    print "\n\n";
    for my $greet (\&skipper_greets, \&gilligan_greets)
    {
        &$greet('Профессор');
        $greet->('Шкипер');
    }


    # Попробуем создать таблицу, в которой определим соответствие между именами персонажей и
    # их реакцией на приветствие других людей, а затем перепишем предыдущий пример, основываясь
    # на этой таблице:

    print "\n\n";
    my %greets = (
        Gilligan  => \&gilligan_greets,
        Skipper   => \&skipper_greets,
        Professor => \&professor_greets,);

    for my $person (qw(Skipper Gilligan))
    {
        $greets{$person}->('Профессор');
    }

    print "\n\n";
    my @everyone = sort keys %greets;
    for my $greeter (@everyone)
    {
        for my $greeted (@everyone)
        {
            $greets{$greeter}->($greeted)
                unless $greeter eq $greeted;# не стоит приветствовать себя самого
        }
    }

    print "\n\n";
    my %greets_ru = (
        "Джиллиган" => \&gilligan_greets,
        "Шкипер"    => \&skipper_greets,
        "Профессор" => \&professor_greets,
    );

    my @room;# сначала в хижине никого нет
    for my $person (qw(Джиллиган Шкипер Профессор))
    {

        print "\n";
        print "В хижину входит $person.\n";
        for my $room_person (@room)
        {
            $greets_ru{$person}->($room_person);# $person приветствует $room_person
            $greets_ru{$room_person}->($person);# получает ответ from $room_person
        }
        push @room, $person;# входит и устраивается поудобнее
    }
    print "\n\n";

}

{
    print "# Анонимные подпрограммы \n\n";

    # Добавим еще один персонаж, Джинджер, и определим ее поведение с
    # помощью анонимной подпрограммы:

    my $ginger = sub {
        my $person = shift;
        print "Джинджер: (томным голосом) О! Салют, $person!\n";
    };

    # Анонимная подпрограмма объявляется так же, как и обычная, но между
    # ключевым словом sub и открывающей скобкой блока программного кода
    # нет имени. Кроме того, такая форма записи расценивается как часть
    # выражения, поэтому объявление анонимной подпрограммы должно завершаться
    # точкой с запятой или иным разделителем выражений, как и в большинстве случаев.

    $ginger->('Шкипер');

    print "\n\n";

    my %greets_ref_sub = (

        'Джиллиган' => sub {
            my $person = shift;
            if ($person eq "Шкипер")
            {
                print "Джиллиган: Сэр, $person!\n";
            }
            else
            {
                print "Джиллиган: Привет, $person!\n";
            }
        },

        'Шкипер'    => sub {
            my $person = shift;
            print "Шкипер: Эй, $person!\n";
        },

        'Профессор' => sub {
            my $person = shift;
            print "Профессор: Насколько я понимаю, вы $person!\n";
        },

        'Джинджер'  => sub {
            my $person = shift;
            print "Джинджер: (томным голосом) О! Салют, $person!\n";
        }

    );

    my @room;# сначала в хижине никого нет
    for my $person (qw(Джиллиган Шкипер Профессор Джинджер))
    {

        print "\n";
        print "В хижину входит $person.\n";
        for my $room_person (@room)
        {
            $greets_ref_sub{$person}->($room_person);# $person приветствует $room_person
            $greets_ref_sub{$room_person}->($person);# получает ответ from $room_person
        }
        push @room, $person;# входит и устраивается поудобнее
    }
    print "\n\n";

}


{
    print "# Подпрограммы обратного вызова \n\n";

    # Очень часто ссылки на подпрограммы служат для организации обратных вызовов. Подпрограмма обратного вызова
    # определяет, что необходимо сделать, когда программа достигает определенной точки в алгоритме.
    use File::Find;
    sub what_to_do
    {
        print "Найден файл или каталог $File::Find::name\n";
    }
    my @starting_directories = qw(..);
    find(\&what_to_do, @starting_directories);

    # Не имеет большого смысла придумывать название для подпрограммы, которая вызывается лишь в одном месте,
    # поэтому перепишем предыдущий пример, оставив подпрограмму анонимной:
    find(sub {
        print "Найден файл или каталог $File::Find::name\n";
        $_ = undef;

    },
        @starting_directories,
    );

    print "\n\n";
}

{
    print "# Замыкания\n\n";

    # После разыменования ссылки подпрограмма получает доступ ко всем видимым переменным.
    # Например:
    use File::Find;
    my $total_size = 0;

    find(sub {$total_size += -s if -f}, '.');
    print $total_size, "\n";

    # В терминах языка Perl замыкание – это подпрограмма, которая может обращаться к лексическим
    # переменным, расположенным вне области видимости данной подпрограммы.

    my $callback;

    {
        my $count = 0;
        $callback = sub {print ++$count, ": $File::Find::name\n"};

        say "\$count = $count";

    }

    find($callback, '.');
    #$Data::Dumper::Deparse=1;


    # print Dumper $callback->();
    print Dumper $callback;

    print "\n\n";

}

{
    print "# Подпрограмма как возвращаемое значение другой подпрограммы\n\n";

    # Блок кода прекрасно подходит для объявления подпрограммы обратного вызова,
    # но гораздо удобнее иметь подпрограмму, которая возвращала бы ссылку на другую
    # подпрограмму!
    use File::Find;

    sub create_find_callback_that_counts
    {
        my ($count) = 0;
        return (sub {print ++$count, ":: $File::Find::name\n"}, sub {return $count});

    }
    # Здесь мы имеем практически то же, что и раньше, только оформили все несколько иначе.

    my ($callback, $callback_count) = create_find_callback_that_counts();
    # find($callback, '.');

    print "мой каталог \/bin:\n";
    find($callback, '/bin');

    print "мой каталог \/lib:\n";
    find($callback, '/lib');

    # 593:: /bin/znew
    # мой каталог /lib:
    # 594:: /lib

    # 124:: /bin/zmore
    # 125:: /bin/znew
    # мой каталог /lib:
    # 126:: /lib
    # 127:: /lib/cpp

    my ($callback1, undef) = create_find_callback_that_counts();
    my ($callback2, undef) = create_find_callback_that_counts();
    # find($callback, '.');

    print "мой каталог1 \/bin:\n";
    find($callback1, '/bin');

    print "мой каталог2 \/lib:\n";
    find($callback2, '/lib');
    # В этом случае у нас появятся две разные переменные $count,
    # каждая из которых будет доступна только из своей подпрограммы обратного вызова.
    # ...
    # 826:: /lib/x86_64-linux-gnu/security/pam_wheel.so
    # 827:: /lib/x86_64-linux-gnu/security/pam_xauth.so
    # мой каталог1 /bin:
    # 1:: /bin
    # 2:: /bin/bash
    # ...
    # 124:: /bin/zmore
    # 125:: /bin/znew
    # мой каталог2 /lib:
    # 1:: /lib
    # 2:: /lib/cpp


    print Dumper($callback);
    print "\n";

    say "\$count = " . &$callback_count;
    print "DUMMY = " . $callback_count->('DUMMY') . "\n";
    print Dumper($callback_count->('DUMMY'));
    print "\n";
    p &{$callback};


    sub create_find_callbacks_that_sum_the_size
    {
        my $total_size = 0;
        return (sub {$total_size += -s if -f}, sub {return $total_size});
    }

    # создание подпрограмм
    my %subs;
    foreach my $dir (qw(/bin /lib /var/log))
    {
        my ($callback_total, $getter) = create_find_callbacks_that_sum_the_size();
        $subs{$dir}{CALLBACK} = $callback_total;
        $subs{$dir}{GETTER} = $getter;
    }

    ## собрать данные
    for (keys %subs)
    {
        find($subs{$_}{CALLBACK}, $_);
    }

    ## вывести результаты
    for (sort keys %subs)
    {
        my $sum = $subs{$_}{GETTER}->('DUMMY');
        print "суммарный размер файлов в каталоге $_ = $sum bytes\n";
    }

    # суммарный размер файлов в каталоге /bin = 15459490 bytes
    # суммарный размер файлов в каталоге /lib = 59056126 bytes
    # суммарный размер файлов в каталоге /var/log = 2339349 bytes

}

{
    print "# Использование переменных замыканий для ввода данных \n\n";

    # Попробуем написать подпрограмму, создающую подпрограмму обратного вызова для
    # работы с модулем File::Find, которая в свою очередь будет выводить имена файлов
    # с размером, превышающим некое значение:

    sub print_bigger_than
    {
        my $minimum_size = shift;
        return sub {print "файл > $minimum_size : $File::Find::name\n"
            if -f and -s >= $minimum_size};
    }

    my $bigger_than_1024 = print_bigger_than(1024);
    find($bigger_than_1024, '/bin');

}