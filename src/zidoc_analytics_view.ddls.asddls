@AbapCatalog.sqlViewName: 'ZZIDOC_ANALYTICS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Analytical view for IDoc'
@Metadata.ignorePropagatedAnnotations: true
@OData.publish: true
@Search.searchable: true
define view ZIDOC_ANALYTICS_VIEW
  as select from zidoc_analytics
{
      @EndUserText.label: 'IDoc_Number'
      @UI.hidden: true
      @UI.lineItem: [{ position: 10, label: 'IDoc Number' }]
      @Search.defaultSearchElement: true
  key idoc_number          as IdocNumber,

      @EndUserText.label: 'Year'
      @UI.lineItem: [{ position: 15, label: 'Year' }]
  key idoc_year            as IdocYear,

      @EndUserText.label: 'Month'
      @UI.lineItem: [{ position: 20, label: 'Month' }]
      @Search.defaultSearchElement: true
  key idoc_month           as IdocMonth,

      @EndUserText.label: 'Create Date'
      @UI.lineItem: [{ position: 25, label: 'Create Date' }]
      credat               as Credat,

      @EndUserText.label: 'Customer'
      @UI.lineItem: [{ position: 30, label: 'Customer' }]
      @Search.defaultSearchElement: true
      customername         as Customername,

      @EndUserText.label: 'Month-Year'
      @UI.lineItem: [{ position: 35, label: 'IDoc Number' }]
      monthyear            as Monthyear,

      @EndUserText.label: 'Delayed Value'
      @UI.lineItem: [{ position: 40, label: 'Month - Year' }]
      @DefaultAggregation: #SUM
      idoc_delayed         as IdocDelayed,

      @EndUserText.label: 'Total Value'
      @UI.lineItem: [{ position: 45, label: 'Total Value' }]
      @DefaultAggregation: #SUM
      total_value          as TotalValue,

      @EndUserText.label: 'Avg Days Delayed'
      @UI.lineItem: [{ position: 50, label: 'Avg Days Delayed' }]
      @DefaultAggregation: #AVG
      average_days_delayed as AverageDaysDelayed,

      @EndUserText.label: 'Reason'
      @UI.lineItem: [{ position: 55, label: 'Reason' }]
      reason               as Reason,

      @EndUserText.label: 'Reason Desc'
      @UI.lineItem: [{ position: 60, label: 'Reason Desc' }]
      reason_text          as ReasonText,

      @EndUserText.label: 'Basic Type'
      @UI.lineItem: [{ position: 65, label: 'Basic Type' }]
      idoc_type            as IdocType,

      @EndUserText.label: 'Message Type'
      @UI.lineItem: [{ position: 70, label: 'Message Type' }]
      @Search.defaultSearchElement: true
      message_type         as MessageType
}
