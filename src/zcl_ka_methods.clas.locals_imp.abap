*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.

* Attributes
**********************************************************************

    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.
*    CLASS-DATA conn_counter TYPE i.

* Methods
**********************************************************************

    METHODS set_attributes
    " Method to set values for carrier_id and connection_id
    " Add implementation
        IMPORTING
            i_carrier_id    TYPE /dmo/carrier_id DEFAULT 'LH'
            i_connection_id TYPE /dmo/connection_id
        RAISING
        cx_abap_invalid_value.

*    METHODS get_attributes
*    " Method to get/return values of carrier_id and connection_id
*    " Add implementation
*        EXPORTING
*            e_carrier_id    TYPE /dmo/carrier_id
*            e_connection_id TYPE /dmo/connection_id.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.


  METHOD set_attributes.
  " Implementation method of the set_attributes method
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    carrier_id = i_carrier_id.
    connection_id = i_connection_id.
*    conn_counter = conn_counter + 1.

  ENDMETHOD.

*  METHOD get_attributes.
*  " Implementation method of the get_attributes method
*    e_carrier_id = carrier_id.
*    e_connection_id = connection_id.
*  ENDMETHOD.

ENDCLASS.
