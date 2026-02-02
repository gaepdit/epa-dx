USE NETWORKNODEFLOW;
GO

SET NOCOUNT ON;

EXEC sp_MSForEachTable
     @command1 = 'Alter Table ? NoCheck Constraint All';

PRINT '-- Table constraints disabled';

EXEC sp_MSForEachTable
     @command1 = '
	   If ObjectProperty(Object_ID(''?''), ''TableHasForeignRef'')=1
		  Begin
			 -- Just to know what all table used delete syntax.
			 Print ''-- Data deleted: '' + ''?''
			 Delete From ?
		  End
	   Else
		  Begin
			 -- Just to know what all table used Truncate syntax.
			 Print ''-- Table truncated: '' + ''?''
			 Truncate Table ?
		  End'
   , @whereand = ' AND o.id IN
	   (
		  SELECT object_id
		  FROM   sys.tables
		  WHERE  name NOT LIKE ''CERS_%''
	   )';

EXEC sp_MSForEachTable
     @command1 = 'Alter Table ? WITH CHECK Check Constraint All';

PRINT '-- Table constraints enabled';