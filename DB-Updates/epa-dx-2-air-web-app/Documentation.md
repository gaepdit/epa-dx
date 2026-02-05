# ICIS-Air data exchange updates for the Air Web App

## Enforcement data elements

| Data element                      | Action | Complete | Tested |
|-----------------------------------|--------|:--------:|:------:|
| Case File                         | Insert |    ✓     |   ✓    |
| Case File                         | Update |    ✓     |   ✓    |
| Case File                         | Delete |    ✓     |   ✓    |
| Case File Air Violation codes     | Insert |    ✓     |   ✓    |
| Case File Air Violation codes     | Delete |    ✓     |   ✓    |
| Case File Program/Pollutant codes | Insert |    ✓     |   ✓    |
| Case File Program/Pollutant codes | Delete |    ✓     |   ✓    |
| Case File/CM Linkage              | Insert |    ✓     |   ✓    |
| Case File/CM Linkage              | Delete |    ✓     |   ✓    |
| Enforcement Action - Formal       | Insert |    ✓     |   ✓    |
| Enforcement Action - Formal       | Update |    ✓     |   ✓    |
| Enforcement Action - Informal     | Insert |    ✓     |   ✓    |
| Enforcement Action - Informal     | Update |    ✓     |   ✓    |
| Enforcement Action                | Delete |    ✓     |   ✓    |
| EA Facility                       | Insert |    ✓     |   x    |
| Case File/EA Linkage              | Insert |    ✓     |   x    |
| EA Program/Pollutant codes        | Insert |    ✓     |   x    |
| EA Program/Pollutant codes        | Delete |    ✓     |   x    |
| EA Type code                      | Insert |    ✓     |   x    |
| Final Orders                      | Insert |    ✓     |   x    |
| Final Orders                      | Update |    ✓     |   x    |
| Final Order Facility              | Insert |    ✓     |   x    |
| AO Milestones                     | Insert |    ✓     |   x    |
| AO Milestones                     | Update |    ✓     |   x    |
| AO Milestones                     | Delete |    ✓     |   x    |
| NFA Pathway Activities            | Insert |    ✓     |   x    |
| NFA Pathway Activities            | Delete |    ✓     |   x    |

## Compliance Monitoring data elements

| Data element                        | Action | Complete | Tested |
|-------------------------------------|--------|:--------:|:------:|
| Compliance Monitoring               | Insert |    ✓     |   ✓    |
| Compliance Monitoring               | Update |    ✓     |   ✓    |
| Compliance Monitoring               | Delete |    ✓     |   ✓    |
| Compliance Monitoring FCE           | Insert |    ✓     |   ✓    |
| Compliance Monitoring FCE           | Update |    ✓     |   ✓    |
| Compliance Monitoring FCE           | Delete |    ✓     |   ✓    |
| Compliance Monitoring Program Codes | Insert |    ✓     |   ✓    |
| Compliance Monitoring Program Codes | Delete |    ✓     |   ✓    |
| Compliance Monitoring ACC data      | Insert |    ✓     |   ✓    |
| Compliance Monitoring ACC data      | Update |    ✓     |   ✓    |
| IAIP stack test data                | Insert |    ✓     |   ✓    |
| IAIP stack test data                | Update |    ✓     |   x    |
| IAIP stack test data                | Delete |    ✓     |   ✓    |

## Old DB objects to review

| Done | Repo        | Database object                                                        | Type    | Modification |
|:----:|-------------|------------------------------------------------------------------------|---------|--------------|
|  ✓   | `airbranch` | `AIRBRANCH.dbo.ICIS_CASEFILE_CODES / TG_ICIS_CASEFILE_CODES`           | Trigger | Obsolete     |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.ISMPREPORTINFORMATION / TG_ICIS_ISMPREPORTINFORMATION`  | Trigger | Refactor     |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.ISMPREPORTINFORMATION / TG_ISMPREPORTINFORMATION_DEL`   | Trigger | Refactor     |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.SSCP_AUDITEDENFORCEMENT / TG_ICIS_CASEFILE`             | Trigger | Obsolete     |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.SSCP_AUDITEDENFORCEMENT / TG_SSCP_AUDITEDENFORCEMENT`   | Trigger | Obsolete     |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.SSCP_EnforcementEvents / TG_SSCP_EnforcementEvents_DEL` | Trigger | Obsolete     |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.SSCPACCS / TG_ICIS_SSCPACCS`                            | Trigger | Obsolete     |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.SSCPFCE / TG_AFS_FCE`                                   | Trigger | Obsolete     |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.SSCPFCE / TG_ICIS_SSCPFCE`                              | Trigger | Obsolete     |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.SSCPFCEMASTER / TG_ICIS_SSCPFCEMASTER`                  | Trigger | Obsolete     |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.SSCPFCEMASTER / TG_SSCPFCEMASTER_DEL`                   | Trigger | Obsolete     |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.SSCPINSPECTIONS / TG_ICIS_SSCPINSPECTIONS`              | Trigger | Obsolete     |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.SSCPITEMMASTER / TG_ICIS_SSCPITEMMASTER`                | Trigger | Obsolete     |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.SSCPITEMMASTER / TG_SSCPITEMMASTER_DEL`                 | Trigger | Obsolete     |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.SSCPTESTREPORTS / TG_ICIS_SSCPTESTREPORTS`              | Trigger | Obsolete     |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.VW_ICIS_CASEFILE`                                       | View    | Rewrite      |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.VW_ICIS_COMPLIANCEMONITORING`                           | View    | Rewrite      |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.VW_ICIS_ENFORCEMENTACTION`                              | View    | Rewrite      |
|  ✓   | `airbranch` | `AIRBRANCH.dbo.VW_ICIS_ID_REFERENCE`                                   | View    | Rewrite      |
|  ✓   | `airbranch` | `AIRBRANCH.iaip_facility.TriggerDataUpdateAtEPA`                       | Proc    | Rewrite      |
|  ✓   | `epa-dx`    | `AIRBRANCH.etl.ICIS_CASEFILE_DELETE`                                   | Proc    | Rewrite      |
|  ✓   | `epa-dx`    | `AIRBRANCH.etl.ICIS_CASEFILE_UPDATE`                                   | Proc    | Rewrite      |
|  ✓   | `epa-dx`    | `AIRBRANCH.etl.ICIS_CF2CM_DELETE`                                      | Proc    | Rewrite      |
|  ✓   | `epa-dx`    | `AIRBRANCH.etl.ICIS_CM_DELETE`                                         | Proc    | Rewrite      |
|  ✓   | `epa-dx`    | `AIRBRANCH.etl.ICIS_CM_UPDATE`                                         | Proc    | Rewrite      |
|  ✓   | `epa-dx`    | `AIRBRANCH.etl.ICIS_EAMILESTONE_DELETE`                                | Proc    | Rewrite      |

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
