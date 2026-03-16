CLASS zcl_ka_data_objects DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ka_data_objects IMPLEMENTATION.

    METHOD if_oo_adt_classrun~main.

* Data Objects with Built-in Types
**********************************************************************

    " comment/uncomment the following declarations and check the output
*    DATA variable TYPE string.
*    DATA variable TYPE i.
*    DATA variable TYPE d.
*    DATA variable TYPE c LENGTH 10.
*    DATA variable TYPE n LENGTH 10.
*    DATA variable TYPE p LENGTH 8 DECIMALS 2.

* Output
**********************************************************************

*    out->write(  'Result with Initial Value)' ).
*    out->write(   variable ).
*    out->write(  '---------' ).

*    variable = 543.

*    out->write(  'Result with Value 543' ).
*    out->write(   variable ).
*    out->write(  '---------' ).


* Example 1: Local Types
**********************************************************************

* Comment/Uncomment the following lines to change the type of my_var
*    TYPES my_type TYPE p LENGTH 3 DECIMALS 2.
*    TYPES my_type TYPE i .
*    TYPES my_type TYPE string.
*    TYPES my_type TYPE n length 10.

* Variable based on local type
*    DATA my_variable TYPE my_type.

*    out->write(  `my_variable (TYPE MY_TYPE)` ).
*    out->write(   my_variable ).

* Example 2: Global Types
**********************************************************************

* Variable based on global type .
    " Place cursor on variable and press F2 or F3
*    DATA airport TYPE /dmo/airport_id VALUE 'FRA'.

*    out->write(  `airport (TYPE /DMO/AIRPORT_ID )` ).
*    out->write(   airport ).

* Example 3: Constants
**********************************************************************

*    CONSTANTS c_text   TYPE string VALUE `Hello World`.
*    CONSTANTS c_number TYPE i      VALUE 12345.

    "Uncomment this line to see syntax error ( VALUE is mandatory)
*    constants c_text2   type string VALUE.
*    constants c_text2   type string VALUE 'Hello ABAP'. "correct format!

*    out->write(  `c_text (TYPE STRING)` ).
*    out->write(   c_text ).
*    out->write(  '---------' ).

*    out->write(  `c_number (TYPE I )` ).
*    out->write(   c_number ).
*    out->write(  `---------` ).

* Example 4: Literals
**********************************************************************

*    out->write(  '12345               ' ).    "Text Literal   (Type C)
*    out->write(  `12345               ` ).    "String Literal (Type STRING)
*    out->write(  12345                  ).    "Number Literal (Type I)

    "uncomment this line to see syntax error (no number literal with digits)
*    out->write(  12345.67                  ).


* Example 5: CLEAR
**********************************************************************

*    DATA my_var1 TYPE i.
*    DATA my_var2 TYPE i VALUE 1234.
*    DATA my_var3 TYPE string.

*    out->write( 'Writing initial Values' ).
*    out->write( | my_var1 = { my_var1 } | ).
*    out->write( | my_var2 = { my_var2 } | ).
*    out->write( | my_var3 = { my_var3 } | ).

*    my_var1 = my_var2.
*    my_var3 = 'Hello World'.

*    out->write( 'Writing Values after update' ).
*    out->write( | my_var1 = { my_var1 } | ).
*    out->write( | my_var2 = { my_var2 } | ).
*    out->write( | my_var3 = { my_var3 } | ).

*    CLEAR my_var1. " Value is reset to 0.
*    CLEAR my_var2. " Value is reset to 0!
*    CLEAR my_var3. " String is now empty again

*    out->write( 'Writing Values after using CLEAR' ).
*    out->write( | my_var1 = { my_var1 } | ).
*    out->write( | my_var2 = { my_var2 } | ).
*    out->write( | my_var3 = { my_var3 } | ).

* Example 6: Inline Object Declaration
**********************************************************************

    DATA(my_var) = 'Hello World - inline declaration'.
    out->write( my_var ).


  ENDMETHOD.


ENDCLASS.
