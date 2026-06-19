@EndUserText.label: 'EDID4 - Table Function'
@ClientHandling.type: #CLIENT_INDEPENDENT
define table function ZEDID4_TF
returns {
  docnum   : edi_docnum;
  counter  : edi_cimtyp;
  segnum   : edi_segnum;
  segnam   : edi_segnam;
  psgnum   : edi_psgnum;
  hlevel   : edi_hlevel;
  dataaging: timestamp;
  dtint2   : edi_dtint2;
  sdata    : abap.char(1000);
}
implemented by method zcl_edid4_tf=>get_data;
