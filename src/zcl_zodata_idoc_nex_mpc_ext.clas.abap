class ZCL_ZODATA_IDOC_NEX_MPC_EXT definition
  public
  inheriting from ZCL_ZODATA_IDOC_NEX_MPC
  create public .

public section.

  methods DEFINE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ZODATA_IDOC_NEX_MPC_EXT IMPLEMENTATION.


  method DEFINE.

    DATA lo_entity_type TYPE REF TO /iwbep/if_mgw_odata_entity_typ.
    super->define( ).
* Header Entity Name
    lo_entity_type = model->get_entity_type( iv_entity_name = 'Mass_Edit' ).

* MPC_EXT Deep Structure Name
    lo_entity_type->bind_structure( iv_structure_name = 'ZCL_ZODATA_IDOC_NEX_MPC_EXT=>TS_DEEP_IDOC_STRUCTURE' ).

  endmethod.
ENDCLASS.
