class ZCL_ZODATA_IDOC_NEXUS_DPC_EXT definition
  public
  inheriting from ZCL_ZODATA_IDOC_NEXUS_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_DEEP_ENTITY
    redefinition .
protected section.

  methods MASS_EDITSET_GET_ENTITYSET
    redefinition .
  methods PROCESS_IDOCSET_GET_ENTITYSET
    redefinition .
  methods PROCESS_IDOCSET_CREATE_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZODATA_IDOC_NEXUS_DPC_EXT IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~create_deep_entity.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_DEEP_ENTITY
*  EXPORTING
**    iv_entity_name          =
**    iv_entity_set_name      =
**    iv_source_name          =
*    IO_DATA_PROVIDER        =
**    it_key_tab              =
**    it_navigation_path      =
*    IO_EXPAND               =
**    io_tech_request_context =
**  IMPORTING
**    er_deep_entity          =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.

    DATA: ls_deep_entity TYPE zcl_zodata_idoc_nex_mpc_ext=>ts_deep_idoc_structure.

    " Read deep entity data
    io_data_provider->read_entry_data(
      IMPORTING
        es_data = ls_deep_entity
    ).

    DATA : lv_doc_num     TYPE edi_docnum,
           lt_idoc_data   TYPE edidd_tt,
           lt_open_data   TYPE edidd_tt,
           lt_idoc_status TYPE TABLE OF edi_ds40,
           lv_result      TYPE String.

    IF ls_deep_entity-document_number IS NOT INITIAL.
      lv_doc_num = ls_deep_entity-document_number.
    ENDIF.

    IF ls_deep_entity-headertoitem IS NOT INITIAL.
      lt_idoc_data = ls_deep_entity-headertoitem.
    ENDIF.

    CALL FUNCTION 'EDI_DOCUMENT_OPEN_FOR_EDIT'
      EXPORTING
        document_number               = lv_doc_num
      TABLES
        idoc_data                     = lt_open_data
      EXCEPTIONS
        document_foreign_lock         = 1
        document_not_exist            = 2
        document_not_open             = 3
        status_is_unable_for_changing = 4
        OTHERS                        = 5.

    IF sy-subrc <> 0.
      " Handle errors (same as before)
      CASE sy-subrc.
        WHEN 1.
          lv_result = |IDOC { lv_doc_num } is locked by another user|.
        WHEN 2.
          lv_result = |IDOC { lv_doc_num } does not exist|.
        WHEN 3.
          lv_result = |IDOC { lv_doc_num } is not open|.
        WHEN 4.
          lv_result = |IDOC { lv_doc_num } status prevents editing|.
        WHEN OTHERS.
          lv_result = |IDOC { lv_doc_num } cannot be opened|.
      ENDCASE.

    ELSE.

      CALL FUNCTION 'EDI_CHANGE_DATA_SEGMENTS'
        TABLES
          idoc_changed_data_range = lt_idoc_data
        EXCEPTIONS
          idoc_not_open           = 1
          data_record_not_exist   = 2
          OTHERS                  = 3.

      IF sy-subrc <> 0.

        CASE sy-subrc.
          WHEN 1.
            lv_result = |IDOC { lv_doc_num } not open|.
          WHEN 2.
            lv_result = |Data record does not exist in IDOC { lv_doc_num }|.
          WHEN OTHERS.
            lv_result = |IDOC { lv_doc_num } cannot be changed|.
        ENDCASE.

      ELSE.

        CALL FUNCTION 'EDI_DOCUMENT_CLOSE_EDIT'
          EXPORTING
            document_number = lv_doc_num
          TABLES
            status_records  = lt_idoc_status
          EXCEPTIONS
            idoc_not_open   = 1
            db_error        = 2
            OTHERS          = 3.

        IF sy-subrc <> 0.

          CASE sy-subrc.
            WHEN 1.
              lv_result = |IDOC { lv_doc_num } not open|.
            WHEN 2.
              lv_result = |Database error for IDOC { lv_doc_num }|.
            WHEN OTHERS.
              lv_result = |IDOC { lv_doc_num } cannot be closed|.
          ENDCASE.

        ELSE.

          lv_result = |IDOC { lv_doc_num } edited successfully|.

        ENDIF.

      ENDIF.

    ENDIF.

    ls_deep_entity-message = lv_result.

    " Copy to exporting parameter
    copy_data_to_ref(
      EXPORTING
        is_data = ls_deep_entity
      CHANGING
        cr_data = er_deep_entity
    ).

  ENDMETHOD.


  method MASS_EDITSET_GET_ENTITYSET.
**TRY.
*CALL METHOD SUPER->MASS_EDITSET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
  endmethod.


  method PROCESS_IDOCSET_CREATE_ENTITY.
**TRY.
*CALL METHOD SUPER->PROCESS_IDOCSET_CREATE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**    io_data_provider        =
**  IMPORTING
**    er_entity               =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.

    TYPES : BEGIN OF outtab,
              docnum(50),
              first_stat(50),
              curr_stat(50),
            END OF outtab.
    TYPES: BEGIN OF outtab_struc,
             docnum         TYPE edi_docnum,
             mestyp         TYPE edi_mestyp,
             status         TYPE edi_status,
             statusicon(60),
             statxt         TYPE edi_statxt,
           END OF outtab_struc.
    TYPES : BEGIN OF outtab_struc1,
              docnum TYPE edi_docnum,
              mestyp TYPE edi_mestyp,
              status TYPE edi_status,
              statxt TYPE edi_statxt,
            END OF outtab_struc1.
    TYPES : BEGIN OF outtab_strc3,
              message TYPE string,
            END OF outtab_strc3,
            BEGIN OF ts_process_idocs,
              document_number TYPE string,
              status      TYPE string,
            END OF ts_process_idocs .

    DATA  :it_selection TYPE TABLE OF rsparams,
           wa_selection LIKE LINE OF it_selection,
           ls_tab       TYPE outtab,
           ls_tab1      TYPE outtab_struc,
           ls_tab2      TYPE outtab_struc1,
           ls_tab3      TYPE outtab_strc3.
    DATA : ls_processidoc TYPE ts_process_idocs,
           lv_direction   TYPE edi_direct,
           lv_status      TYPE edi_status.

    DATA list_tab TYPE TABLE OF abaplist.
    FIELD-SYMBOLS  : <lt_pay_data>   TYPE ANY TABLE .
    FIELD-SYMBOLS : <lt_test> TYPE any . "LIKE LINE OF  it_tab .

    DATA lr_pay_data              TYPE REF TO data.

    DATA : ls_edids   TYPE edids,
           lv_message TYPE String,
           lv_idoc_no TYPE edi_docnum.

    io_data_provider->read_entry_data( IMPORTING es_data  = ls_processidoc  ).

    IF ls_processidoc-document_number IS INITIAL.
      er_entity-status = 'Idoc not received for Processing'.
    ELSE.
      er_entity-document_number  = |{ ls_processidoc-document_number ALPHA = OUT }|.
      SELECT SINGLE direct,status FROM edidc INTO (@lv_direction, @lv_status)
                            WHERE docnum = @ls_processidoc-document_number.
      IF lv_status = '51' OR lv_status = '52'.

        wa_selection-selname = 'SO_DOCNU'.
        wa_selection-kind    = 'S'.  "S-Select-options P-Parameters
        wa_selection-sign    = 'I'.
        wa_selection-option  = 'EQ'.
        wa_selection-low     = ls_processidoc-document_number.
        APPEND wa_selection TO it_selection.
        cl_salv_bs_runtime_info=>set(    EXPORTING display  = abap_false
                                                metadata = abap_false
                                                data     = abap_true ).
        SUBMIT rbdmani2    WITH SELECTION-TABLE it_selection
        " EXPORTING LIST TO MEMORY
          AND RETURN.
      ELSEIF lv_status = '64' OR lv_status = '66'.
        wa_selection-selname = 'DOCNUM'.
        wa_selection-kind    = 'S'.  "S-Select-options P-Parameters
        wa_selection-sign    = 'I'.
        wa_selection-option  = 'EQ'.
        wa_selection-low     = ls_processidoc-document_number.
        APPEND wa_selection TO it_selection.
        cl_salv_bs_runtime_info=>set(    EXPORTING display  = abap_false
                                                metadata = abap_false
                                                data     = abap_true ).
        SUBMIT  rbdapp01    WITH SELECTION-TABLE it_selection
        " EXPORTING LIST TO MEMORY
          AND RETURN.
      ELSEIF lv_status = '32' OR lv_status = '69'.
        wa_selection-selname = 'P_IDOC'.
        wa_selection-kind    = 'S'.  "S-Select-options P-Parameters
        wa_selection-sign    = 'I'.
        wa_selection-option  = 'EQ'.
        wa_selection-low     = ls_processidoc-document_number.
        APPEND wa_selection TO it_selection.

        wa_selection-selname = 'P_DIRECT'.
        wa_selection-kind    = 'S'. "S-Select-options P-Parameters
        wa_selection-sign    = 'I'.
        wa_selection-option  = 'EQ'.
        wa_selection-low     = lv_direction .
        APPEND wa_selection TO it_selection.

        cl_salv_bs_runtime_info=>set(    EXPORTING display  = abap_false
                                                   metadata = abap_false
                                                   data     = abap_true ).
        SUBMIT rbdagaie    WITH SELECTION-TABLE it_selection
        " EXPORTING LIST TO MEMORY
          AND RETURN.

      ELSEIF lv_status = '26'.
        wa_selection-selname = 'SO_DOCNU'.
        wa_selection-kind    = 'S'.  "S-Select-options P-Parameters
        wa_selection-sign    = 'I'.
        wa_selection-option  = 'EQ'.
        wa_selection-low     = ls_processidoc-document_number.
        APPEND wa_selection TO it_selection.

        wa_selection-selname = 'P_DIRECT'.
        wa_selection-kind    = 'S'. "S-Select-options P-Parameters
        wa_selection-sign    = 'I'.
        wa_selection-option  = 'EQ'.
        wa_selection-low     = lv_direction .
        APPEND wa_selection TO it_selection.

        cl_salv_bs_runtime_info=>set(    EXPORTING display  = abap_false
                                                   metadata = abap_false
                                                   data     = abap_true ).
        SUBMIT rbdsyner    WITH SELECTION-TABLE it_selection
        " EXPORTING LIST TO MEMORY
          AND RETURN.
      ELSEIF lv_status = '30'.
        wa_selection-selname = 'DOCNUM'.
        wa_selection-kind    = 'S'.  "S-Select-options P-Parameters
        wa_selection-sign    = 'I'.
        wa_selection-option  = 'EQ'.
        wa_selection-low     = ls_processidoc-document_number.
        APPEND wa_selection TO it_selection.
        cl_salv_bs_runtime_info=>set(    EXPORTING display  = abap_false
                                                metadata = abap_false
                                                data     = abap_true ).
        SUBMIT rseout00    WITH SELECTION-TABLE it_selection
          " EXPORTING LIST TO MEMORY
            AND RETURN.
      ELSEIF lv_status = '29'.

        wa_selection-selname = 'SO_DOCNU'.
        wa_selection-kind    = 'S'.  "S-Select-options P-Parameters
        wa_selection-sign    = 'I'.
        wa_selection-option  = 'EQ'.
        wa_selection-low     = ls_processidoc-document_number.
        APPEND wa_selection TO it_selection.
        cl_salv_bs_runtime_info=>set(    EXPORTING display  = abap_false
                                                metadata = abap_false
                                                data     = abap_true ).
        SUBMIT rbdagain    WITH SELECTION-TABLE it_selection
                  " EXPORTING LIST TO MEMORY
                    AND RETURN.
      ENDIF.

      TRY.
          cl_salv_bs_runtime_info=>get_data_ref( IMPORTING r_data = lr_pay_data ).
          ASSIGN lr_pay_data->* TO <lt_pay_data>.
        CATCH cx_salv_bs_sc_runtime_info.
          er_entity-status = 'Unable to process Idoc'.
          MESSAGE `Unable to retrieve ALV data` TYPE 'E'.
      ENDTRY.
      cl_salv_bs_runtime_info=>clear_all( ).

      lv_idoc_no  = |{ ls_processidoc-document_number ALPHA = IN }|.

      CALL FUNCTION 'EDI_DOCUMENT_OPEN_FOR_READ'
        EXPORTING
          document_number = lv_idoc_no.
      IF sy-subrc = 0.

        CALL FUNCTION 'EDI_DOCUMENT_READ_LAST_STATUS'
          EXPORTING
            document_number        = lv_idoc_no
          IMPORTING
            status                 = ls_edids
          EXCEPTIONS
            document_not_open      = 1
            no_status_record_found = 2
            OTHERS                 = 3.
        IF sy-subrc = 0.

          CALL FUNCTION 'MESSAGE_TEXT_BUILD'
            EXPORTING
              msgid               = ls_edids-stamid
              msgnr               = ls_edids-stamno
              msgv1               = ls_edids-stapa1
              msgv2               = ls_edids-stapa2
              msgv3               = ls_edids-stapa3
              msgv4               = ls_edids-stapa4
            IMPORTING
              message_text_output = lv_message.

          CALL FUNCTION 'EDI_DOCUMENT_CLOSE_READ'
            EXPORTING
              document_number = lv_idoc_no.

        ENDIF.

      ENDIF.

      IF <lt_pay_data> IS ASSIGNED.
        LOOP AT  <lt_pay_data> ASSIGNING <lt_test>.
          IF lv_status = '51' OR lv_status = '52' OR lv_status = '64'
             OR lv_status = '66' OR lv_status = '29'.
            MOVE-CORRESPONDING <lt_test> TO ls_tab1.
          ELSEIF  lv_status = '32' OR lv_status = '69'.
            MOVE-CORRESPONDING <lt_test> TO ls_tab.
          ELSEIF lv_status = '26'.
            MOVE-CORRESPONDING <lt_test> TO ls_tab2.
          ELSEIF lv_status = '30'.
            MOVE-CORRESPONDING <lt_test> TO ls_tab3.
          ENDIF.
        ENDLOOP.

        IF lv_status = '51' OR lv_status = '52' OR lv_status = '64'
           OR lv_status = '66' OR lv_status = '29'.
          er_entity-status_type = ls_edids-statyp.
          er_entity-status = ls_tab1-statxt.
          CONCATENATE er_entity-status '-' lv_message INTO er_entity-status SEPARATED BY space.
        ELSEIF lv_status = '32' OR lv_status = '69'.
          er_entity-status_type = ls_edids-statyp.
          er_entity-status = ls_tab-curr_stat.
          CONCATENATE er_entity-status '-' lv_message INTO er_entity-status SEPARATED BY space.
        ELSEIF lv_status = '26'.
          er_entity-status_type = ls_edids-statyp.
          er_entity-status = ls_tab2-statxt.
          CONCATENATE er_entity-status '-' lv_message INTO er_entity-status SEPARATED BY space.
        ELSEIF lv_status = '30'.
          er_entity-status_type = ls_edids-statyp.
          er_entity-status = ls_tab3-message.
          CONCATENATE er_entity-status '-' lv_message INTO er_entity-status SEPARATED BY space.
        ENDIF.

      ELSE.
        er_entity-status_type = 'W'.
        er_entity-status = 'Unable to process non-editable IDOC '.
        CONCATENATE er_entity-status '-' lv_message INTO er_entity-status SEPARATED BY space.

      ENDIF.
    ENDIF.

  endmethod.


  METHOD process_idocset_get_entityset.
**TRY.
*CALL METHOD SUPER->PROCESS_IDOCSET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
  ENDMETHOD.
ENDCLASS.
