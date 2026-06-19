@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'EDID4 - CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@OData.publish: true
define view entity ZEDID4_CDS as select from ZEDID4_TF
{
    key docnum as Docnum,
    key counter as Counter,
    key segnum as Segnum,
    segnam as Segnam,
    psgnum as Psgnum,
    hlevel as Hlevel,
    dataaging as Dataaging,
    dtint2 as Dtint2,
    sdata as Sdata
}
