@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MASS UPDATE FIELD - CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@OData.publish: true
define view entity ZMASSUPDATE_CDS as select from idocsyn as syn
    left outer join edisegt as seg_desc
        on syn.segtyp = seg_desc.segtyp
        and seg_desc.langua = $session.system_language
    left outer join edsappl as fld
        on syn.segtyp = fld.segtyp
    left outer join dd04t as fld_desc
        on fld.rollname = fld_desc.rollname
        and fld_desc.ddlanguage = $session.system_language
    left outer join dd03l as domain
        on domain.tabname = syn.segtyp
        and domain.rollname = fld.rollname
    left outer join dd07t as fld_val
        on fld_val.domname = domain.domname
        and fld_val.ddlanguage = $session.system_language
    left outer join edisegment as edisegment
        on edisegment.segtyp = syn.segtyp
{
  key syn.idoctyp    as BasicType,
  key syn.segtyp     as Segment,
  seg_desc.descrp as Segment_desc,
  fld.fieldname as Field,
  fld_desc.ddtext as Field_desc,
  fld_val.domvalue_l as field_value,
  fld_val.ddtext as field_val_desc,
  fld.pos as Table_Position,
  edisegment.qualifier as qualifier
 }
