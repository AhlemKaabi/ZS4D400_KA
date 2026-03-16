CLASS zcl_ka_compute DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ka_compute IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    DATA number1 TYPE i.
    DATA number2 TYPE i.
*   Controling the Result Precision

    DATA result TYPE p LENGTH 8 DECIMALS 2.


    number1 = -8.
    number2 =  3.


    result = number1 / number2.


    DATA(output) = |{ number1 } / { number2 } = { result }|.

    out->write( output ).

  ENDMETHOD.
ENDCLASS.
