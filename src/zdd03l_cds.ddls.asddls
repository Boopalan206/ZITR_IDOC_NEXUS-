@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DD03L - CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@OData.publish: true
define view entity ZDD03L_CDS as select from dd03l
{
    key tabname as Tabname,
    key fieldname as Fieldname,
    key as4local as As4local,
    key as4vers as As4vers,
    key position as Position1,
    keyflag as Keyflag,
    mandatory as Mandatory,
    rollname as Rollname,
    checktable as Checktable,
    inttype as Inttype,
    intlen as Intlen,
    reftable as Reftable,
    precfield as Precfield,
    reffield as Reffield,
    conrout as Conrout,
    notnull as Notnull,
    datatype as Datatype,
    leng as Leng,
    decimals as Decimals,
    domname as Domname,
    shlporigin as Shlporigin,
    tabletype as Tabletype,
    depth as Depth,
    comptype as Comptype,
    reftype as Reftype,
    languflag as Languflag,
    dbposition as Dbposition,
    anonymous as Anonymous,
    outputstyle as Outputstyle,
    srs_id as SrsId
}
