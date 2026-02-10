<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v1="http://www.exchangenetwork.net/schema/dataset/2" exclude-result-prefixes="v1"
>
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:template match="/">
       <xsl:apply-templates select="/v1:DataSet"/>
    </xsl:template>
    <xsl:template match="v1:DataSet">
		<xsl:for-each select="v1:record[not(self::v1:TransactionID=following-sibling::v1:TransactionID)]">
		<xsl:variable name="TransactionID" select="v1:TransactionID"/>
		<AirComplianceMonitoringStrategyData xmlns="http://www.exchangenetwork.net/schema/icis/5">
			<TransactionHeader>
				<TransactionType>X</TransactionType>
				<TransactionTimestamp>
					<xsl:value-of select="v1:TransactionTimestamp" />
				</TransactionTimestamp>
			</TransactionHeader>
			<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][not(self::v1:AirFacilityID=following-sibling::v1:AirFacilityID)]">
			<AirComplianceMonitoringStrategy>
				<AirFacilityIdentifier>
					<xsl:value-of select="v1:AirFacilityID" />
				</AirFacilityIdentifier>
             </AirComplianceMonitoringStrategy>
			 </xsl:for-each>
        </AirComplianceMonitoringStrategyData>
		</xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
