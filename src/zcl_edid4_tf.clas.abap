CLASS zcl_edid4_tf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .

        CLASS-METHODS get_data
      FOR TABLE FUNCTION zedid4_tf.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_edid4_tf IMPLEMENTATION.

  METHOD get_data
    BY DATABASE FUNCTION FOR HDB
    LANGUAGE SQLSCRIPT
    OPTIONS READ-ONLY
    USING edid4.

    RETURN SELECT docnum,
                  counter,
                  segnum,
                  segnam,
                  psgnum,
                  hlevel,
                  _dataaging as dataaging,
                  dtint2,
                  TO_NVARCHAR(sdata) as sdata
           FROM edid4;

  ENDMETHOD.

ENDCLASS.
