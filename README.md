# RUBY-Project
## Какво представлява проекта
  Целта на този проект е да се разработи програма(скрипт), която(който)
трябва да успее да преброи думите в различни програми, написани на Ruby,
C++ и Java. За целта ще се използва скриптовия език Ruby.

## Хора, участващи в разработката на този проект:

1. Георги Стоилов 11Б клас, №9
2. Иво Гергинов 11Б клас, №14
3. Йордан Янкулов 11Б клас, №15
4. Мартин Гълъбов 11Б клас, №21
5. Петър Цанков 11Б клас, №24

## Задачи за изпълнение
  1. Да се намерят хранилища.
    * 1.1. Хранилища за Ruby код, може да се намери на сайта https://github.com/
    * 1.2. Хранилища за C++ код, може да се намери на сайта https://github.com/
    * 1.3. Хранилища за Java код, може да се намери на сайта https://eclipse.org/
    * 1.4. От всеки вид трябва да бъдат парснати(прочетени и преброени) минимум
        1 милион реда
    * 1.5. Всичките хранилища трябва да бъдат извадени в .txt файл, като за Ruby
        хранилище файла ще се казва Ruby_Repositories.txt. Така и за останалите.
        (В .txt файла се слага LINK към даденото Repository)
  2. Да се направи скрипта(програмата)
    * 2.1. Той трябва успешно да преброява само думите във всеки файл.
      * 2.1.1. Той трябва да може да раздели думите в кода на: ??????????????
    * 2.2. След успешно преброяване, скрипта трябва да може да нарисува графика в
        SVG формат.
    * 2.3. Този скрипт да спира при прочитане на повече от 1 милион реда код.
  3. Проверка на скрипта
    * 3.1. Скрипта трябва да се провери. Проверката става ръчно. Т.е. някой от
        хората, участващи в екипа трябва да седне и да парсне например Ruby
        файл и да го сравни с резултата от скрипта, пуснат върху същият този
        файл. Ако няма разминавания, то значи скрипта е верен.
  4. Пускане на самият скрипт върху всички хранилища
    * 4.1. Преброяването на думи в 3 милиона реда код отнема време. Поради тази
        причина 3-ма от екипа трябва да си разделят тези 3 милиона и да ги
        парснат.
  5. Резултат
    * 5.1. Резултата е сбор от парсването на всички 3 милиона реда код.
    * 5.2. Трябва да се начертае хубава SVG характеристика, която да показва кои
        думи са най-използваните в трите езика.

####За задача 2 вече има и 2 предложени начина
    Въпроса е как да се обработват всичките хранилища.
    I.Начин:
      При пускане на скрипта той да клонира хранилището в папка, след това скрипта
      да обходи папката и да намери съответните файлове и накрая след прочитане на
      всички файлове да изтривя клонираното хранилище и да започне същата процедура
      с друго.
    II.Начин:
      Директно чрез подаване на LINK към скрипта, той да извлича всички файлове
      от хранилището и да ги парсва

##Време
  1. Всеки един да напише в този .md файл, кои задача евентуално може да поеме и
    според него колко време ще му отнеме да се справи със всяка 1 задача
    * 1.1. Георги: Скрипт

    * 1.2. Иво: Хранилища и скрипт

    * 1.3. Йордан: Работа по SVG

    * 1.4. Мартин: Пускане на скрипта

    * 1.5. Петър: Ръчно парсване и проверка на скрипта
  2. Човек, който не направи поне 1 задача няма да бъде писан в Екипа.

## Срок за изпълнение: до 09.01.2016г.
    Правя срока преди максимално допустимия, за да се съберем и обсъдим дали сме готови или не.
