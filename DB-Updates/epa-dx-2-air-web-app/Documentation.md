# ICIS-Air data exchange updates for the Air Web App

## Data elements

| Category              | Data element                      | Action | Complete | Tested |
|-----------------------|-----------------------------------|--------|:--------:|:------:|
| Case File             | Case File                         | Insert |    ✓     |        |
| Case File             | Case File                         | Update |    ✓     |        |
| Case File             | Case File                         | Delete |          |        |
| Case File             | Case File Air Violation codes     | Insert |    ✓     |        |
| Case File             | Case File Air Violation codes     | Delete |    ✓     |        |
| Case File             | Case File Program/Pollutant codes | Insert |    ✓     |        |
| Case File             | Case File Program/Pollutant codes | Delete |    ✓     |        |
| Case File             | Case File/CM Linkage              | Insert |    ✓     |        |
| Case File             | Case File/CM Linkage              | Delete |    ✓     |        |
| Enforcement Action    | Enforcement Action - Formal       | Insert |    ✓     |        |
| Enforcement Action    | Enforcement Action - Formal       | Update |    ✓     |        |
| Enforcement Action    | Enforcement Action - Formal       | Delete |          |        |
| Enforcement Action    | Enforcement Action - Informal     | Insert |    ✓     |        |
| Enforcement Action    | Enforcement Action - Informal     | Update |    ✓     |        |
| Enforcement Action    | Enforcement Action - Informal     | Delete |          |        |
| Enforcement Action    | EA Facility                       | Insert |    ✓     |        |
| Enforcement Action    | Case File/EA Linkage              | Insert |    ✓     |        |
| Enforcement Action    | EA Program/Pollutant codes        | Insert |    ✓     |        |
| Enforcement Action    | EA Program/Pollutant codes        | Delete |    ✓     |        |
| Enforcement Action    | EA Type code                      | Insert |    ✓     |        |
| Enforcement Action    | Final Orders                      | Insert |    ✓     |        |
| Enforcement Action    | Final Orders                      | Update |    ✓     |        |
| Enforcement Action    | Final Orders                      | Delete |          |        |
| Enforcement Action    | Final Order Facility              | Insert |    ✓     |        |
| Enforcement Action    | AO Milestones                     | Insert |    ✓     |        |
| Enforcement Action    | AO Milestones                     | Update |    ✓     |        |
| Enforcement Action    | AO Milestones                     | Delete |          |        |
| Enforcement Action    | NFA Pathway Activities            | Insert |    ✓     |        |
| Enforcement Action    | NFA Pathway Activities            | Delete |    ✓     |        |
| Compliance Monitoring | Compliance Monitoring             | Insert |          |        |
| Compliance Monitoring | Compliance Monitoring             | Update |          |        |
| Compliance Monitoring | Compliance Monitoring             | Delete |          |        |
| Compliance Monitoring | IAIP stack test                   | Insert |          |        |
| Compliance Monitoring | IAIP stack test                   | Update |          |        |
| Compliance Monitoring | IAIP stack test                   | Delete |          |        |

## Old DB objects to review

| Done | Repo        | Database object                                                        | Type    | Modification |
|:----:|-------------|------------------------------------------------------------------------|---------|--------------|
|  ✔   | `air-web`   | `AIRBRANCH.air.GetIaipFacilityNextActionNumber`                        | Proc    | New          |
|  ✔   | `airbranch` | `AIRBRANCH.dbo.ICIS_CASEFILE_CODES / TG_ICIS_CASEFILE_CODES`           | Trigger | Obsolete     |
|      | `airbranch` | `AIRBRANCH.dbo.ISMPREPORTINFORMATION / TG_ICIS_ISMPREPORTINFORMATION`  | Trigger | Refactor     |
|  ✔   | `airbranch` | `AIRBRANCH.dbo.ISMPREPORTINFORMATION / TG_ISMPREPORTINFORMATION_DEL`   | Trigger | Refactor     |
|  ✔   | `airbranch` | `AIRBRANCH.dbo.SSCP_AUDITEDENFORCEMENT / TG_ICIS_CASEFILE`             | Trigger | Obsolete     |
|  ✔   | `airbranch` | `AIRBRANCH.dbo.SSCP_AUDITEDENFORCEMENT / TG_SSCP_AUDITEDENFORCEMENT`   | Trigger | Obsolete     |
|  ✔   | `airbranch` | `AIRBRANCH.dbo.SSCP_EnforcementEvents / TG_SSCP_EnforcementEvents_DEL` | Trigger | Obsolete     |
|  ✔   | `airbranch` | `AIRBRANCH.dbo.SSCPACCS / TG_ICIS_SSCPACCS`                            | Trigger | Obsolete     |
|  ✔   | `airbranch` | `AIRBRANCH.dbo.SSCPFCE / TG_AFS_FCE`                                   | Trigger | Obsolete     |
|  ✔   | `airbranch` | `AIRBRANCH.dbo.SSCPFCE / TG_ICIS_SSCPFCE`                              | Trigger | Obsolete     |
|  ✔   | `airbranch` | `AIRBRANCH.dbo.SSCPFCEMASTER / TG_ICIS_SSCPFCEMASTER`                  | Trigger | Obsolete     |
|  ✔   | `airbranch` | `AIRBRANCH.dbo.SSCPFCEMASTER / TG_SSCPFCEMASTER_DEL`                   | Trigger | Obsolete     |
|  ✔   | `airbranch` | `AIRBRANCH.dbo.SSCPINSPECTIONS / TG_ICIS_SSCPINSPECTIONS`              | Trigger | Obsolete     |
|  ✔   | `airbranch` | `AIRBRANCH.dbo.SSCPITEMMASTER / TG_ICIS_SSCPITEMMASTER`                | Trigger | Obsolete     |
|  ✔   | `airbranch` | `AIRBRANCH.dbo.SSCPITEMMASTER / TG_SSCPITEMMASTER_DEL`                 | Trigger | Obsolete     |
|  ✔   | `airbranch` | `AIRBRANCH.dbo.SSCPTESTREPORTS / TG_ICIS_SSCPTESTREPORTS`              | Trigger | Obsolete     |
|  ✔   | `airbranch` | `AIRBRANCH.dbo.VW_ICIS_CASEFILE`                                       | View    | Rewrite      |
|      | `airbranch` | `AIRBRANCH.dbo.VW_ICIS_COMPLIANCEMONITORING`                           | View    | Rewrite      |
|  ✔   | `airbranch` | `AIRBRANCH.dbo.VW_ICIS_ENFORCEMENTACTION`                              | View    | Rewrite      |
|  ✔   | `airbranch` | `AIRBRANCH.dbo.VW_ICIS_ID_REFERENCE`                                   | View    | Rewrite      |
|  ✔   | `airbranch` | `AIRBRANCH.iaip_facility.TriggerDataUpdateAtEPA`                       | Proc    | Rewrite      |
|      | `epa-dx`    | `AIRBRANCH.etl.ICIS_CASEFILE_DELETE`                                   | Proc    | Rewrite      |
|  ✔   | `epa-dx`    | `AIRBRANCH.etl.ICIS_CASEFILE_UPDATE`                                   | Proc    | Rewrite      |
|      | `epa-dx`    | `AIRBRANCH.etl.ICIS_CF2CM_DELETE`                                      | Proc    | Rewrite      |
|      | `epa-dx`    | `AIRBRANCH.etl.ICIS_CM_DELETE`                                         | Proc    | Rewrite      |
|      | `epa-dx`    | `AIRBRANCH.etl.ICIS_CM_UPDATE`                                         | Proc    | Rewrite      |
|      | `epa-dx`    | `AIRBRANCH.etl.ICIS_EAMILESTONE_DELETE`                                | Proc    | Rewrite      |

## Obsolete DB tables

* `AFSISMPRECORDS`
* `AFSSSCPFCERECORDS`
* `AFSSSCPRECORDS`
* `ICIS_CASEFILE_CODES`
* `LK_VIOLATION_TYPE`
* `LOOKUPCOMPLIANCEACTIVITIES`
* `LOOKUPSSCPNOTIFICATIONS`
* `SSCP_AUDITEDENFORCEMENT`
* `SSCP_ENFORCEMENT`
* `SSCP_EnforcementEvents`
* `SSCPACCS`
* `SSCPACCSHISTORY`
* `SSCPENFORCEMENTSTIPULATED`
* `SSCPFCE`
* `SSCPFCEMASTER`
* `SSCPINSPECTIONS`
* `SSCPITEMMASTER`
* `SSCPNOTIFICATIONS`
* `SSCPREPORTS`
* `SSCPREPORTSHISTORY`
* `SSCPTESTREPORTS`
