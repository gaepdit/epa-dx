 -- USE AirWeb
USE AIRBRANCH
GO

CREATE OR ALTER FUNCTION etl.EpaActionId
(
    @airs         varchar(12),
    @actionNumber int
)
    RETURNS varchar(25)
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   Formats an AIRS number and Action Number as an EPA ICIS-Air Compliance Monitoring ID.

Input Parameters:
  @airs - The input AIRS number in either 12-character (041300100001) or
          8-character (00100001) format
  @actionNumber - The Action Number

  Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2026-01-20  DWaldron            Initial Version (epa-id#2)
2026-04-17  DWaldron            Add to both AirWeb and AIRBRANCH DBs to avoid permissions issues (iaip#1464)

***************************************************************************************************/

BEGIN

    if @actionNumber is null or @actionNumber = 0
        return 'ERROR';

    if len(@airs) in (8, 12)
        return concat('GA000A000013', right(@airs, 8), right(concat('00000', @actionNumber), 5));

    if len(@airs) = 9
        return concat('GA000A000013', left(@airs, 3), right(@airs, 5), right(concat('00000', @actionNumber), 5));

    return 'ERROR';

END
