@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'EDIDS - CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@OData.publish: true
define view entity ZEDIDS_CDS as select from edids
       left outer join t100 as T100
       on edids.stamid = T100.arbgb
       and edids.stamno = T100.msgnr
       and T100.sprsl = $session.system_language
{
    key edids.docnum as Docnum,
    key edids.logdat as Logdat,
    key edids.logtim as Logtim,
    key edids.countr as Countr,
    key t100.sprsl as Sprsl,
    key t100.arbgb as Arbgb,
    key t100.msgnr as Msgnr,
    edids.credat as Credat,
    edids.cretim as Cretim,
    edids.status as Status,
    edids.uname as Uname,
    edids.repid as Repid,
    edids.routid as Routid,
    edids.stacod as Stacod,
    edids.statxt as Statxt,
    edids.segnum as Segnum,
    edids.segfld as Segfld,
    edids.stapa1 as Stapa1,
    edids.stapa2 as Stapa2,
    edids.stapa3 as Stapa3,
    edids.stapa4 as Stapa4,
    edids.statyp as Statyp,
    edids.stamqu as Stamqu,
    edids.stamid as Stamid,
    edids.stamno as Stamno,
    edids.tid as Tid,
    edids.appl_log as ApplLog,
    edids._dataaging as Dataaging,
    t100.text as Text
}
