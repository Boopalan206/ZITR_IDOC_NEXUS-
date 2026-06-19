@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'EDIMSGT - CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@OData.publish: true
define view entity ZEDIMSGT_CDS as select from edimsgt
{
    key langua as Langua,
    key mestyp as Mestyp,
    descrp as Descrp
} where langua = $session.system_language
