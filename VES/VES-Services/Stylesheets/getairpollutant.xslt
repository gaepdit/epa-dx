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
				<TransactionType>
					<xsl:value-of select="v1:TransactionType" />
				</TransactionType>
				<TransactionTimestamp>
					<xsl:value-of select="v1:TransactionTimestamp" />
				</TransactionTimestamp>
			</TransactionHeader>
			<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][not(self::v1:record/v1:AirPollutantID=following-sibling::v1:record/v1:AirPollutantID)]">
			<AirPollutants>
					<AirFacilityIdentifier>
						<xsl:value-of select="v1:AirFacilityID" />
					</AirFacilityIdentifier>
					<AirPollutantsCode>
						<xsl:value-of select="v1:AirPollutantsCode" />
					</AirPollutantsCode>
					<xsl:if test="v1:AirPollutantStatusIndicator != ''">
					<AirPollutantStatusIndicator>
						<xsl:value-of select="v1:AirPollutantStatusIndicator" />
					</AirPollutantStatusIndicator>
					</xsl:if>
					<xsl:if test="v1:AirPollutantEPAClassificationCode != ''">
					<AirPollutantEPAClassificationData>
						<AirPollutantEPAClassificationCode>
							<xsl:value-of select="v1:AirPollutantEPAClassificationCode" />
						</AirPollutantEPAClassificationCode>
						<xsl:if test="v1:AirPollutantEPAClassificationStartDate != ''">
						<AirPollutantEPAClassificationStartDate>
							<xsl:value-of select="v1:AirPollutantEPAClassificationStartDate" />
						</AirPollutantEPAClassificationStartDate>
						</xsl:if>
					</AirPollutantEPAClassificationData>
					</xsl:if>
					<xsl:if test="v1:AirPollutantDAClassificationCode != ''">
					<AirPollutantDAClassificationData>
						<AirPollutantDAClassificationCode>
							<xsl:value-of select="v1:AirPollutantDAClassificationCode" />
						</AirPollutantDAClassificationCode>
						<xsl:if test="v1:AirPollutantDAClassificationStartDate != ''">
						<AirPollutantDAClassificationStartDate>
							<xsl:value-of select="v1:AirPollutantDAClassificationStartDate" />
						</AirPollutantDAClassificationStartDate>
						</xsl:if>
					</AirPollutantDAClassificationData>
					</xsl:if>
                </AirPollutants>
				</xsl:for-each>
        </AirPollutantsData>
		</xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
