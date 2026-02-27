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
		<AirTVACCData xmlns="http://www.exchangenetwork.net/schema/icis/5">
			<TransactionHeader>
				<TransactionType>
					<xsl:value-of select="v1:TransactionType" />
				</TransactionType>
				<TransactionTimestamp>
					<xsl:value-of select="v1:TransactionTimestamp" />
				</TransactionTimestamp>
			</TransactionHeader>
			<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][not(self::v1:record/v1:ComplianceMonitoringId=following-sibling::v1:record/v1:ComplianceMonitoringId)]">
            <xsl:variable name="ComplianceMonitoringId" select="v1:ComplianceMonitoringId"/>
			<AirTVACC>
					<ComplianceMonitoringIdentifier>
						<xsl:value-of select="v1:ComplianceMonitoringId" />
					</ComplianceMonitoringIdentifier>
					<ComplianceMonitoringDate>
						<xsl:value-of select="v1:ComplianceMonitoringDate" />
					</ComplianceMonitoringDate>
					<xsl:if test="v1:StartDate!= ''" >
					<ComplianceMonitoringStartDate>
						<xsl:value-of select="v1:StartDate" />
					</ComplianceMonitoringStartDate>
					</xsl:if>
					<xsl:if test="v1:ActivityName!= ''" >
					<ComplianceMonitoringActivityName>
						<xsl:value-of select="v1:ActivityName" />
					</ComplianceMonitoringActivityName>
					</xsl:if>
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:ComplianceMonitoringId=$ComplianceMonitoringId][v1:CodeName='NationalPrioritiesCode'][not(self::v1:record/v1:ComplianceMonitoringCodeId=following-sibling::v1:record/v1:ComplianceMonitoringCodeId)]">
					<NationalPrioritiesCode>
						<xsl:value-of select="v1:CodeValue" />
					</NationalPrioritiesCode>
					</xsl:for-each >
					<xsl:if test="v1:MultimediaIndicator!= ''" >
					<MultimediaIndicator>
						<xsl:value-of select="v1:MultimediaIndicator" />
					</MultimediaIndicator>
					</xsl:if>
					<xsl:if test="v1:PlannedStartDate!= ''" >
					<ComplianceMonitoringPlannedStartDate>
						<xsl:value-of select="v1:PlannedStartDate" />
					</ComplianceMonitoringPlannedStartDate>
					</xsl:if>
					<xsl:if test="v1:PlannedEndDate!= ''" >
					<ComplianceMonitoringPlannedEndDate>
						<xsl:value-of select="v1:PlannedEndDate" />
					</ComplianceMonitoringPlannedEndDate>
					</xsl:if>
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:ComplianceMonitoringId=$ComplianceMonitoringId][v1:CodeName='RegionalPriorityCode'][not(self::v1:record/v1:ComplianceMonitoringCodeId=following-sibling::v1:record/v1:ComplianceMonitoringCodeId)]">
					<RegionalPriorityCode>
						<xsl:value-of select="v1:CodeValue" />
					</RegionalPriorityCode>
					</xsl:for-each >
					<xsl:if test="v1:DeficienciesObservedIndicator!= ''" >
					<DeficienciesObservedIndicator>
						<xsl:value-of select="v1:DeficienciesObservedIndicator" />
					</DeficienciesObservedIndicator>
					</xsl:if>
					<xsl:if test="v1:AirFacilityID!= ''" >
					<AirFacilityIdentifier>
						<xsl:value-of select="v1:AirFacilityID" />
					</AirFacilityIdentifier>
					</xsl:if>
					<xsl:if test="v1:LeadAgencyCode!= ''" >
					<LeadAgencyCode>
						<xsl:value-of select="v1:LeadAgencyCode" />
					</LeadAgencyCode>
					</xsl:if>
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:ComplianceMonitoringId=$ComplianceMonitoringId][v1:CodeName='ProgramCode'][not(self::v1:record/v1:ComplianceMonitoringCodeId=following-sibling::v1:record/v1:ComplianceMonitoringCodeId)]">
					<ProgramCode>
						<xsl:value-of select="v1:CodeValue" />
					</ProgramCode>
					</xsl:for-each >
					<xsl:if test="v1:OtherProgramDescriptionText!= ''" >
					<OtherProgramDescriptionText>
						<xsl:value-of select="v1:OtherProgramDescriptionText" />
					</OtherProgramDescriptionText>
					</xsl:if>
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:ComplianceMonitoringId=$ComplianceMonitoringId][v1:CodeName='AirPollutantCode'][not(self::v1:record/v1:ComplianceMonitoringCodeId=following-sibling::v1:record/v1:ComplianceMonitoringCodeId)]">
					<AirPollutantCode>
						<xsl:value-of select="v1:CodeValue" />
					</AirPollutantCode>
					</xsl:for-each >
					<xsl:if test="v1:OtherAgencyInitiativeText!= ''" >
					<OtherAgencyInitiativeText>
						<xsl:value-of select="v1:OtherAgencyInitiativeText" />
					</OtherAgencyInitiativeText>
					</xsl:if>
					<xsl:if test="v1:InspectionUserDefinedField1!= ''" >
					<InspectionUserDefinedField1>
						<xsl:value-of select="v1:InspectionUserDefinedField1" />
					</InspectionUserDefinedField1>
					</xsl:if>
					<xsl:if test="v1:InspectionUserDefinedField2!= ''" >
					<InspectionUserDefinedField2>
						<xsl:value-of select="v1:InspectionUserDefinedField2" />
					</InspectionUserDefinedField2>
					</xsl:if>
					<xsl:if test="v1:InspectionUserDefinedField3!= ''" >
					<InspectionUserDefinedField3>
						<xsl:value-of select="v1:InspectionUserDefinedField3" />
					</InspectionUserDefinedField3>
					</xsl:if>
					<xsl:if test="v1:InspectionUserDefinedField4!= ''" >
					<InspectionUserDefinedField4>
						<xsl:value-of select="v1:InspectionUserDefinedField4" />
					</InspectionUserDefinedField4>
					</xsl:if>
					<xsl:if test="v1:InspectionUserDefinedField5!= ''" >
					<InspectionUserDefinedField5>
						<xsl:value-of select="v1:InspectionUserDefinedField5" />
					</InspectionUserDefinedField5>
					</xsl:if>
					<xsl:if test="v1:InspectionUserDefinedField6!= ''" >
					<InspectionUserDefinedField6>
						<xsl:value-of select="v1:InspectionUserDefinedField6" />
					</InspectionUserDefinedField6>
					</xsl:if>
					<xsl:if test="v1:AirPermitIdentifier!= ''" >
					<AirPermitIdentifier>
						<xsl:value-of select="v1:AirPermitIdentifier" />
					</AirPermitIdentifier>
					</xsl:if>
					<xsl:if test="v1:CertificationPeriodStartDate!= ''" >
					<CertificationPeriodStartDate>
						<xsl:value-of select="v1:CertificationPeriodStartDate" />
					</CertificationPeriodStartDate>
					</xsl:if>
					<xsl:if test="v1:CertificationPeriodEndDate!= ''" >
					<CertificationPeriodEndDate>
						<xsl:value-of select="v1:CertificationPeriodEndDate" />
					</CertificationPeriodEndDate>
					</xsl:if>
					<xsl:if test="v1:FacilityReportedComplianceStatusCode!= ''" >
					<FacilityReportedComplianceStatusCode>
						<xsl:value-of select="v1:FacilityReportedComplianceStatusCode" />
					</FacilityReportedComplianceStatusCode>
					</xsl:if>
					<xsl:if test="v1:TVACCReviewedDate!= ''" >
					<xsl:for-each select="//v1:record[not(self::v1:record/v1:TVACCReviewDataId=following-sibling::v1:record/v1:TVACCReviewDataId)][v1:ComplianceMonitoringId=$ComplianceMonitoringId][v1:TransactionID=$TransactionID]">
					<TVACCReviewData>
						<TVACCReviewedDate><xsl:value-of select="v1:TVACCReviewedDate" /></TVACCReviewedDate>
						<xsl:if test="v1:FacilityReportDeviationsIndicator!= ''" >
						<FacilityReportDeviationsIndicator>
						<xsl:value-of select="v1:FacilityReportDeviationsIndicator" />
						</FacilityReportDeviationsIndicator>
						</xsl:if>
						<xsl:if test="v1:PermitConditionsText!= ''" >
						<PermitConditionsText>
						<xsl:value-of select="v1:PermitConditionsText" />
						</PermitConditionsText>
						</xsl:if>
						<xsl:if test="v1:ExceedanceExcursionIndicator!= ''" >
						<ExceedanceExcursionIndicator>
						<xsl:value-of select="v1:ExceedanceExcursionIndicator" />
						</ExceedanceExcursionIndicator>
						</xsl:if>
						<xsl:if test="v1:ReviewerAgencyCode!= ''" >
						<ReviewerAgencyCode>
						<xsl:value-of select="v1:ReviewerAgencyCode" />
						</ReviewerAgencyCode>
						</xsl:if>
						<xsl:if test="v1:TVACCReviewerName!= ''" >
						<TVACCReviewerName>
						<xsl:value-of select="v1:TVACCReviewerName" />
						</TVACCReviewerName>
						</xsl:if>
						<xsl:if test="v1:ReviewerComment!= ''" >
						<ReviewerComment>
						<xsl:value-of select="v1:ReviewerComment" />
						</ReviewerComment>
						</xsl:if>
					</TVACCReviewData>
					</xsl:for-each >
					</xsl:if>
					<xsl:if test="v1:FirstName!= ''" >
					<InspectionContact>
						<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:ComplianceMonitoringId=$ComplianceMonitoringId][not(self::v1:record/v1:ContactId=following-sibling::v1:record/v1:ContactId)]">
						<xsl:variable name="ContactId" select="v1:ContactId"/>
						<Contact>
							<xsl:if test="v1:AffiliationTypeText!= ''" >
							<AffiliationTypeText>
								<xsl:value-of select="v1:AffiliationTypeText" />
							</AffiliationTypeText>
							</xsl:if>
							<FirstName>
								<xsl:value-of select="v1:FirstName" />
							</FirstName>
							<xsl:if test="v1:MiddleName!= ''" >
							<MiddleName>
								<xsl:value-of select="v1:MiddleName" />
							</MiddleName>
							</xsl:if>
							<xsl:if test="v1:LastName!= ''" >
							<LastName>
								<xsl:value-of select="v1:LastName" />
							</LastName>
							</xsl:if>
							<xsl:if test="v1:IndividualTitleText!= ''" >
							<IndividualTitleText>
								<xsl:value-of select="v1:IndividualTitleText" />
							</IndividualTitleText>
							</xsl:if>
							<xsl:if test="v1:OrganizationFormalName!= ''" >
							<OrganizationFormalName>
								<xsl:value-of select="v1:OrganizationFormalName" />
							</OrganizationFormalName>
							</xsl:if>
							<xsl:if test="v1:StateCode!= ''" >
							<StateCode>
								<xsl:value-of select="v1:StateCode" />
							</StateCode>
							</xsl:if>
							<xsl:if test="v1:StateCode!= ''" >
							<RegionCode>
								<xsl:value-of select="v1:RegionCode" />
							</RegionCode>
							</xsl:if>
							<xsl:if test="v1:TelephoneNumber!= ''" >
							<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:ComplianceMonitoringId=$ComplianceMonitoringId][v1:ContactId=$ContactId][not(self::v1:record/v1:TelephoneNumber=following-sibling::v1:record/v1:TelephoneNumber)]">
							<Telephone>
								<xsl:if test="v1:TelephoneNumberTypeCode!= ''" >
								<TelephoneNumberTypeCode>
									<xsl:value-of select="v1:TelephoneNumberTypeCode" />
								</TelephoneNumberTypeCode>
								</xsl:if>
								<TelephoneNumber>
									<xsl:value-of select="v1:TelephoneNumber" />
								</TelephoneNumber>
								<xsl:if test="v1:TelephoneExtensionNumber!= ''" >
								<TelephoneExtensionNumber>
									<xsl:value-of select="v1:TelephoneExtensionNumber" />
								</TelephoneExtensionNumber>
								</xsl:if>
							</Telephone>
							</xsl:for-each>
							</xsl:if>
							<xsl:if test="v1:ElectronicAddressText!= ''" >
							<ElectronicAddressText>
								<xsl:value-of select="v1:ElectronicAddressText" />
							</ElectronicAddressText>
							</xsl:if>
							<xsl:if test="v1:StartDateOfContactAssociation!= ''" >
							<StartDateOfContactAssociation>
								<xsl:value-of select="v1:StartDateOfContactAssociation" />
							</StartDateOfContactAssociation>
							</xsl:if>
							<xsl:if test="v1:EndDateOfContactAssociation!= ''" >
							<EndDateOfContactAssociation>
								<xsl:value-of select="v1:EndDateOfContactAssociation" />
							</EndDateOfContactAssociation>
							</xsl:if>
						</Contact>
						</xsl:for-each>
					</InspectionContact>
					</xsl:if>
					<xsl:if test="v1:GElectronicAddressText!= ''" >
					<InspectionGovernmentContact>
							<xsl:if test="v1:GAffiliationTypeText!= ''" >
							<AffiliationTypeText>
								<xsl:value-of select="v1:GAffiliationTypeText" />
							</AffiliationTypeText>
							</xsl:if>
							<ElectronicAddressText>
								<xsl:value-of select="v1:GElectronicAddressText" />
							</ElectronicAddressText>
					</InspectionGovernmentContact>
					</xsl:if>
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:ComplianceMonitoringId=$ComplianceMonitoringId][v1:CommentName='InspectionCommentText'][not(self::v1:record/v1:ComplianceMonitoringCommentId=following-sibling::v1:record/v1:ComplianceMonitoringCommentId)]">
					<InspectionCommentText>
						<xsl:value-of select="v1:CommentText" />
					</InspectionCommentText>
					</xsl:for-each >
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:ComplianceMonitoringId=$ComplianceMonitoringId][v1:CommentName='SensitiveCommentText'][not(self::v1:record/v1:ComplianceMonitoringCommentId=following-sibling::v1:record/v1:ComplianceMonitoringCommentId)]">
					<SensitiveCommentText>
						<xsl:value-of select="v1:CommentText" />
					</SensitiveCommentText>
					</xsl:for-each >
            </AirTVACC>
				</xsl:for-each>
        </AirTVACCData>
		</xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
