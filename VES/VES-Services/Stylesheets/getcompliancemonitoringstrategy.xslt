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
		<AirComplianceMonitoringStrategyData xmlns="http://www.exchangenetwork.net/schema/icis/5">
			<TransactionHeader>
				<TransactionType>
					<xsl:value-of select="v1:TransactionType" />
				</TransactionType>
				<TransactionTimestamp>
					<xsl:value-of select="v1:TransactionTimestamp" />
				</TransactionTimestamp>
			</TransactionHeader>
			<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][not(self::v1:record/v1:ComplianceMonitoringStrategyID=following-sibling::v1:record/v1:ComplianceMonitoringStrategyID)]">
			<AirComplianceMonitoringStrategy>
					<AirFacilityIdentifier>
						<xsl:value-of select="v1:AirFacilityId" />
					</AirFacilityIdentifier>
					<AirCMSSourceCategoryCode>
						<xsl:value-of select="v1:AirCMSSourceCategoryCode" />
					</AirCMSSourceCategoryCode>
					<AirCMSMinimumFrequency>
						<xsl:value-of select="v1:AirCMSMinimumFrequency" />
					</AirCMSMinimumFrequency>
					<xsl:if test="v1:AirCMSStartDate!= ''" >
					<AirCMSStartDate>
						<xsl:value-of select="v1:AirCMSStartDate" />
					</AirCMSStartDate>
					</xsl:if>
					<xsl:if test="v1:AirActiveCMSPlanIndicator!= ''" >
					<AirActiveCMSPlanIndicator>
						<xsl:value-of select="v1:AirActiveCMSPlanIndicator" />
					</AirActiveCMSPlanIndicator>
					</xsl:if>
					<xsl:if test="v1:AirRemovedPlanDate!= ''" >
					<AirRemovedPlanDate>
						<xsl:value-of select="v1:AirRemovedPlanDate" />
					</AirRemovedPlanDate>
					</xsl:if>
					<xsl:if test="v1:AirReasonChangingCMSComments!= ''" >
					<AirReasonChangingCMSComments>
						<xsl:value-of select="v1:AirReasonChangingCMSComments" />
					</AirReasonChangingCMSComments>
					</xsl:if>
            </AirComplianceMonitoringStrategy>
				</xsl:for-each>
        </AirComplianceMonitoringStrategyData>
		</xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
