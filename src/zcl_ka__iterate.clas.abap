CLASS zcl_ka__iterate DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ka__iterate IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*   The Fibonacci numbers are a sequence of numbers
*   in which each number is the sum of the two preceding ones.

*   The sequence starts with 0 and 1, and each subsequent number
*   is the sum of the two previous numbers.
*   The sequence has various mathematical properties, patterns,
*   and applications in fields such as mathematics, computer science, nature, and art.


    CONSTANTS max_count TYPE i VALUE 20.
    DATA Fib_table TYPE TABLE OF i.
    " Declare an internal table of row type string (suggested name: output).
    DATA output TYPE TABLE of string.


    DATA(i) = 1.

    DO max_count TIMES.

        CASE sy-index.
         WHEN 1.
            APPEND 0 TO Fib_table.
         WHEN 2.
          APPEND 1 TO Fib_table.
         WHEN OTHERS.
          APPEND Fib_table[  sy-index - 2 ] + Fib_table[  sy-index - 1 ] TO Fib_table.
        ENDCASE.
*        APPEND Fib_table[ i ] + Fib_table[ i + 1 ] TO Fib_table.
*        i = i + 1.
*        IF i > 20. EXIT. ENDIF.
    ENDDO.

    DATA(counter) = 0.
    LOOP AT Fib_table INTO DATA(number).
        counter = counter + 1.

        APPEND |{ counter WIDTH = 4 ALIGN = LEFT }: { number WIDTH = 10 ALIGN = RIGHT } | TO output.



    ENDLOOP.


    out->write( Fib_table ).

    out->write(
           data   = output
           name   = |The first { max_count } Fibonacci Numbers|
                 ) .


  ENDMETHOD.
ENDCLASS.
