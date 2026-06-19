@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TEDS2 - CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@OData.publish: true
define view entity ZTEDS2_CDS as select from teds2
{
    key status as Status,
    key langua as Langua,
    descrp as Descrp
} where langua = $session.system_language
