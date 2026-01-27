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
		<AirProgramsData xmlns="http://www.exchangenetwork.net/schema/icis/5">
			<TransactionHeader>
				<TransactionType>
					<xsl:value-of select="v1:TransactionType" />
				</TransactionType>
				<TransactionTimestamp>
					<xsl:value-of select="v1:TransactionTimestamp" />
				</TransactionTimestamp>
			</TransactionHeader>
			<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][not(self::v1:record/v1:AirProgramID=following-sibling::v1:record/v1:AirProgramID)]">
			<xsl:variable name="AirProgramID" select="v1:AirProgramID"/>
			<AirPrograms>
					<AirFacilityIdentifier>
						<xsl:value-of select="v1:AirFacilityID" />
					</AirFacilityIdentifier>
					<AirProgramCode>
						<xsl:value-of select="v1:AirProgramCode" />
					</AirProgramCode>
					<xsl:if test="v1:OtherAirProgramText != ''">
					<OtherProgramDescriptionText>
						<xsl:value-of select="v1:OtherAirProgramText" />
					</OtherProgramDescriptionText>
					</xsl:if>
					<xsl:if test="v1:AirProgramOperatingStatusCode != ''">
					<AirProgramOperatingStatusData>
						<AirProgramOperatingStatusCode>
							<xsl:value-of select="v1:AirProgramOperatingStatusCode" />
						</AirProgramOperatingStatusCode>
						<xsl:if test="v1:AirProgramOperatingStatusStartDate != ''">
						<AirProgramOperatingStatusStartDate>
							<xsl:value-of select="v1:AirProgramOperatingStatusStartDate" />
						</AirProgramOperatingStatusStartDate>
						</xsl:if>
					</AirProgramOperatingStatusData>
					</xsl:if>
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:AirProgramID=$AirProgramID][not(self::v1:record/v1:AirProgramSubpartID=following-sibling::v1:record/v1:AirProgramSubpartID)]">
					<xsl:if test="v1:AirProgramSubpartCode != ''">
					<AirProgramSubpartData>
						<AirProgramSubpartCode>
							<xsl:value-of select="v1:AirProgramSubpartCode" />
						</AirProgramSubpartCode>
						<xsl:if test="v1:AirProgramSubpartStatusIndicator != ''">
						<AirProgramSubpartStatusIndicator>
							<xsl:value-of select="v1:AirProgramSubpartStatusIndicator" />
						</AirProgramSubpartStatusIndicator>
						</xsl:if>
					</AirProgramSubpartData>
					</xsl:if>
					</xsl:for-each>
                </AirPrograms>
				</xsl:for-each>
        </AirProgramsData>
		</xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
