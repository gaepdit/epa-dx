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
		<AirPollutantsData xmlns="http://www.exchangenetwork.net/schema/icis/5">
			<TransactionHeader>
				<TransactionType>X</TransactionType>
				<TransactionTimestamp>
					<xsl:value-of select="v1:TransactionTimestamp" />
				</TransactionTimestamp>
			</TransactionHeader>
			<xsl:for-each select="//v1:record[not(self::v1:AirPollutantsCode=following-sibling::v1:AirPollutantsCode)][v1:TransactionID=$TransactionID]">
            <AirPollutants>
					<AirFacilityIdentifier>
						<xsl:value-of select="v1:AirFacilityID" />
					</AirFacilityIdentifier>
					<AirPollutantsCode>
						<xsl:value-of select="v1:AirPollutantsCode" />
					</AirPollutantsCode>
            </AirPollutants>
			</xsl:for-each>
        </AirPollutantsData>
		</xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
