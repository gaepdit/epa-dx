<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v1="http://www.exchangenetwork.net/schema/dataset/2" exclude-result-prefixes="v1"
>
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:template match="/v1:DataSet">
		<ATTAINS xmlns="http://www.exchangenetwork.net/schema/IR/1">
			<Organization>
				<OrganizationIdentifier>
					<xsl:value-of select="v1:record/v1:ORGANIZATION_IDEN" />
				</OrganizationIdentifier>
				<xsl:if test="v1:record/v1:ORGANIZATION_NAME!= ''" >
				<OrganizationName>
					<xsl:value-of select="v1:record/v1:ORGANIZATION_NAME" />
				</OrganizationName>
				</xsl:if>
				<xsl:if test="v1:record/v1:ORGANIZATION_TYPE!= ''" >
				<OrganizationTypeText>
					<xsl:value-of select="v1:record/v1:ORGANIZATION_TYPE" />
				</OrganizationTypeText>
				</xsl:if>
				<xsl:if test="v1:record/v1:ORG_CONTACT_ID!= ''" >
				<OrganizationContacts>
					<xsl:for-each select="//v1:record[not(self::v1:record/v1:ORG_CONTACT_ID=following-sibling::v1:record/v1:ORG_CONTACT_ID)]">
					<OrganizationContact>
						<ContactTypeText>
							<xsl:value-of select="v1:CONTACT_TYPE" />
						</ContactTypeText>
						<WebURLText>
							<xsl:value-of select="v1:WEB_URL" />
						</WebURLText>
						<xsl:if test="v1:SUB_ORG_NAME!= ''" >
						<SubOrganizationName>
							<xsl:value-of select="v1:SUB_ORG_NAME" />
						</SubOrganizationName>
						</xsl:if>
						<xsl:if test="v1:EMAIL!= ''" >
						<EmailAddressText>
							<xsl:value-of select="v1:EMAIL" />
						</EmailAddressText>
						</xsl:if>
						<xsl:if test="v1:FIRST_NAME!= ''" >
						<FirstName>
							<xsl:value-of select="v1:FIRST_NAME" />
						</FirstName>
						</xsl:if>
						<xsl:if test="v1:MIDDLE_INITIAL!= ''" >
						<MiddleInitial>
							<xsl:value-of select="v1:MIDDLE_INITIAL" />
						</MiddleInitial>
						</xsl:if>
						<xsl:if test="v1:LAST_NAME!= ''" >
						<LastName>
							<xsl:value-of select="v1:LAST_NAME" />
						</LastName>
						</xsl:if>
						<xsl:if test="v1:INDIVIDUAL_TITLE!= ''" >
						<IndividualTitleText>
							<xsl:value-of select="v1:INDIVIDUAL_TITLE" />
						</IndividualTitleText>
						</xsl:if>
						<xsl:if test="v1:TELEPHONE!= ''" >
						<TelephoneNumberText>
							<xsl:value-of select="v1:TELEPHONE" />
						</TelephoneNumberText>
						</xsl:if>
						<xsl:if test="v1:PHONE_EXT!= ''" >
						<PhoneExtensionText>
							<xsl:value-of select="v1:PHONE_EXT" />
						</PhoneExtensionText>
						</xsl:if>
						<xsl:if test="v1:FAX!= ''" >
						<FaxNumberText>
							<xsl:value-of select="v1:FAX" />
						</FaxNumberText>
						</xsl:if>
						<xsl:if test="v1:MAILING_ADDRESS!= ''" >
						<MailingAddress>
							<MailingAddressText>
								<xsl:value-of select="v1:MAILING_ADDRESS" />
							</MailingAddressText>
							<xsl:if test="v1:SUPPL_ADDRESS!= ''" >
							<SupplementalAddressText>
								<xsl:value-of select="v1:SUPPL_ADDRESS" />
							</SupplementalAddressText>
							</xsl:if>
							<xsl:if test="v1:CITY!= ''" >
							<MailingAddressCityName>
								<xsl:value-of select="v1:CITY" />
							</MailingAddressCityName>
							</xsl:if>
							<xsl:if test="v1:STATE_CODE!= ''" >
							<MailingAddressStateUSPSCode>
								<xsl:value-of select="v1:STATE_CODE" />
							</MailingAddressStateUSPSCode>
							</xsl:if>
							<xsl:if test="v1:COUNTRY_CODE!= ''" >
							<MailingAddressCountryCode>
								<xsl:value-of select="v1:COUNTRY_CODE" />
							</MailingAddressCountryCode>
							</xsl:if>
							<xsl:if test="v1:ZIP_CODE!= ''" >
							<MailingAddressZIPCode>
								<xsl:value-of select="v1:ZIP_CODE" />
							</MailingAddressZIPCode>
							</xsl:if>
						</MailingAddress>
						</xsl:if>
					</OrganizationContact>
					</xsl:for-each>
				</OrganizationContacts>
				</xsl:if>
                <AssessmentUnits>
                    <xsl:for-each select="//v1:record[not(self::v1:record/v1:ASSESS_UNIT_ID=following-sibling::v1:record/v1:ASSESS_UNIT_ID)]">
					<xsl:variable name="ASSESS_UNIT_ID" select="v1:ASSESS_UNIT_ID"/>
					<AssessmentUnit>
                        <AssessmentUnitIdentifier>
							<xsl:value-of select="v1:ASSESS_UNIT_IDEN" />
						</AssessmentUnitIdentifier>
                        <AssessmentUnitName>
							<xsl:value-of select="v1:ASSESS_UNIT_NAME" />
						</AssessmentUnitName>
                        <LocationDescriptionText>
							<xsl:value-of select="v1:LOC_DESC" />
						</LocationDescriptionText>
                        <AgencyCode>
							<xsl:value-of select="v1:AGENCY_CODE" />
						</AgencyCode>
                        <StateCode>
							<xsl:value-of select="v1:ASSESS_UNIT_STATE_CODE" />
						</StateCode>
                        <StatusIndicator>
							<xsl:value-of select="v1:STATUS_IND" />
						</StatusIndicator>
						<xsl:if test="v1:WATER_TYPE_ID!= ''" >
						<WaterTypes>
                            <xsl:for-each select="//v1:record[v1:ASSESS_UNIT_ID=$ASSESS_UNIT_ID][not(self::v1:record/v1:WATER_TYPE_ID=following-sibling::v1:record/v1:WATER_TYPE_ID)]">
							<WaterType>
                                <WaterTypeCode>
									<xsl:value-of select="v1:WATER_TYPE_CODE" />
								</WaterTypeCode>
                                <WaterSizeNumber>
									<xsl:value-of select="v1:WATER_SIZE_NUM" />
								</WaterSizeNumber>
                                <UnitsCode>
									<xsl:value-of select="v1:UNITS_CODE" />
								</UnitsCode>
								<xsl:if test="v1:SIZE_EST_METHOD_CODE!= ''" >
                                <SizeEstimationMethodCode>
									<xsl:value-of select="v1:SIZE_EST_METHOD_CODE" />
								</SizeEstimationMethodCode>
								</xsl:if>
                                <xsl:if test="v1:SIZE_SRC!= ''" >
                                <SizeSourceText>
									<xsl:value-of select="v1:SIZE_SRC" />
								</SizeSourceText>
                                </xsl:if>
                                <xsl:if test="v1:SIZE_SRC_SCALE!= ''" >
                                <SizeSourceScaleText>
									<xsl:value-of select="v1:SIZE_SRC_SCALE" />
								</SizeSourceScaleText>
								</xsl:if>
                            </WaterType>
                            </xsl:for-each>
                        </WaterTypes> 
						</xsl:if>						
                        <xsl:if test="v1:LOCATION_ID!= ''" >
						<Locations>
                            <xsl:for-each select="//v1:record[v1:ASSESS_UNIT_ID=$ASSESS_UNIT_ID][not(self::v1:record/v1:LOCATION_ID=following-sibling::v1:record/v1:LOCATION_ID)]">
							<Location>
                                <LocationTypeCode>
									<xsl:value-of select="v1:LOCATION_TYPE_CODE" />
								</LocationTypeCode>
                                <LocationText>
									<xsl:value-of select="v1:LOCATION_TEXT" />
								</LocationText>
                            </Location>
                            </xsl:for-each>
                        </Locations>
                        </xsl:if>	
                        <xsl:if test="v1:MONIT_STATION_ID!= ''" >
						<MonitoringStations>
                            <xsl:for-each select="//v1:record[v1:ASSESS_UNIT_ID=$ASSESS_UNIT_ID][not(self::v1:record/v1:MONIT_STATION_ID=following-sibling::v1:record/v1:MONIT_STATION_ID)]">
							<MonitoringStation>
                                <MonitoringOrganizationIdentifier>
									<xsl:value-of select="v1:MONIT_ORG_IDEN" />
								</MonitoringOrganizationIdentifier>
                                <MonitoringLocationIdentifier>
									<xsl:value-of select="v1:MONIT_LOC_IDEN" />
								</MonitoringLocationIdentifier>
								<xsl:if test="v1:MONIT_DATA_LINK!= ''" >
                                <MonitoringDataLinkText>
									<xsl:value-of select="v1:MONIT_DATA_LINK" />
								</MonitoringDataLinkText>
								</xsl:if>
                            </MonitoringStation>
                            </xsl:for-each>
                        </MonitoringStations>
						</xsl:if>	
						<xsl:if test="v1:USECLASS_CODE!= ''" >
                        <UseClass>
							<UseClassCode>
								<xsl:value-of select="v1:USECLASS_CODE" />
							</UseClassCode>
							<xsl:if test="v1:USECLASS_NAME!= ''" >
							<UseClassName>
								<xsl:value-of select="v1:USECLASS_NAME" />
							</UseClassName>
							</xsl:if>
						</UseClass>
						</xsl:if>
                        <xsl:if test="v1:MODIFICATION_ID!= ''" >
						<Modifications>
							<ModificationTypeCode>
								<xsl:value-of select="v1:MODIF_TYPE_CODE" />
							</ModificationTypeCode>
							<xsl:if test="v1:CHANGE_DESCR!= ''" >
							<ChangeDescriptionText>
								<xsl:value-of select="v1:CHANGE_DESCR" />
							</ChangeDescriptionText>
							</xsl:if>
							<xsl:if test="v1:PRE_ASSESS_UNIT_ID!= ''" >
							<PreviousAssessmentUnits>
								<xsl:for-each select="//v1:record[v1:ASSESS_UNIT_ID=$ASSESS_UNIT_ID][not(self::v1:record/v1:PRE_ASSESS_UNIT_ID=following-sibling::v1:record/v1:PRE_ASSESS_UNIT_ID)]">
								<PreviousAssessmentUnit>
									<AssessmentUnitIdentifier>
										<xsl:value-of select="v1:ASSESS_UNIT_IDEN2" />
									</AssessmentUnitIdentifier>
								</PreviousAssessmentUnit>
								</xsl:for-each>
							</PreviousAssessmentUnits>
							</xsl:if>
                        </Modifications>
                        </xsl:if>
                        <xsl:if test="v1:DOCUMENT_ID!= ''" >
						<Documents>
                            <xsl:for-each select="//v1:record[v1:ASSESS_UNIT_ID=$ASSESS_UNIT_ID][not(self::v1:record/v1:DOCUMENT_ID=following-sibling::v1:record/v1:DOCUMENT_ID)]">
							<xsl:variable name="DOCUMENT_ID" select="v1:DOCUMENT_ID"/>
							<Document>
                                <AgencyCode>
									<xsl:value-of select="v1:DOCUMENT_AGENCY_CODE" />
								</AgencyCode>
								 <xsl:if test="v1:DOCUMENT_TYPE_ID!= ''" >
								<DocumentTypes>
									<xsl:for-each select="//v1:record[v1:DOCUMENT_ID=$DOCUMENT_ID][not(self::v1:record/v1:DOCUMENT_TYPE_ID=following-sibling::v1:record/v1:DOCUMENT_TYPE_ID)]">
									<DocumentType>
										<DocumentTypeCode>
											<xsl:value-of select="v1:DOCUMENT_TYPE_CODE" />
										</DocumentTypeCode>
									</DocumentType>
									</xsl:for-each>
								</DocumentTypes>
								</xsl:if>
                                <DocumentFileType>
									<xsl:value-of select="v1:DOC_FILE_TYPE" />
								</DocumentFileType>
								<xsl:if test="v1:DOC_FILE_NAME!= ''" >
                                <DocumentFileName>
									<xsl:value-of select="v1:DOC_FILE_NAME" />
								</DocumentFileName>
								</xsl:if>
                                <DocumentName>
									<xsl:value-of select="v1:DOC_NAME" />
								</DocumentName>
                                <xsl:if test="v1:DOC_DESC!= ''" >
                                <DocumentDescription>
									<xsl:value-of select="v1:DOC_DESC" />
								</DocumentDescription>
                                </xsl:if>
                                <xsl:if test="v1:DOC_COMMENT!= ''" >
                                <DocumentComments>
									<xsl:value-of select="v1:DOC_COMMENT" />
								</DocumentComments>
								</xsl:if>
                                <xsl:if test="v1:DOC_URL!= ''" >
								<DocumentURL>
									<xsl:value-of select="v1:DOC_URL" />
								</DocumentURL>
								</xsl:if>
                            </Document>
							</xsl:for-each>
						</Documents>
						</xsl:if>	
						<xsl:if test="v1:ASSESS_UNIT_TEXT!= ''" >
                        <AssessmentUnitCommentText>
							<xsl:value-of select="v1:ASSESS_UNIT_TEXT" />
						</AssessmentUnitCommentText>	
						</xsl:if>
                    </AssessmentUnit>
					</xsl:for-each>
                </AssessmentUnits>
            </Organization>
        </ATTAINS>
    </xsl:template>
</xsl:stylesheet>