@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'zidoc_analytics - CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@OData.publish: true

define root view entity zidoc_analytics_cds as select from zidoc_analytics
{
    key idoc_number as IdocNumber,
    key idoc_year as IdocYear,
    key idoc_month as IdocMonth,
    credat as Credat,
    customername as Customername,
    monthyear as Monthyear,
    idoc_delayed as IdocDelayed,
    total_value as TotalValue,
    average_days_delayed as AverageDaysDelayed,
    reason as Reason,
    reason_text as ReasonText,
    idoc_type as IdocType,
    message_type as MessageType
}

