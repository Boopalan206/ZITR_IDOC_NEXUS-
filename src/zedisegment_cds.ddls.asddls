@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'EDISEGMENT - CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@OData.publish: true
define view entity ZEDISEGMENT_CDS as select from edisegment
{
    key segtyp as Segtyp,
    qualifier as Qualifier,
    generated as Generated,
    presp as Presp,
    pwork as Pwork,
    plast as Plast,
    credate as Credate,
    cretime as Cretime,
    ldate as Ldate,
    ltime as Ltime
}
