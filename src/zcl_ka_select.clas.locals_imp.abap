*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_connection DEFINITION.

 PUBLIC SECTION.

    CLASS-DATA conn_counter TYPE i READ-ONLY.

    METHODS constructor
      IMPORTING
        i_carrier_id TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id
      RAISING
        cx_ABAP_INVALID_VALUE.

*    METHODS set_attributes
*      IMPORTING
*        i_carrier_id    TYPE /dmo/carrier_id
*        i_connection_id TYPE /dmo/connection_id
*      RAISING
*        cx_abap_invalid_value.

    " Class Methods
    METHODS get_output
      returning
        value(r_output) type string_table.

  PROTECTED SECTION.

  PRIVATE SECTION.
    " Class Attributes
    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.
    DATA airport_from_id TYPE /dmo/airport_from_id.
    DATA airport_to_id TYPE /dmo/airport_to_id.
    DATA instance_number TYPE i.


ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD constructor.

    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    SELECT SINGLE
        FROM /dmo/connection
        FIELDS airport_from_id, airport_to_id
        WHERE carrier_id = @i_carrier_id AND connection_id = @i_connection_id
        " Without @, ABAP might try to interpret i_carrier_id as a column name in the database table.
        INTO ( @airport_from_id, @airport_to_id ).

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.


    me->carrier_id = i_carrier_id.
    me->connection_id = i_connection_id.

    conn_counter = conn_counter + 1.
    me->instance_number = conn_counter. " Saving the number of the instance of the object created!

  ENDMETHOD.

  METHOD get_output.

     APPEND |-----------------------------------------|  TO r_output.
     APPEND |Carrier:     { carrier_id               }|  TO r_output.
     APPEND |Connection:  { connection_id            }|  TO r_output.
     APPEND |Departure:   { airport_from_id          }|  TO r_output.
     APPEND |Destination: { airport_to_id            }|  TO r_output.
     APPEND |Connection Counter: { instance_number   }|  TO r_output.

  ENDMETHOD.


ENDCLASS.
