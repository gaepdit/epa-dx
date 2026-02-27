<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v1="http://www.exchangenetwork.net/schema/dataset/2" exclude-result-prefixes="v1"
>
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:template match="/">
       <xsl:apply-templates select="/v1:DataSet"/>
    </xsl:template>
    <xsl:template match="v1:DataSet">
		<xsl:for-each select="v1:record[not(self::v1:record/v1:TransactionID=following-sibling::v1:record/v1:TransactionID)]">
			<xsl:variable name="TransactionID" select="v1:TransactionID"/>
		<AirDAEnforcementActionMilestoneData xmlns="http://www.exchangenetwork.net/schema/icis/5">
			<TransactionHeader>
				<TransactionType>R</TransactionType>
				<TransactionTimestamp>
					<xsl:value-of select="v1:TransactionTimestamp" />
				</TransactionTimestamp>
			</TransactionHeader>
			<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][not(self::v1:record/v1:EnforcementActionMilestoneId=following-sibling::v1:record/v1:EnforcementActionMilestoneId)]">
			<AirDAEnforcementActionMilestone>
					<AirDAEnforcementActionIdentifier>
						<xsl:value-of select="v1:EnforcementActionId" />
					</AirDAEnforcementActionIdentifier>
					<MilestoneTypeCode>
						<xsl:value-of select="v1:Type" />
					</MilestoneTypeCode>
					<xsl:if test="v1:MilestonePlannedDate!= ''" >
					<MilestonePlannedDate>
						<xsl:value-of select="v1:MilestonePlannedDate" />
					</MilestonePlannedDate>
					</xsl:if>
					<xsl:if test="v1:MilestoneActualDate!= ''" >
					<MilestoneActualDate>
						<xsl:value-of select="v1:MilestoneActualDate" />
					</MilestoneActualDate>
					</xsl:if>
            </AirDAEnforcementActionMilestone>
				</xsl:for-each>
        </AirDAEnforcementActionMilestoneData>
		</xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
