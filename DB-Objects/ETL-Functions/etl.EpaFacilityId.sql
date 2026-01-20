USE AirWeb
GO

CREATE OR ALTER FUNCTION etl.EpaFacilityId
(
    @airs varchar(12)
)
    RETURNS varchar(18)
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   Formats an AIRS number as an EPA ICIS-Air facility ID.

Input Parameters:
  @airs - The input AIRS number in either 12-character (041300100001) or
          8-character (00100001) format

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2026-01-23  DWaldron            Initial Version (epa-id#2)

***************************************************************************************************/

BEGIN

    if len(@airs) in (8, 12)
        return concat('GA00000013', right(@airs, 8))

    if len(@airs) = 9
        return concat('GA00000013', left(@airs, 3), right(@airs, 5))

    return 'ERROR';

END
