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
				<Actions>
					<xsl:for-each select="//v1:record[not(self::v1:record/v1:ACTION_ID=following-sibling::v1:record/v1:ACTION_ID)]">
					<xsl:variable name="ACTION_ID" select="v1:ACTION_ID"/>
					<Action>
						<ActionIdentifier>
							<xsl:value-of select="v1:ACTION_IDEN" />
						</ActionIdentifier>
						<ActionName>
							<xsl:value-of select="v1:ACTION_NAME" />
						</ActionName>
						<AgencyCode>
							<xsl:value-of select="v1:AGENCY_CODE" />
						</AgencyCode>
						<ActionTypeCode>
							<xsl:value-of select="v1:ACTION_TYPE_CODE" />
						</ActionTypeCode>
						<ActionStatusCode>
							<xsl:value-of select="v1:ACTION_STATUS_CODE" />
						</ActionStatusCode>
						<CompletionDate>
							<xsl:value-of select="v1:COMPLETION_DATE" />
						</CompletionDate>
						<xsl:if test="v1:DOCUMENT_ID!= ''" >
						<Documents>
                            <xsl:for-each select="//v1:record[v1:ACTION_ID=$ACTION_ID][not(self::v1:record/v1:DOCUMENT_ID=following-sibling::v1:record/v1:DOCUMENT_ID)]">
							<xsl:variable name="DOCUMENT_ID" select="v1:DOCUMENT_ID"/>
							<Document>
                                <AgencyCode>
									<xsl:value-of select="v1:DOCUMENT_AGENCY_CODE" />
								</AgencyCode>
								<DocumentTypes>
									<xsl:for-each select="//v1:record[v1:DOCUMENT_ID=$DOCUMENT_ID][not(self::v1:record/v1:DOCUMENT_TYPE_ID=following-sibling::v1:record/v1:DOCUMENT_TYPE_ID)]">
									<DocumentType>
										<DocumentTypeCode>
											<xsl:value-of select="v1:DOCUMENT_TYPE_CODE" />
										</DocumentTypeCode>
									</DocumentType>
									</xsl:for-each>
								</DocumentTypes>
                                <DocumentFileType>
									<xsl:value-of select="v1:DOC_FILE_TYPE" />
								</DocumentFileType>
                                <DocumentFileName>
									<xsl:value-of select="v1:DOC_FILE_NAME" />
								</DocumentFileName>
                                <DocumentName>
									<xsl:value-of select="v1:DOC_NAME" />
								</DocumentName>
                                <DocumentDescription>
									<xsl:value-of select="v1:DOC_DESC" />
								</DocumentDescription>
                                <DocumentComments>
									<xsl:value-of select="v1:DOC_COMMENT" />
								</DocumentComments>
								<xsl:if test="v1:DOC_URL!= ''" >
								<DocumentURL>
									<xsl:value-of select="v1:DOC_URL" />
								</DocumentURL>
								</xsl:if>
                            </Document>
							</xsl:for-each>
						</Documents>
						</xsl:if>
						<AssociatedWaters>
							<xsl:if test="v1:STATEWIDE_ACTION_ID!= ''" >
							<StateWideActions>
                                <xsl:for-each select="//v1:record[v1:ACTION_ID=$ACTION_ID][not(self::v1:record/v1:STATEWIDE_ACTION_ID=following-sibling::v1:record/v1:STATEWIDE_ACTION_ID)]">
								<xsl:variable name="STATEWIDE_ACTION_ID" select="v1:STATEWIDE_ACTION_ID"/>
								<StateWideAction>
                                    <StateWideAssessmentIdentifier>
										<xsl:value-of select="v1:STATEWIDE_ASSESS_IDEN" />
									</StateWideAssessmentIdentifier>
                                    <StateWideCycleText>
										<xsl:value-of select="v1:STATEWIDE_CYCLE" />
									</StateWideCycleText>
									<xsl:if test="v1:STATEWIDE_CAUSE_ID!= ''" >
                                    <StateWideCauses>
                                        <xsl:for-each select="//v1:record[v1:STATEWIDE_ACTION_ID=$STATEWIDE_ACTION_ID][not(self::v1:record/v1:STATEWIDE_CAUSE_ID=following-sibling::v1:record/v1:STATEWIDE_CAUSE_ID)]">
										<StateWideCause>
                                            <StateWideCauseName>
												<xsl:value-of select="v1:STATEWIDE_CAUSE_NAME" />
											</StateWideCauseName>
                                        </StateWideCause>
										</xsl:for-each>
                                    </StateWideCauses>
                                    </xsl:if>
									<xsl:if test="v1:STATEWIDE_SRC_ID!= ''" >
                                    <StateWideSources>
                                        <xsl:for-each select="//v1:record[v1:STATEWIDE_ACTION_ID=$STATEWIDE_ACTION_ID][not(self::v1:record/v1:STATEWIDE_SRC_ID=following-sibling::v1:record/v1:STATEWIDE_SRC_ID)]">
										<StateWideSource>
                                            <StateWideSourceName>
												<xsl:value-of select="v1:STATEWIDE_SRC_NAME" />
											</StateWideSourceName>
                                        </StateWideSource>
										</xsl:for-each>
                                    </StateWideSources>
									</xsl:if>
									<xsl:if test="v1:STATEWIDE_COMMENT!= ''" >
                                    <StateWideCommentText>
										<xsl:value-of select="v1:STATEWIDE_COMMENT" />
									</StateWideCommentText>
									</xsl:if>
                                </StateWideAction>
								</xsl:for-each>
                            </StateWideActions>
							</xsl:if>
							<xsl:if test="v1:SPECIFIC_WATER_ID!= ''" >
							<SpecificWaters>
								<xsl:for-each select="//v1:record[v1:ACTION_ID=$ACTION_ID][not(self::v1:record/v1:SPECIFIC_WATER_ID=following-sibling::v1:record/v1:SPECIFIC_WATER_ID)]">
								<xsl:variable name="SPECIFIC_WATER_ID" select="v1:SPECIFIC_WATER_ID"/>
								<SpecificWater>
									<AssessmentUnitIdentifier>
										<xsl:value-of select="v1:ASSESS_UNIT_IDEN" />
									</AssessmentUnitIdentifier>
									<xsl:if test="v1:ASSOCIATE_POLLUTANT_ID!= ''" >
                                    <AssociatedPollutants>
										<xsl:for-each select="//v1:record[v1:SPECIFIC_WATER_ID=$SPECIFIC_WATER_ID][not(self::v1:record/v1:ASSOCIATE_POLLUTANT_ID=following-sibling::v1:record/v1:ASSOCIATE_POLLUTANT_ID)]">
										<xsl:variable name="ASSOCIATE_POLLUTANT_ID" select="v1:ASSOCIATE_POLLUTANT_ID"/>
										<AssociatedPollutant>
											<xsl:if test="v1:POLLUTANT_NAME!= ''" >
											<PollutantName>
												<xsl:value-of select="v1:POLLUTANT_NAME" />
											</PollutantName>
											</xsl:if>
											<xsl:if test="v1:POLLUTANT_SRC_TYPE!= ''" >
											<PollutantSourceTypeCode>
												<xsl:value-of select="v1:POLLUTANT_SRC_TYPE" />
											</PollutantSourceTypeCode>
											</xsl:if>
											<xsl:if test="v1:EXPLICIT_MARGIN_SAFETY!= ''" >
											<ExplicitMarginofSafetyText>
												<xsl:value-of select="v1:EXPLICIT_MARGIN_SAFETY" />
											</ExplicitMarginofSafetyText>
											</xsl:if>
											<xsl:if test="v1:IMPLICIT_MARGIN_SAFETY!= ''" >
											<ImplicitMarginofSafetyText>
												<xsl:value-of select="v1:IMPLICIT_MARGIN_SAFETY" />
											</ImplicitMarginofSafetyText>
											</xsl:if>
											<xsl:if test="v1:TMDL_ENDPOINT_TXT!= ''" >
											<TMDLEndPointText>
												<xsl:value-of select="v1:TMDL_ENDPOINT_TXT" />
											</TMDLEndPointText>
											</xsl:if>
											<xsl:if test="v1:LOAD_ALLOCATION_ID!= ''" >
											<LoadAllocationDetails>
												<xsl:for-each select="//v1:record[v1:ASSOCIATE_POLLUTANT_ID=$ASSOCIATE_POLLUTANT_ID][not(self::v1:record/v1:LOAD_ALLOCATION_ID=following-sibling::v1:record/v1:LOAD_ALLOCATION_ID)]">
												<LoadAllocationDetail>
													<xsl:if test="v1:LOADAl_LOC_NUM!= ''" >
													<LoadAllocationNumeric>
														<xsl:value-of select="v1:LOADAl_LOC_NUM" />
													</LoadAllocationNumeric>
													</xsl:if>
													<xsl:if test="v1:LOADAL_LOC_UNIT!= ''" >
													<LoadAllocationUnitsText>
														<xsl:value-of select="v1:LOADAL_LOC_UNIT" />
													</LoadAllocationUnitsText>
													</xsl:if>
													<xsl:if test="v1:ALLOCATION_SEASON_START!= ''" >
													<SeasonStartText>
														<xsl:value-of select="v1:ALLOCATION_SEASON_START" />
													</SeasonStartText>
													</xsl:if>
													<xsl:if test="v1:ALLOCATION_SEASON_END!= ''" >
													<SeasonEndText>
														<xsl:value-of select="v1:ALLOCATION_SEASON_END" />
													</SeasonEndText>
													</xsl:if>
												</LoadAllocationDetail>
												</xsl:for-each>
											</LoadAllocationDetails>
											</xsl:if>
											<xsl:if test="v1:NPDES_ID!= ''" >
											<NPDESDetails>
												<xsl:for-each select="//v1:record[v1:ASSOCIATE_POLLUTANT_ID=$ASSOCIATE_POLLUTANT_ID][not(self::v1:record/v1:NPDES_ID=following-sibling::v1:record/v1:NPDES_ID)]">
												<xsl:variable name="NPDES_ID" select="v1:NPDES_ID"/>
												<NPDESDetail>
													<NPDESIdentifier>
														<xsl:value-of select="v1:NPDES_IDEN" />
													</NPDESIdentifier>
													<OtherIdentifier>
														<xsl:value-of select="v1:OTHER_IDEN" />
													</OtherIdentifier>
													<xsl:if test="v1:TMDL_NPDES_ID!= ''" >
													<TMDLNPDESDetails>
														<xsl:for-each select="//v1:record[v1:ASSOCIATE_POLLUTANT_ID=$ASSOCIATE_POLLUTANT_ID][v1:NPDES_ID=$NPDES_ID][not(self::v1:record/v1:TMDL_NPDES_ID=following-sibling::v1:record/v1:TMDL_NPDES_ID)]">
														<TMDLNPDESDetail>
															<xsl:if test="v1:WASTE_LOADAL_LOC_NUM!= ''" >
															<WasteLoadAllocationNumeric>
																<xsl:value-of select="v1:WASTE_LOADAL_LOC_NUM" />
															</WasteLoadAllocationNumeric>
															</xsl:if>
															<xsl:if test="v1:WASTE_LOADAL_LOC_UNIT!= ''" >
															<WasteLoadAllocationUnitsText>
																<xsl:value-of select="v1:WASTE_LOADAL_LOC_UNIT" />
															</WasteLoadAllocationUnitsText>
															</xsl:if>
															<xsl:if test="v1:TMDL_NPDES_SEASON_START!= ''" >
															<SeasonStartText>
																<xsl:value-of select="v1:TMDL_NPDES_SEASON_START" />
															</SeasonStartText>
															</xsl:if>
															<xsl:if test="v1:TMDL_NPDES_SEASON_END!= ''" >
															<SeasonEndText>
																<xsl:value-of select="v1:TMDL_NPDES_SEASON_END" />
															</SeasonEndText>
															</xsl:if>
														</TMDLNPDESDetail>
														</xsl:for-each>
													</TMDLNPDESDetails>
													</xsl:if>
												</NPDESDetail>
												</xsl:for-each>
											</NPDESDetails>
											</xsl:if>
										</AssociatedPollutant>
										</xsl:for-each>
									</AssociatedPollutants>
									</xsl:if>
									<xsl:if test="v1:PARA_ADDRESSED_ID!= ''" >
                                    <AddressedParameters>
										<xsl:for-each select="//v1:record[v1:SPECIFIC_WATER_ID=$SPECIFIC_WATER_ID][not(self::v1:record/v1:PARA_ADDRESSED_ID=following-sibling::v1:record/v1:PARA_ADDRESSED_ID)]">
										<xsl:variable name="PARA_ADDRESSED_ID" select="v1:PARA_ADDRESSED_ID"/>
										<AddressedParameter>
											<ParameterName>
												<xsl:value-of select="v1:PARAMETER_NAME" />
											</ParameterName>
											<xsl:if test="v1:ASSOC_POLLUT_NAME_ID!= ''" >
											<AssociatedPollutantNames>
												<xsl:for-each select="//v1:record[v1:SPECIFIC_WATER_ID=$SPECIFIC_WATER_ID][v1:PARA_ADDRESSED_ID=$PARA_ADDRESSED_ID][not(self::v1:record/v1:ASSOC_POLLUT_NAME_ID=following-sibling::v1:record/v1:ASSOC_POLLUT_NAME_ID)]">
												<AssociatedPollutantName>
													<xsl:value-of select="v1:ASSOC_POLLUTANT_NAME" />
												</AssociatedPollutantName>
												</xsl:for-each>
											</AssociatedPollutantNames>
											</xsl:if>
										</AddressedParameter>
										</xsl:for-each>
									</AddressedParameters>
									</xsl:if>
									<xsl:if test="v1:SRC_ID!= ''" >
                                    <Sources>
										<xsl:for-each select="//v1:record[v1:ACTION_ID=$ACTION_ID][not(self::v1:record/v1:SRC_ID=following-sibling::v1:record/v1:SRC_ID)]">
										<Source>
											<SourceName>
												<xsl:value-of select="v1:SRC_NAME" />
											</SourceName>
											<xsl:if test="v1:SRC_COMMENT!= ''" >
											<SourceCommentText>
												<xsl:value-of select="v1:SRC_COMMENT" />
											</SourceCommentText>
											</xsl:if>
										</Source>
										</xsl:for-each>
									</Sources>
									</xsl:if>
								</SpecificWater>
								</xsl:for-each>
							</SpecificWaters>
							</xsl:if>
							<Pollutants>
								<xsl:for-each select="//v1:record[v1:ACTION_ID=$ACTION_ID][not(self::v1:record/v1:POLLUTANT_ID=following-sibling::v1:record/v1:POLLUTANT_ID)]">
								<xsl:variable name="POLLUTANT_ID" select="v1:POLLUTANT_ID"/>
								<Pollutant>
									<xsl:if test="v1:POLLUTANT_NAME2!= ''" >
									<PollutantName>
										<xsl:value-of select="v1:POLLUTANT_NAME2" />
									</PollutantName>
									</xsl:if>
									<xsl:if test="v1:POLLUTANT_SRC_TYPE!= ''" >
									<PollutantSourceTypeCode>
										<xsl:value-of select="v1:POLLUTANT_SRC_TYPE" />
									</PollutantSourceTypeCode>
									</xsl:if>
									<xsl:if test="v1:TMDL_POLLUTANT_ID!= ''" >
									<TMDLPollutantDetails>
										<TotalLoadAllocationNumeric>
											<xsl:value-of select="v1:TOTAL_LOADAL_LOC_NUM" />
										</TotalLoadAllocationNumeric>
										<TotalLoadAllocationUnitsText>
											<xsl:value-of select="v1:TOTAL_LOADAL_LOC_UNIT" />
										</TotalLoadAllocationUnitsText>
										<TotalWasteLoadAllocationNumeric>
											<xsl:value-of select="v1:TOTAL_WASTE_LOC_NUM" />
										</TotalWasteLoadAllocationNumeric>
										<TotalWasteLoadAllocationUnitsText>
											<xsl:value-of select="v1:TOTAL_WASTE_LOC_UNIT" />
										</TotalWasteLoadAllocationUnitsText>
									</TMDLPollutantDetails>
									</xsl:if>
									<xsl:if test="v1:LEGACY_NPDES_ID!= ''" >
									<LegacyNPDESDetails>
										<xsl:for-each select="//v1:record[v1:ACTION_ID=$ACTION_ID][v1:POLLUTANT_ID=$POLLUTANT_ID][not(self::v1:record/v1:LEGACY_NPDES_ID=following-sibling::v1:record/v1:LEGACY_NPDES_ID)]">
										<LegacyNPDESDetail>
											<xsl:if test="v1:LEGACY_NPDES_IDEN!= ''" >
											<NPDESIdentifier>
												<xsl:value-of select="v1:LEGACY_NPDES_IDEN" />
											</NPDESIdentifier>
											</xsl:if>
											<xsl:if test="v1:LEGACY_OTHER_IDEN!= ''" >
											<OtherIdentifier>
												<xsl:value-of select="v1:LEGACY_OTHER_IDEN" />
											</OtherIdentifier>
											</xsl:if>
											<xsl:if test="v1:LEGACY_WASTE_LOAD_LOC_UNIT!= ''" >
											<TMDLNPDES>
												<xsl:if test="v1:LEGACY_WASTE_LOAD_LOC_NUM!= ''" >
												<WasteLoadAllocationNumeric>
													<xsl:value-of select="v1:LEGACY_WASTE_LOAD_LOC_NUM" />
												</WasteLoadAllocationNumeric>
												</xsl:if>
												<WasteLoadAllocationUnitsText>
													<xsl:value-of select="v1:LEGACY_WASTE_LOAD_LOC_UNIT" />
												</WasteLoadAllocationUnitsText>
											</TMDLNPDES>
											</xsl:if>
										</LegacyNPDESDetail>
										</xsl:for-each>
									</LegacyNPDESDetails>
									</xsl:if>
								</Pollutant>
								</xsl:for-each>
							</Pollutants>
						</AssociatedWaters>
						<xsl:if test="v1:TMDL_REPORT_ID!= ''" >
						<xsl:variable name="TMDL_REPORT_ID" select="v1:TMDL_REPORT_ID"/>
						<TMDLReportDetails>
							<TMDLOtherIdentifier>
								<xsl:value-of select="v1:TMDL_OTHER_IDEN" />
							</TMDLOtherIdentifier>
							<xsl:if test="v1:TMDL_DATE!= ''" >
							<TMDLDate>
								<xsl:value-of select="v1:TMDL_DATE" />
							</TMDLDate>
							</xsl:if>
							<xsl:if test="v1:INDIAN_COUNTRY_IND!= ''" >
							<IndianCountryIndicator>
								<xsl:value-of select="v1:INDIAN_COUNTRY_IND" />
							</IndianCountryIndicator>
							</xsl:if>
							<xsl:if test="v1:RELATED_TMDL_ID!= ''" >
							<TMDLHistory>
								<xsl:for-each select="//v1:record[v1:TMDL_REPORT_ID=$TMDL_REPORT_ID][not(self::v1:record/v1:RELATED_TMDL_ID=following-sibling::v1:record/v1:RELATED_TMDL_ID)]">	
								<RelatedTMDLs>
									<ActionIdentifier>
										<xsl:value-of select="v1:ACTION_IDEN" />
									</ActionIdentifier>
									<ChangeTypeText>
										<xsl:value-of select="v1:CHANGE_TYPE" />
									</ChangeTypeText>
								</RelatedTMDLs>
								</xsl:for-each>
							</TMDLHistory>
							</xsl:if>
						</TMDLReportDetails>
						</xsl:if>
						
						<xsl:if test="v1:ACTION_COMMENT!= ''" >	
						<ActionCommentText>
							<xsl:value-of select="v1:ACTION_COMMENT" />
						</ActionCommentText>
						</xsl:if>
						<xsl:if test="v1:REVIEW_COMMENT_ID!= ''" >	
						<ReviewComments>
							<xsl:for-each select="//v1:record[v1:ACTION_ID=$ACTION_ID][not(self::v1:record/v1:REVIEW_COMMENT_ID=following-sibling::v1:record/v1:REVIEW_COMMENT_ID)]">
							<ReviewComment>
								<ReviewCommentText>
									<xsl:value-of select="v1:REVIEW_COMMENT" />
								</ReviewCommentText>
								<ReviewCommentDate>
									<xsl:value-of select="v1:COMMENT_DATE" />
								</ReviewCommentDate>
								<ReviewCommentUserName>
									<xsl:value-of select="v1:COMMENT_USER_NAME" />
								</ReviewCommentUserName>
								<OrganizationIdentifier>
									<xsl:value-of select="v1:ORG_IDEN" />
								</OrganizationIdentifier>
							</ReviewComment>
							</xsl:for-each>
						</ReviewComments>
						</xsl:if>
					</Action>
					</xsl:for-each>
				</Actions>
			</Organization>
		</ATTAINS>
    </xsl:template>
</xsl:stylesheet>