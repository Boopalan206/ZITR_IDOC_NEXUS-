@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'EDIDC - CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@OData.publish: true
define view entity ZEDIDC_CDS as select from edidc
{
    key docnum as Docnum,
    docrel as Docrel,
    status as Status,
    doctyp as Doctyp,
    direct as Direct,
    rcvpor as Rcvpor,
    rcvprt as Rcvprt,
    rcvprn as Rcvprn,
    rcvsad as Rcvsad,
    rcvsmn as Rcvsmn,
    rcvsna as Rcvsna,
    rcvsca as Rcvsca,
    rcvsdf as Rcvsdf,
    rcvslf as Rcvslf,
    rcvlad as Rcvlad,
    std as Std,
    stdvrs as Stdvrs,
    stdmes as Stdmes,
    mescod as Mescod,
    mesfct as Mesfct,
    outmod as Outmod,
    test as Test,
    sndpor as Sndpor,
    sndprt as Sndprt,
    sndprn as Sndprn,
    sndsad as Sndsad,
    sndsmn as Sndsmn,
    sndsna as Sndsna,
    sndsca as Sndsca,
    sndsdf as Sndsdf,
    sndslf as Sndslf,
    sndlad as Sndlad,
    refint as Refint,
    refgrp as Refgrp,
    refmes as Refmes,
    arckey as Arckey,
    credat as Credat,
    cretim as Cretim,
    mestyp as Mestyp,
    idoctp as Idoctp,
    cimtyp as Cimtyp,
    rcvpfc as Rcvpfc,
    sndpfc as Sndpfc,
    serial as Serial,
    exprss as Exprss,
    upddat as Upddat,
    updtim as Updtim,
    maxsegnum as Maxsegnum
}
