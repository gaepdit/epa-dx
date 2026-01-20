USE airbranch;
GO
SET ANSI_NULLS ON;
GO

CREATE OR ALTER VIEW etl.VW_AirProgramsWithSubparts
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   Lists distinct ICIS-Air Air Program codes with subparts in
            LK_ICIS_PROGRAM_SUBPART. Used in the facility update script to
            segregate Air Programs with and without subparts

Tables accessed:
    LK_ICIS_PROGRAM_SUBPART

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2020-02-03  DWaldron            Initial Version

***************************************************************************************************/

select distinct ICIS_PROGRAM_CODE
from LK_ICIS_PROGRAM_SUBPART;

GO
