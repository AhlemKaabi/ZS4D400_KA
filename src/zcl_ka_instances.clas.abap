CLASS zcl_ka_instances DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ka_instances IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA connections TYPE TABLE OF REF TO lcl_connection.
    DATA connection TYPE REF TO lcl_connection.

* First Instance
**********************************************************************

    connection = NEW #( ).

    TRY.
        connection->set_attributes(
            EXPORTING
                i_carrier_id = 'DV'
                i_connection_id = '0100' ).

        APPEND connection TO connections.

    CATCH cx_abap_invalid_value.

        out->write( `Method call failed - instance 1` ).

    ENDTRY.

* Second instance
**********************************************************************

    connection = NEW #(  ).

    TRY.
        connection->set_attributes(
          EXPORTING
            i_carrier_id    = 'AA'
            i_connection_id = '0017'
        ).

*        connection->carrier_id    = 'AA'.
*        connection->connection_id = '0017'.

        APPEND connection TO connections.

    CATCH cx_abap_invalid_value.
        out->write( `Method call failed - instance 2` ).
    ENDTRY.

* Third instance
**********************************************************************
    connection = NEW #(  ).

    TRY.
*        connection->set_attributes(
*          EXPORTING
*            i_carrier_id    = 'SQ'
*            i_connection_id = '0001'
*        ).
         connection->set_attributes(
          EXPORTING
            i_carrier_id = '10'
            i_connection_id = '0000'
        ).

*        connection->carrier_id    = 'SQ'.
*        connection->connection_id = '0001'.

        APPEND connection TO connections.

    CATCH cx_abap_invalid_value.
        out->write( `Method call failed - instance 3` ).
    ENDTRY.

* Output
**********************************************************************

    LOOP AT connections INTO connection.
            out->write( 'test output' ).
            out->write( connection->get_output( ) ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
