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

    TYPES: BEGIN OF st_connection,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection.

    TYPES: BEGIN OF st_connection_nested,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             message         TYPE symsg,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection_nested.

    DATA connection TYPE st_connection.
    DATA connection_nested TYPE st_Connection_nested.

* Example 1: Access to structure components
**********************************************************************

    connection-airport_from_id = 'ABC'.
    connection-airport_to_id   = 'XYZ'.
    connection-carrier_name    = 'My Airline'.

    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 1-1: Access to structure components - Connection` ).
    out->write( data = connection
                name = `Source Structure:` ).

    "Access to sub-components of nested structure
    connection_nested-message-msgty = 'E'.
    connection_nested-message-msgid = 'ABC'.
    connection_nested-message-msgno = '123'.
    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 1-2: Access to structure components - Connection Nested` ).
    out->write( data = connection_nested
                name = `Source Structure:` ).

* Example 2: Filling a structure with VALUE #(    ).
**********************************************************************

  CLEAR connection.

    connection = VALUE #( airport_from_id = 'DEF'
                          airport_to_id   = 'UVW'
                          carrier_name    = 'My Airline'
                        ).
    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 2-1: Filling a structure with VALUE #(    ). - Connection` ).
    out->write( data = connection
                name = `Source Structure:` ).
    " Nested VALUE to fill nested structure
    connection_nested = VALUE #( airport_from_id = 'YUL'
                                 airport_to_id   = 'YYC'
                                 message         = VALUE #( msgty = 'B'
                                                            msgid = 'KBI'
                                                            msgno = '145' )
                                 carrier_name    = 'Canada Airlines'
                         ).
    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 2-2: Filling a structure with VALUE #(    ). - Connection Nested` ).
    out->write( data = connection_nested
                name = `Source Structure:` ).

* Example 3: Wrong result after direct assignment
**********************************************************************

    connection_nested = connection.

    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 3: Wrong Result after direct assignment` ).

    out->write( data = connection
                name = `Source Structure:` ).

    out->write( |Component connection_nested-message-msgid: { connection_nested-message-msgid }| ).
    out->write( |Component connection_nested-carrier_name : { connection_nested-carrier_name  }| ).

* Example 4: Assigning Structures using CORRESPONDING #( )
**********************************************************************
    CLEAR connection_nested.
    connection_nested = CORRESPONDING #(  connection ).  "

    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 4: Correct Result after assignment with CORRESPONDING` ).

    out->write( data = connection
                name = `Source Structure:` ).

    out->write( |Component connection_nested-message-msgid: { connection_nested-message-msgid }| ).
    out->write( |Component connection_nested-carrier_name : { connection_nested-carrier_name  }| ).


  ENDMETHOD.
ENDCLASS.
