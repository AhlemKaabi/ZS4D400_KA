CLASS zcl_ka_structure_data_object DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ka_structure_data_object IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**********************************************************************
**********************************************************************
****************DECLARING STRUCTURE DATA OBJECTS**********************
**********************************************************************
**********************************************************************

* Example 1 : Motivation for Structured Variables
**********************************************************************

*    DATA connection_full TYPE /DMO/I_Connection.
*
*    SELECT SINGLE
*     FROM /dmo/I_Connection
**   FIELDS AirlineID, ConnectionID, DepartureAirport, DestinationAirport,
**          DepartureTime, ArrivalTime, Distance, DistanceUnit
*   FIELDS AirlineID, ConnectionID, DepartureAirport, DestinationAirport,
*          DepartureTime, ArrivalTime, Distance " Note: removing the DistanceUnit keeps the same structure, however with no data for DistanceUnit!
*    WHERE AirlineId    = 'LH'
*      AND ConnectionId = '0400'
*     INTO @connection_full.
*
*    out->write(  `--------------------------------------` ).
*    out->write(  `Example 1: CDS View as Structured Type` ).
*    out->write( connection_full ).

* Example 2: Global Structured Type
**********************************************************************

*    DATA message TYPE symsg.
*
*    out->write(  `---------------------------------` ).
*    out->write(  `Example 2: Global Structured Type` ).
*    out->write( message ).

* Example 3 : Local Structured Type
**********************************************************************

*    TYPES: BEGIN OF st_connection,
*             airport_from_id TYPE /dmo/airport_from_id,
*             airport_to_id   TYPE /dmo/airport_to_id,
*             carrier_name    TYPE /dmo/carrier_name,
*           END OF st_connection.
*
*    DATA connection TYPE st_connection.
*
*    SELECT SINGLE
*      FROM /DMO/I_Connection
*    FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
*     WHERE AirlineID = 'LH'
*       AND ConnectionID = '0400'
*      INTO @connection.
*
*    out->write(  `---------------------------------------` ).
*    out->write(  `Example 3: Local Structured Type` ).
*    out->write( connection ).

* Example 4 : Nested Structured Type
**********************************************************************

*    TYPES: BEGIN OF st_nested,
*             airport_from_id TYPE /dmo/airport_from_id,
*             airport_to_id   TYPE /dmo/airport_to_id,
*             message         TYPE symsg,
*             carrier_name    TYPE /dmo/carrier_name,
*           END OF st_nested.
*
*    DATA connection_nested TYPE st_nested.
*
*    out->write(  `---------------------------------` ).
*    out->write(  `Example 4: Nested Structured Type` ).
*    out->write( connection_nested ).

**********************************************************************
**********************************************************************
***************ACCESS TO STRUCTURE DATA OBJECTS***********************
**********************************************************************
**********************************************************************

*    TYPES: BEGIN OF st_connection,
*             airport_from_id TYPE /dmo/airport_from_id,
*             airport_to_id   TYPE /dmo/airport_to_id,
*             carrier_name    TYPE /dmo/carrier_name,
*           END OF st_connection.
*
*    TYPES: BEGIN OF st_connection_nested,
*             airport_from_id TYPE /dmo/airport_from_id,
*             airport_to_id   TYPE /dmo/airport_to_id,
*             message         TYPE symsg,
*             carrier_name    TYPE /dmo/carrier_name,
*           END OF st_connection_nested.
*
*    DATA connection TYPE st_connection.
*    DATA connection_nested TYPE st_Connection_nested.

* Example 1: Access to structure components
**********************************************************************

*    connection-airport_from_id = 'ABC'.
*    connection-airport_to_id   = 'XYZ'.
*    connection-carrier_name    = 'My Airline'.
*
*    out->write(  `-------------------------------------------------------------` ).
*    out->write(  `Example 1-1: Access to structure components - Connection` ).
*    out->write( data = connection
*                name = `Source Structure:` ).
*
*    "Access to sub-components of nested structure
*    connection_nested-message-msgty = 'E'.
*    connection_nested-message-msgid = 'ABC'.
*    connection_nested-message-msgno = '123'.
*    out->write(  `-------------------------------------------------------------` ).
*    out->write(  `Example 1-2: Access to structure components - Connection Nested` ).
*    out->write( data = connection_nested
*                name = `Source Structure:` ).

* Example 2: Filling a structure with VALUE #(    ).
**********************************************************************

*  CLEAR connection.
*
*    connection = VALUE #( airport_from_id = 'DEF'
*                          airport_to_id   = 'UVW'
*                          carrier_name    = 'My Airline'
*                        ).
*    out->write(  `-------------------------------------------------------------` ).
*    out->write(  `Example 2-1: Filling a structure with VALUE #(    ). - Connection` ).
*    out->write( data = connection
*                name = `Source Structure:` ).
*    " Nested VALUE to fill nested structure
*    connection_nested = VALUE #( airport_from_id = 'YUL'
*                                 airport_to_id   = 'YYC'
*                                 message         = VALUE #( msgty = 'B'
*                                                            msgid = 'KBI'
*                                                            msgno = '145' )
*                                 carrier_name    = 'Canada Airlines'
*                         ).
*    out->write(  `-------------------------------------------------------------` ).
*    out->write(  `Example 2-2: Filling a structure with VALUE #(    ). - Connection Nested` ).
*    out->write( data = connection_nested
*                name = `Source Structure:` ).

* Example 3: Wrong result after direct assignment
**********************************************************************

*    connection_nested = connection.
*
*    out->write(  `-------------------------------------------------------------` ).
*    out->write(  `Example 3: Wrong Result after direct assignment` ).
*
*    out->write( data = connection
*                name = `Source Structure:` ).
*
*    out->write( |Component connection_nested-message-msgid: { connection_nested-message-msgid }| ).
*    out->write( |Component connection_nested-carrier_name : { connection_nested-carrier_name  }| ).

* Example 4: Assigning Structures using CORRESPONDING #( )
**********************************************************************
*    CLEAR connection_nested.
*    connection_nested = CORRESPONDING #(  connection ).  "
*
*    out->write(  `-------------------------------------------------------------` ).
*    out->write(  `Example 4: Correct Result after assignment with CORRESPONDING` ).
*
*    out->write( data = connection
*                name = `Source Structure:` ).
*
*    out->write( |Component connection_nested-message-msgid: { connection_nested-message-msgid }| ).
*    out->write( |Component connection_nested-carrier_name : { connection_nested-carrier_name  }| ).


**********************************************************************
**********************************************************************
***************STRUCTURED DATA OBJECTS IN ABAP SQL********************
**********************************************************************
**********************************************************************


    TYPES: BEGIN OF st_connection,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection.

    TYPES: BEGIN OF st_connection_short,
             DepartureAirport   TYPE /dmo/airport_from_id,
             DestinationAirport TYPE /dmo/airport_to_id,
           END OF st_connection_short.


    DATA connection TYPE st_connection.

    DATA connection_short TYPE st_connection_short.

    DATA connection_full TYPE /DMO/I_Connection.

* Example 1: Correspondence between FIELDS and INTO
**********************************************************************

    SELECT SINGLE
       FROM /DMO/I_Connection
     FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
      WHERE AirlineID = 'LH'
        AND ConnectionID = '0400'
       INTO @connection. " Same Type, variable numbers = same target structure

    out->write(  `------------------------------` ).
    out->write(  `Example 1: Field List and INTO` ).
    out->write( connection ).

* Example 2: FIELDS *
**********************************************************************

    SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS *
     WHERE AirlineID = 'LH'
       AND ConnectionID = '0400'
      INTO @connection_full. " compatible full Structure!

    out->write(  `----------------------------` ).
    out->write(  `Example 2: FIELDS * and INTO` ).
    out->write( connection_full ).

* Example 3: INTO CORRESPONDING FIELDS
**********************************************************************

    SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS *
     WHERE AirlineID    = 'LH'
       AND ConnectionID = '0400'
      INTO CORRESPONDING FIELDS OF @connection_short. " Only corresponding Fields

    out->write(  `----------------------------------------------------` ).
    out->write(  `Example 3: FIELDS * and INTO CORRESPONDING FIELDS OF` ).
    out->write( connection_short ).

* Example 4: Alias Names for Fields
**********************************************************************

    CLEAR connection.

    SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS DepartureAirport AS airport_from_id,
           \_Airline-Name   AS carrier_name
     WHERE AirlineID    = 'LH'
       AND ConnectionID = '0400'
      INTO CORRESPONDING FIELDS OF @connection. " Only corresponding Fields works also here! if field name not similar

    out->write(  `---------------------------------------------------` ).
    out->write(  `Example 4: Aliases and INTO CORRESPONDING FIELDS OF` ).
    out->write( connection ).

* Example 5: Inline Declaration
**********************************************************************

    SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS DepartureAirport,
           DestinationAirport AS ArrivalAirport,
           \_Airline-Name     AS carrier_name
     WHERE AirlineID    = 'LH'
       AND ConnectionID = '0400'
      INTO @DATA(connection_inline). " no worry for names or Structure conflict!

    out->write(  `-----------------------------------------` ).
    out->write(  `Example 5: Aliases and Inline Declaration` ).
    out->write( connection_inline ).

* Example 6: Joins
**********************************************************************

    SELECT SINGLE
      FROM   /dmo/connection AS c

      LEFT OUTER JOIN /dmo/airport AS f
        ON c~airport_from_id = f~airport_id

      LEFT OUTER JOIN /dmo/airport AS t
        ON c~airport_to_id = t~airport_id " I like to work without brackets, it removes confusion ;)

    FIELDS c~airport_from_id, c~airport_to_id,
           f~name AS airport_from_name, t~name AS airport_to_name
     WHERE c~carrier_id    = 'LH'
       AND c~connection_id = '0400'
      INTO @DATA(connection_join).

    out->write(  `------------------------------------------` ).
    out->write(  `Example 6: Join of Connection and Airports` ).
    out->write( connection_join ).



  ENDMETHOD.
ENDCLASS.
