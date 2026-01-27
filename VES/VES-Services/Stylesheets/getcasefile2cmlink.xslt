<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v1="http://www.exchangenetwork.net/schema/dataset/2" exclude-result-prefixes="v1"
>
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:template match="/">
       <xsl:apply-templates select="/v1:DataSet"/>
    </xsl:template>
    <xsl:template match="v1:DataSet">
		<xsl:for-each select="v1:record[not(self::v1:record/v1:TransactionId=following-sibling::v1:record/v1:TransactionId)]">
		<xsl:variable name="TransactionID" select="v1:TransactionId"/>
		<CaseFileLinkageData xmlns="http://www.exchangenetwork.net/schema/icis/5">
			<TransactionHeader>
				<TransactionType>
					<xsl:value-of select="v1:TransactionType" />
				</TransactionType>
				<TransactionTimestamp>
					<xsl:value-of select="v1:TransactionTimestamp" />
				</TransactionTimestamp>
			</TransactionHeader>
			<xsl:for-each select="//v1:record[not(self::v1:CaseFileId=following-sibling::v1:CaseFileId)][v1:TransactionId=$TransactionID]">
			<CaseFileLinkage>
				<CaseFileIdentifier>
					<xsl:value-of select="v1:CaseFileId" />
				</CaseFileIdentifier>
				<LinkageComplianceMonitoring>
					<ComplianceMonitoringIdentifier>
						<xsl:value-of select="v1:ComplianceMonitoringId" />
					</ComplianceMonitoringIdentifier>
				</LinkageComplianceMonitoring>									
			</CaseFileLinkage>
			</xsl:for-each>
        </CaseFileLinkageData>
		</xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
