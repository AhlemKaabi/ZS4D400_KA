CLASS zcl_ka_global DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ka_global IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    out->write( 'test Global' ).
  ENDMETHOD.
ENDCLASS.
