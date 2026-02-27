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
		<AirDACaseFileData xmlns="http://www.exchangenetwork.net/schema/icis/5">
			<TransactionHeader>
				<TransactionType>R</TransactionType>
				<TransactionTimestamp>
					<xsl:value-of select="v1:TransactionTimestamp" />
				</TransactionTimestamp>
			</TransactionHeader>
			<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][not(self::v1:record/v1:CaseFileId=following-sibling::v1:record/v1:CaseFileId)]">
            <xsl:variable name="CaseFileId" select="v1:CaseFileId"/>
			<AirDACaseFile>
					<CaseFileIdentifier>
						<xsl:value-of select="v1:CaseFileId" />
					</CaseFileIdentifier>
					<xsl:if test="v1:CaseFileName!= ''" >
					<CaseFileName>
						<xsl:value-of select="v1:CaseFileName" />
					</CaseFileName>
					</xsl:if>
					<AirFacilityIdentifier>
						<xsl:value-of select="v1:AirFacilityId" />
					</AirFacilityIdentifier>
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:CaseFileId=$CaseFileId][v1:CodeName='ProgramCode'][not(self::v1:record/v1:CaseFileCodeId=following-sibling::v1:record/v1:CaseFileCodeId)]">
					<ProgramCode>
						<xsl:value-of select="v1:CodeValue" />
					</ProgramCode>
					</xsl:for-each>
					<xsl:if test="v1:OtherProgramDescription!= ''" >
					<OtherProgramDescriptionText>
						<xsl:value-of select="v1:OtherProgramDescription" />
					</OtherProgramDescriptionText>
					</xsl:if>
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:CaseFileId=$CaseFileId][v1:CodeName='AirPollutantCode'][not(self::v1:record/v1:CaseFileCodeId=following-sibling::v1:record/v1:CaseFileCodeId)]">
					<AirPollutantCode>
						<xsl:value-of select="v1:CodeValue" />
					</AirPollutantCode>
					</xsl:for-each>
					<xsl:if test="v1:SensitiveDataIndicator!= ''" >
					<SensitiveDataIndicator>
						<xsl:value-of select="v1:SensitiveDataIndicator" />
					</SensitiveDataIndicator>
					</xsl:if>
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:CaseFileId=$CaseFileId][not(self::v1:record/v1:OtherPathwayActivityDataId=following-sibling::v1:record/v1:OtherPathwayActivityDataId)][v1:OtherPathwayActivityDataId!='']">
					<OtherPathwayActivityData>
						<OtherPathwayCategoryCode>
							<xsl:value-of select="v1:OtherPathwayCategoryCode" />
						</OtherPathwayCategoryCode>
						<OtherPathwayTypeCode>
							<xsl:value-of select="v1:OtherPathwayTypeCode" />
						</OtherPathwayTypeCode>
						<OtherPathwayDate>
							<xsl:value-of select="v1:OtherPathwayDate" />
						</OtherPathwayDate>
					</OtherPathwayActivityData>
					</xsl:for-each>
					<xsl:if test="v1:LeadAgencyChangeSuperseded!= ''" >
					<LeadAgencyChangeSupersededText>
						<xsl:value-of select="v1:LeadAgencyChangeSuperseded" />
					</LeadAgencyChangeSupersededText>
					</xsl:if>
					<xsl:if test="v1:AdvisementMethodTypeCode!= ''" >
					<AdvisementMethodTypeCode>
						<xsl:value-of select="v1:AdvisementMethodTypeCode" />
					</AdvisementMethodTypeCode>
					</xsl:if>
					<xsl:if test="v1:AdvisementMethodDate!= ''" >
					<AdvisementMethodDate>
						<xsl:value-of select="v1:AdvisementMethodDate" />
					</AdvisementMethodDate>
					</xsl:if>
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:CaseFileId=$CaseFileId][not(self::v1:record/v1:AirViolationDataId=following-sibling::v1:record/v1:AirViolationDataId)]">
					<AirViolationData>
						<AirViolationTypeCode>
							<xsl:value-of select="v1:AirViolationTypeCode" />
						</AirViolationTypeCode>
						<AirViolationProgramCode>
							<xsl:value-of select="v1:AirViolationProgramCode" />
						</AirViolationProgramCode>
						<xsl:if test="v1:AirViolationProgramDescriptionText!= ''" >
						<AirViolationProgramDescriptionText>
							<xsl:value-of select="v1:AirViolationProgramDescriptionText" />
						</AirViolationProgramDescriptionText>
						</xsl:if>
						<xsl:if test="v1:AirViolationPollutantCode!= ''" >
						<AirViolationPollutantCode>
							<xsl:value-of select="v1:AirViolationPollutantCode" />
						</AirViolationPollutantCode>
						</xsl:if>
						<xsl:if test="v1:FRVDeterminationDate!= ''" >
						<FRVDeterminationDate>
							<xsl:value-of select="v1:FRVDeterminationDate" />
						</FRVDeterminationDate>
						</xsl:if>
						<xsl:if test="v1:HPVDayZeroDate!= ''" >
						<HPVDayZeroDate>
							<xsl:value-of select="v1:HPVDayZeroDate" />
						</HPVDayZeroDate>
						</xsl:if>
						<xsl:if test="v1:OccurrenceStartDate!= ''" >
						<OccurrenceStartDate>
							<xsl:value-of select="v1:OccurrenceStartDate" />
						</OccurrenceStartDate>
						</xsl:if>
						<xsl:if test="v1:OccurrenceEndDate!= ''" >
						<OccurrenceEndDate>
							<xsl:value-of select="v1:OccurrenceEndDate" />
						</OccurrenceEndDate>
						</xsl:if>
						<xsl:if test="v1:HPVDesignationRemovalTypeCode!= ''" >
						<HPVDesignationRemovalTypeCode>
							<xsl:value-of select="v1:HPVDesignationRemovalTypeCode" />
						</HPVDesignationRemovalTypeCode>
						</xsl:if>
						<xsl:if test="v1:HPVDesignationRemovalDate!= ''" >
						<HPVDesignationRemovalDate>
							<xsl:value-of select="v1:HPVDesignationRemovalDate" />
						</HPVDesignationRemovalDate>
						</xsl:if>
						<xsl:if test="v1:ClaimsNumber!= ''" >
						<ClaimsNumber>
							<xsl:value-of select="v1:ClaimsNumber" />
						</ClaimsNumber>
						</xsl:if>
					</AirViolationData>
					</xsl:for-each>
					<xsl:if test="v1:CaseFileUserDefinedField1!= ''" >
					<CaseFileUserDefinedField1><xsl:value-of select="v1:CaseFileUserDefinedField1" /></CaseFileUserDefinedField1>
					</xsl:if>
					<xsl:if test="v1:CaseFileUserDefinedField2!= ''" >
					<CaseFileUserDefinedField2><xsl:value-of select="v1:CaseFileUserDefinedField2" /></CaseFileUserDefinedField2>
					</xsl:if>
					<xsl:if test="v1:CaseFileUserDefinedField3!= ''" >
					<CaseFileUserDefinedField3><xsl:value-of select="v1:CaseFileUserDefinedField3" /></CaseFileUserDefinedField3>
					</xsl:if>
					<xsl:if test="v1:CaseFileUserDefinedField4!= ''" >
					<CaseFileUserDefinedField4><xsl:value-of select="v1:CaseFileUserDefinedField4" /></CaseFileUserDefinedField4>
					</xsl:if>
					<xsl:if test="v1:CaseFileUserDefinedField5!= ''" >
					<CaseFileUserDefinedField5><xsl:value-of select="v1:CaseFileUserDefinedField5" /></CaseFileUserDefinedField5>
					</xsl:if>
					<xsl:if test="v1:CaseFileUserDefinedField6!= ''" >
					<CaseFileUserDefinedField6><xsl:value-of select="v1:CaseFileUserDefinedField6" /></CaseFileUserDefinedField6>
					</xsl:if>
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:CaseFileId=$CaseFileId][v1:CommentName='CaseFileCommentText'][not(self::v1:record/v1:CaseFileCommentId=following-sibling::v1:record/v1:CaseFileCommentId)]">
					<CaseFileCommentText>
						<xsl:value-of select="v1:CommentText" />
					</CaseFileCommentText>
					</xsl:for-each>
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:CaseFileId=$CaseFileId][v1:CommentName='SensitiveCommentText'][not(self::v1:record/v1:CaseFileCommentId=following-sibling::v1:record/v1:CaseFileCommentId)]">
					<SensitiveCommentText>
						<xsl:value-of select="v1:CommentText" />
					</SensitiveCommentText>
					</xsl:for-each>
            </AirDACaseFile>
				</xsl:for-each>
        </AirDACaseFileData>
		</xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
