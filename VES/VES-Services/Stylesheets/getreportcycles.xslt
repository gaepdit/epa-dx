<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:v1="http://www.exchangenetwork.net/schema/dataset/2"
                exclude-result-prefixes="v1"
>
  <xsl:output method="xml"
              indent="yes"
              omit-xml-declaration="yes"/>
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
        <xsl:for-each select="//v1:record[not(self::v1:record/v1:REPORTING_CYCLE_ID=following-sibling::v1:record/v1:REPORTING_CYCLE_ID)]">
          <xsl:variable name="REPORTING_CYCLE_ID"
                        select="v1:REPORTING_CYCLE_ID"/>
          <ReportingCycle>
            <ReportingCycleText>
              <xsl:value-of select="v1:REPORTING_CYCLE" />
            </ReportingCycleText>
            <ReportStatusCode>
              <xsl:value-of select="v1:REPORT_STATUS_CODE" />
            </ReportStatusCode>
            <xsl:if test="v1:DOCUMENT_ID!= ''" >
              <Documents>
                <xsl:for-each select="//v1:record[v1:REPORTING_CYCLE_ID=$REPORTING_CYCLE_ID][not(self::v1:record/v1:DOCUMENT_ID=following-sibling::v1:record/v1:DOCUMENT_ID)]">
                  <xsl:variable name="DOCUMENT_ID"
                                select="v1:DOCUMENT_ID"/>
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
            <Assessments>
              <xsl:for-each select="//v1:record[v1:REPORTING_CYCLE_ID=$REPORTING_CYCLE_ID][not(self::v1:record/v1:ASSESS_ID=following-sibling::v1:record/v1:ASSESS_ID)]">
                <xsl:variable name="ASSESS_ID"
                              select="v1:ASSESS_ID"/>
                <Assessment>
                  <AssessmentUnitIdentifier>
                    <xsl:value-of select="v1:ASSESS_UNIT_IDEN" />
                  </AssessmentUnitIdentifier>
                  <AgencyCode>
                    <xsl:value-of select="v1:ASSESS_AGENCY_CODE" />
                  </AgencyCode>
                  <CycleLastAssessedText>
                    <xsl:value-of select="v1:CYCLE_LAST_ASSESSED" />
                  </CycleLastAssessedText>
                  <xsl:if test="v1:YEAR_LAST_MONITORED!= ''" >
                    <YearLastMonitoredText>
                      <xsl:value-of select="v1:YEAR_LAST_MONITORED" />
                    </YearLastMonitoredText>
                  </xsl:if>
                  <xsl:if test="v1:TROPHIC_STATUS_CODE!= ''" >
                    <TrophicStatusCode>
                      <xsl:value-of select="v1:TROPHIC_STATUS_CODE" />
                    </TrophicStatusCode>
                  </xsl:if>
                  <xsl:if test="v1:EPAIR_CATEGORY!= ''" >
                    <EPAIRCategory>
                      <xsl:value-of select="v1:EPAIR_CATEGORY" />
                    </EPAIRCategory>
                  </xsl:if>
                  <xsl:if test="v1:STATE_IR_CATEG_CODE!= ''" >
                    <StateIntegratedReportingCategory>
                      <StateIRCategoryCode>
                        <xsl:value-of select="v1:STATE_IR_CATEG_CODE" />
                      </StateIRCategoryCode>
                      <xsl:if test="v1:STATE_CATEG_DESC!= ''" >
                        <StateCategoryDescriptionText>
                          <xsl:value-of select="v1:STATE_CATEG_DESC" />
                        </StateCategoryDescriptionText>
                      </xsl:if>
                    </StateIntegratedReportingCategory>
                  </xsl:if>
                  <UseAttainments>
                    <xsl:for-each select="//v1:record[v1:ASSESS_ID=$ASSESS_ID][not(self::v1:record/v1:USE_ATTAIN_ID=following-sibling::v1:record/v1:USE_ATTAIN_ID)]">
                      <xsl:variable name="USE_ATTAIN_ID"
                                    select="v1:USE_ATTAIN_ID"/>
                      <UseAttainment>
                        <UseName>
                          <xsl:value-of select="v1:USE_NAME" />
                        </UseName>
                        <UseAttainmentCode>
                          <xsl:value-of select="v1:USE_ATTAIN_CODE" />
                        </UseAttainmentCode>
                        <xsl:if test="v1:THREATENED_IND!= ''" >
                          <ThreatenedIndicator>
                            <xsl:value-of select="v1:THREATENED_IND" />
                          </ThreatenedIndicator>
                        </xsl:if>
                        <xsl:if test="v1:TREND_CODE!= ''" >
                          <TrendCode>
                            <xsl:value-of select="v1:TREND_CODE" />
                          </TrendCode>
                        </xsl:if>
                        <AgencyCode>
                          <xsl:value-of select="v1:ATTAIN_AGENCY_CODE" />
                        </AgencyCode>
                        <xsl:if test="v1:ATTAIN_STATE_IR_CATEG_CODE!= ''" >
                          <StateIntegratedReportingCategory>
                            <StateIRCategoryCode>
                              <xsl:value-of select="v1:ATTAIN_STATE_IR_CATEG_CODE" />
                            </StateIRCategoryCode>
                            <xsl:if test="v1:ATTAIN_STATE_CATEG_DESC!= ''" >
                              <StateCategoryDescriptionText>
                                <xsl:value-of select="v1:ATTAIN_STATE_CATEG_DESC" />
                              </StateCategoryDescriptionText>
                            </xsl:if>
                          </StateIntegratedReportingCategory>
                        </xsl:if>
                        <xsl:if test="v1:ASSESS_METADATA_ID!= ''" >
                          <AssessmentMetadata>
                            <xsl:if test="v1:ASSESS_BASIS_CODE!= ''" >
                              <AssessmentBasisCode>
                                <xsl:value-of select="v1:ASSESS_BASIS_CODE" />
                              </AssessmentBasisCode>
                            </xsl:if>
                            <xsl:if test="v1:ASSESS_TYPE_ID!= ''" >
                              <AssessmentTypes>
                                <xsl:for-each select="//v1:record[v1:USE_ATTAIN_ID=$USE_ATTAIN_ID][not(self::v1:record/v1:ASSESS_TYPE_ID=following-sibling::v1:record/v1:ASSESS_TYPE_ID)]">
                                  <AssessmentType>
                                    <AssessmentTypeCode>
                                      <xsl:value-of select="v1:ASSESS_TYPE_CODE" />
                                    </AssessmentTypeCode>
                                    <AssessmentConfidenceCode>
                                      <xsl:value-of select="v1:ASSESS_CONF_CODE" />
                                    </AssessmentConfidenceCode>
                                  </AssessmentType>
                                </xsl:for-each>
                              </AssessmentTypes>
                            </xsl:if>
                            <xsl:if test="v1:ASSESS_METHOD_TYPE_ID!= ''" >
                              <AssessmentMethodTypes>
                                <xsl:for-each select="//v1:record[v1:USE_ATTAIN_ID=$USE_ATTAIN_ID][not(self::v1:record/v1:ASSESS_METHOD_TYPE_ID=following-sibling::v1:record/v1:ASSESS_METHOD_TYPE_ID)]">
                                  <AssessmentMethodType>
                                    <MethodTypeContext>
                                      <xsl:value-of select="v1:METHOD_TYPE_CONTEXT" />
                                    </MethodTypeContext>
                                    <MethodTypeCode>
                                      <xsl:value-of select="v1:METHOD_TYPE_CODE" />
                                    </MethodTypeCode>
                                    <MethodTypeName>
                                      <xsl:value-of select="v1:METHOD_TYPE_NAME" />
                                    </MethodTypeName>
                                  </AssessmentMethodType>
                                </xsl:for-each>
                              </AssessmentMethodTypes>
                            </xsl:if>
                            <xsl:if test="v1:MONITORING_START_DATE!= ''" >
                              <MonitoringActivity>
                                <MonitoringStartDate>
                                  <xsl:value-of select="v1:MONITORING_START_DATE" />
                                </MonitoringStartDate>
                                <MonitoringEndDate>
                                  <xsl:value-of select="v1:MONITORING_END_DATE" />
                                </MonitoringEndDate>
                              </MonitoringActivity>
                            </xsl:if>
                            <xsl:if test="v1:ASSESS_DATE!= ''" >
                              <AssessmentActivity>
                                <AssessmentDate>
                                  <xsl:value-of select="v1:ASSESS_DATE" />
                                </AssessmentDate>
                                <AssessorName>
                                  <xsl:value-of select="v1:ASSESSOR_NAME" />
                                </AssessorName>
                              </AssessmentActivity>
                            </xsl:if>
                          </AssessmentMetadata>
                        </xsl:if>
                        <xsl:if test="v1:STATE_QUALIFIER_TEXT!= ''" >
                          <StateQualifierText>
                            <xsl:value-of select="v1:STATE_QUALIFIER_TEXT" />
                          </StateQualifierText>
                        </xsl:if>
                        <xsl:if test="v1:USE_COMMENT!= ''" >
                          <UseCommentText>
                            <xsl:value-of select="v1:USE_COMMENT" />
                          </UseCommentText>
                        </xsl:if>
                      </UseAttainment>
                    </xsl:for-each>
                  </UseAttainments>
                  <xsl:if test="v1:PARAMETER_ID!= ''" >
                    <Parameters>
                      <xsl:for-each select="//v1:record[v1:ASSESS_ID=$ASSESS_ID][not(self::v1:record/v1:PARAMETER_ID=following-sibling::v1:record/v1:PARAMETER_ID)]">
                        <xsl:variable name="PARAMETER_ID"
                                      select="v1:PARAMETER_ID"/>
                        <Parameter>
                          <ParameterStatusName>
                            <xsl:value-of select="v1:PARAMETER_STATUS_NAME" />
                          </ParameterStatusName>
                          <ParameterName>
                            <xsl:value-of select="v1:PARAMETER_NAME" />
                          </ParameterName>
                          <xsl:if test="v1:PARAMETER_COMMENT!= ''" >
                            <ParameterCommentText>
                              <xsl:value-of select="v1:PARAMETER_COMMENT" />
                            </ParameterCommentText>
                          </xsl:if>
                          <AssociatedUses>
                            <xsl:for-each select="//v1:record[v1:PARAMETER_ID=$PARAMETER_ID][not(self::v1:record/v1:ASSOCIATED_USE_ID=following-sibling::v1:record/v1:ASSOCIATED_USE_ID)]">
                              <xsl:variable name="ASSOCIATED_USE_ID"
                                            select="v1:ASSOCIATED_USE_ID"/>
                              <AssociatedUse>
                                <AssociatedUseName>
                                  <xsl:value-of select="v1:ASSOCIATED_USE_NAME" />
                                </AssociatedUseName>
                                <ParameterAttainmentCode>
                                  <xsl:value-of select="v1:PARAMETER_ATTAIN_CODE" />
                                </ParameterAttainmentCode>
                                <xsl:if test="v1:ASSOCIATED_USE_TREND_CODE!= ''" >
                                  <TrendCode>
                                    <xsl:value-of select="v1:ASSOCIATED_USE_TREND_CODE" />
                                  </TrendCode>
                                </xsl:if>
                              </AssociatedUse>
                            </xsl:for-each>
                          </AssociatedUses>
                          <xsl:if test="v1:PARAMETER_AGENCY_CODE!= ''" >
                            <ImpairedWatersInformation>
                              <ListingInformation>
                                <AgencyCode>
                                  <xsl:value-of select="v1:PARAMETER_AGENCY_CODE" />
                                </AgencyCode>
                                <xsl:if test="v1:CYCLE_FIRST_LISTED!= ''" >
                                  <CycleFirstListedText>
                                    <xsl:value-of select="v1:CYCLE_FIRST_LISTED" />
                                  </CycleFirstListedText>
                                </xsl:if>
                                <xsl:if test="v1:CYCLE_SCHEDULED_TMDL!= ''" >
                                  <CycleScheduledForTMDLText>
                                    <xsl:value-of select="v1:CYCLE_SCHEDULED_TMDL" />
                                  </CycleScheduledForTMDLText>
                                </xsl:if>
                                <xsl:if test="v1:CWA303D_PRIORITY_RANK!= ''" >
                                  <CWA303dPriorityRankingText>
                                    <xsl:value-of select="v1:CWA303D_PRIORITY_RANK" />
                                  </CWA303dPriorityRankingText>
                                </xsl:if>
                                <xsl:if test="v1:CONSENT_DECREE_CYCLE!= ''" >
                                  <ConsentDecreeCycleText>
                                    <xsl:value-of select="v1:CONSENT_DECREE_CYCLE" />
                                  </ConsentDecreeCycleText>
                                </xsl:if>
                                <xsl:if test="v1:ALTERNATE_LISTING_IDEN!= ''" >
                                  <AlternateListingIdentifier>
                                    <xsl:value-of select="v1:ALTERNATE_LISTING_IDEN" />
                                  </AlternateListingIdentifier>
                                </xsl:if>
                              </ListingInformation>
                              <xsl:if test="v1:CYCLE_EXPECTED_ATTAIN!= ''" >
                                <Category4BInformation>
                                  <CycleExpectedToAttainText>
                                    <xsl:value-of select="v1:CYCLE_EXPECTED_ATTAIN" />
                                  </CycleExpectedToAttainText>
                                </Category4BInformation>
                              </xsl:if>
                              <xsl:if test="v1:PRIOR_CAUSE_ID!= ''" >
                                <PriorCauses>
                                  <xsl:for-each select="//v1:record[v1:PARAMETER_ID=$PARAMETER_ID][not(self::v1:record/v1:PRIOR_CAUSE_ID=following-sibling::v1:record/v1:PRIOR_CAUSE_ID)]">
                                    <PriorCause>
                                      <PriorCauseName>
                                        <xsl:value-of select="v1:PRIOR_CAUSE_NAME" />
                                      </PriorCauseName>
                                      <PriorCauseCycleText>
                                        <xsl:value-of select="v1:PRIOR_CAUSE_CYCLE" />
                                      </PriorCauseCycleText>
                                    </PriorCause>
                                  </xsl:for-each>
                                </PriorCauses>
                              </xsl:if>
                            </ImpairedWatersInformation>
                          </xsl:if>
                          <xsl:if test="v1:PARM_STATE_IR_CATEGORY_CODE!= ''" >
                            <StateIntegratedReportingCategory>
                              <StateIRCategoryCode>
                                <xsl:value-of select="v1:PARM_STATE_IR_CATEGORY_CODE" />
                              </StateIRCategoryCode>
                              <xsl:if test="v1:PARM_STATE_CATEGORY_DESC!= ''" >
                                <StateCategoryDescriptionText>
                                  <xsl:value-of select="v1:PARM_STATE_CATEGORY_DESC" />
                                </StateCategoryDescriptionText>
                              </xsl:if>
                            </StateIntegratedReportingCategory>
                          </xsl:if>
                          <xsl:if test="v1:ASSOCIATED_ACTION_IDEN!= ''" >
                            <AssociatedActions>
                              <xsl:for-each select="//v1:record[v1:PARAMETER_ID=$PARAMETER_ID][not(self::v1:record/v1:ASSOCIATED_ACTION_ID=following-sibling::v1:record/v1:ASSOCIATED_ACTION_ID)]">
                                <AssociatedAction>
                                  <AssociatedActionIdentifier>
                                    <xsl:value-of select="v1:ASSOCIATED_ACTION_IDEN" />
                                  </AssociatedActionIdentifier>
                                </AssociatedAction>
                              </xsl:for-each>
                            </AssociatedActions>
                          </xsl:if>
                          <xsl:if test="v1:POLLUTANT_IND!= ''" >
                            <PollutantIndicator>
                              <xsl:value-of select="v1:POLLUTANT_IND" />
                            </PollutantIndicator>
                          </xsl:if>
                          <xsl:if test="v1:PARM_STATE_QUAL_TEXT!= ''" >
                            <StateQualifierText>
                              <xsl:value-of select="v1:PARM_STATE_QUAL_TEXT" />
                            </StateQualifierText>
                          </xsl:if>
                        </Parameter>
                      </xsl:for-each>
                    </Parameters>
                  </xsl:if>
                  <xsl:if test="v1:PROB_SRC_ID!= ''" >
                    <ProbableSources>
                      <xsl:for-each select="//v1:record[v1:ASSESS_ID=$ASSESS_ID][not(self::v1:record/v1:PROB_SRC_ID=following-sibling::v1:record/v1:PROB_SRC_ID)]">
                        <xsl:variable name="PROB_SRC_ID"
                                      select="v1:PROB_SRC_ID"/>
                        <ProbableSource>
                          <SourceName>
                            <xsl:value-of select="v1:SRC_NAME" />
                          </SourceName>
                          <SourceConfirmedIndicator>
                            <xsl:value-of select="v1:SRC_CONFIRM_IND" />
                          </SourceConfirmedIndicator>
                          <xsl:if test="v1:ASSOC_CAUSE_NAME_ID!= ''" >
                            <AssociatedCauseNames>
                              <xsl:for-each select="//v1:record[v1:PROB_SRC_ID=$PROB_SRC_ID][not(self::v1:record/v1:ASSOC_CAUSE_NAME_ID=following-sibling::v1:record/v1:ASSOC_CAUSE_NAME_ID)]">
                                <AssociatedCauseName>
                                  <CauseName>
                                    <xsl:value-of select="v1:CAUSE_NAME" />
                                  </CauseName>
                                </AssociatedCauseName>
                              </xsl:for-each>
                            </AssociatedCauseNames>
                          </xsl:if>
                          <xsl:if test="v1:SRC_COMMENT!= ''" >
                            <SourceCommentText>
                              <xsl:value-of select="v1:SRC_COMMENT" />
                            </SourceCommentText>
                          </xsl:if>
                        </ProbableSource>
                      </xsl:for-each>
                    </ProbableSources>
                  </xsl:if>
                  <xsl:if test="v1:DOCUMENT_ID2!= ''" >
                    <Documents>
                      <xsl:for-each select="//v1:record[v1:ASSESS_ID=$ASSESS_ID][not(self::v1:record/v1:DOCUMENT_ID2=following-sibling::v1:record/v1:DOCUMENT_ID2)]">
                        <xsl:variable name="DOCUMENT_ID2"
                                      select="v1:DOCUMENT_ID2"/>
                        <Document>
                          <AgencyCode>
                            <xsl:value-of select="v1:DOCUMENT_1_AGENCY_CODE" />
                          </AgencyCode>
                          <DocumentTypes>
                            <xsl:for-each select="//v1:record[v1:DOCUMENT_ID2=$DOCUMENT_ID2][not(self::v1:record/v1:DOCUMENT_TYPE_ID1=following-sibling::v1:record/v1:DOCUMENT_TYPE_ID1)]">
                              <DocumentType>
                                <DocumentTypeCode>
                                  <xsl:value-of select="v1:DOCUMENT_TYPE_CODE1" />
                                </DocumentTypeCode>
                              </DocumentType>
                            </xsl:for-each>
                          </DocumentTypes>
                          <DocumentFileType>
                            <xsl:value-of select="v1:DOC_FILE_TYPE2" />
                          </DocumentFileType>
                          <DocumentFileName>
                            <xsl:value-of select="v1:DOC_FILE_NAME2" />
                          </DocumentFileName>
                          <DocumentName>
                            <xsl:value-of select="v1:DOC_NAME2" />
                          </DocumentName>
                          <DocumentDescription>
                            <xsl:value-of select="v1:DOC_DESC2" />
                          </DocumentDescription>
                          <DocumentComments>
                            <xsl:value-of select="v1:DOC_COMMENT2" />
                          </DocumentComments>
                          <xsl:if test="v1:DOC_URL2!= ''" >
                            <DocumentURL>
                              <xsl:value-of select="v1:DOC_URL2" />
                            </DocumentURL>
                          </xsl:if>
                        </Document>
                      </xsl:for-each>
                    </Documents>
                  </xsl:if>
                  <xsl:if test="v1:ASSESS_COMMENT!= ''" >
                    <AssessmentCommentsText>
                      <xsl:value-of select="v1:ASSESS_COMMENT" />
                    </AssessmentCommentsText>
                  </xsl:if>
                  <xsl:if test="v1:REVIEW_COMMENT_ID!= ''" >
                    <ReviewComments>
                      <xsl:for-each select="//v1:record[v1:ASSESS_ID=$ASSESS_ID][not(self::v1:record/v1:REVIEW_COMMENT_ID=following-sibling::v1:record/v1:REVIEW_COMMENT_ID)]">
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
                  <xsl:if test="v1:RATIONALE_TEXT!= ''" >
                    <RationaleText>
                      <xsl:value-of select="v1:RATIONALE_TEXT" />
                    </RationaleText>
                  </xsl:if>
                </Assessment>
              </xsl:for-each>
            </Assessments>
            <DelistedWaters>
              <xsl:for-each select="//v1:record[v1:REPORTING_CYCLE_ID=$REPORTING_CYCLE_ID][not(self::v1:record/v1:DELISTED_WATER_ID=following-sibling::v1:record/v1:DELISTED_WATER_ID)]">
                <xsl:variable name="DELISTED_WATER_ID"
                              select="v1:DELISTED_WATER_ID"/>
                <xsl:if test="v1:DELISTED_WATER_ID!= ''" >
                  <DelistedWater>
                    <AssessmentUnitIdentifier>
                      <xsl:value-of select="v1:ASSESS_UNIT_IDEN" />
                    </AssessmentUnitIdentifier>
                    <DelistedWaterCauses>
                      <xsl:for-each select="//v1:record[v1:DELISTED_WATER_ID=$DELISTED_WATER_ID][not(self::v1:record/v1:DELISTED_WATER_CAUSE_ID=following-sibling::v1:record/v1:DELISTED_WATER_CAUSE_ID)]">
                        <DelistedWaterCause>
                          <CauseName>
                            <xsl:value-of select="v1:DELISTED_WATER_CAUSE_NAME" />
                          </CauseName>
                          <AgencyCode>
                            <xsl:value-of select="v1:AGENCY_CODE" />
                          </AgencyCode>
                          <DelistingReasonCode>
                            <xsl:value-of select="v1:DELISTING_REASON_CODE" />
                          </DelistingReasonCode>
                          <DelistingCommentText>
                            <xsl:value-of select="v1:DELISTING_COMMENT" />
                          </DelistingCommentText>
                        </DelistedWaterCause>
                      </xsl:for-each>
                    </DelistedWaterCauses>
                  </DelistedWater>
                </xsl:if>
              </xsl:for-each>
            </DelistedWaters>
          </ReportingCycle>
        </xsl:for-each>
      </Organization>
    </ATTAINS>
  </xsl:template>
</xsl:stylesheet>