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
            <AirDAFormalEnforcementActionData xmlns="http://www.exchangenetwork.net/schema/icis/5">
                <TransactionHeader>
                    <TransactionType>R</TransactionType>
                    <TransactionTimestamp>
                        <xsl:value-of select="v1:TransactionTimestamp" />
                    </TransactionTimestamp>
                </TransactionHeader>
                <xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][not(self::v1:record/v1:EnforcementActionId=following-sibling::v1:record/v1:EnforcementActionId)]">
                    <xsl:variable name="EnforcementActionId" select="v1:EnforcementActionId"/>
                    <AirDAFormalEnforcementAction>
                        <AirDAEnforcementActionIdentifier>
                            <xsl:value-of select="v1:EnforcementActionId" />
                        </AirDAEnforcementActionIdentifier>
                            <AirFacilityIdentifier>
                                <xsl:value-of select="v1:AirFacilityId" />
                            </AirFacilityIdentifier>
                        <xsl:if test="v1:EnforcementActionName!= ''" >
                            <EnforcementActionName>
                                <xsl:value-of select="v1:EnforcementActionName" />
                            </EnforcementActionName>
                        </xsl:if>
                        <xsl:if test="v1:Forum!= ''" >
                            <Forum>
                                <xsl:value-of select="v1:Forum" />
                            </Forum>
                        </xsl:if>
                        <xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:EnforcementActionId=$EnforcementActionId][v1:CodeName='EnforcementActionTypeCode'][not(self::v1:record/v1:EnforcementActionCodeId=following-sibling::v1:record/v1:EnforcementActionCodeId)]">
                            <EnforcementActionTypeCode>
                                <xsl:value-of select="v1:CodeValue" />
                            </EnforcementActionTypeCode>
                        </xsl:for-each>
                        <xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:EnforcementActionId=$EnforcementActionId][v1:CodeName='ProgramsViolatedCode'][not(self::v1:record/v1:EnforcementActionCodeId=following-sibling::v1:record/v1:EnforcementActionCodeId)]">
                            <ProgramsViolatedCode>
                                <xsl:value-of select="v1:CodeValue" />
                            </ProgramsViolatedCode>
                        </xsl:for-each>
                        <xsl:if test="v1:OtherProgramDescriptionText!= ''" >
                            <OtherProgramDescriptionText>
                                <xsl:value-of select="v1:OtherProgramDescriptionText" />
                            </OtherProgramDescriptionText>
                        </xsl:if>
                        <xsl:if test="v1:ResolutionTypeCode!= ''" >
                            <ResolutionTypeCode>
                                <xsl:value-of select="v1:ResolutionTypeCode" />
                            </ResolutionTypeCode>
                        </xsl:if>
                        <xsl:if test="v1:AirDACombinedSupersededEAID!= ''" >
                            <AirDACombinedSupersededEAID>
                                <xsl:value-of select="v1:AirDACombinedSupersededEAID" />
                            </AirDACombinedSupersededEAID>
                        </xsl:if>
                        <xsl:if test="v1:EAUserDefinedField1!= ''" >
                            <FormalEAUserDefinedField1>
                                <xsl:value-of select="v1:EAUserDefinedField1" />
                            </FormalEAUserDefinedField1>
                        </xsl:if>
                        <xsl:if test="v1:EAUserDefinedField2!= ''" >
                            <FormalEAUserDefinedField2>
                                <xsl:value-of select="v1:EAUserDefinedField2" />
                            </FormalEAUserDefinedField2>
                        </xsl:if>
                        <xsl:if test="v1:EAUserDefinedField3!= ''" >
                            <FormalEAUserDefinedField3>
                                <xsl:value-of select="v1:EAUserDefinedField3" />
                            </FormalEAUserDefinedField3>
                        </xsl:if>
                        <xsl:if test="v1:EAUserDefinedField4!= ''" >
                            <FormalEAUserDefinedField4>
                                <xsl:value-of select="v1:EAUserDefinedField4" />
                            </FormalEAUserDefinedField4>
                        </xsl:if>
                        <xsl:if test="v1:EAUserDefinedField5!= ''" >
                            <FormalEAUserDefinedField5>
                                <xsl:value-of select="v1:EAUserDefinedField5" />
                            </FormalEAUserDefinedField5>
                        </xsl:if>
                        <xsl:if test="v1:EAUserDefinedField6!= ''" >
                            <FormalEAUserDefinedField6>
                                <xsl:value-of select="v1:EAUserDefinedField6" />
                            </FormalEAUserDefinedField6>
                        </xsl:if>
                        <xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:EnforcementActionId=$EnforcementActionId][v1:AirDAFinalOrderId!=''][not(self::v1:record/v1:AirDAFinalOrderId=following-sibling::v1:record/v1:AirDAFinalOrderId)]">
                            <AirDAFinalOrder>
                                <FinalOrderIdentifier>
                                    <xsl:value-of select="v1:FinalOrderIdentifier" />
                                </FinalOrderIdentifier>
                                <FinalOrderTypeCode>
                                    <xsl:value-of select="v1:FinalOrderTypeCode" />
                                </FinalOrderTypeCode>
                                <FinalOrderAirFacilityIdentifier>
                                    <xsl:value-of select="v1:FinalOrderAirFacilityIdentifier" />
                                </FinalOrderAirFacilityIdentifier>
                                <xsl:if test="v1:FinalOrderLodgedDate!= ''" >
                                    <FinalOrderLodgedDate>
                                        <xsl:value-of select="v1:FinalOrderLodgedDate" />
                                    </FinalOrderLodgedDate>
                                </xsl:if>
                                <xsl:if test="v1:FinalOrderIssuedEnteredDate!= ''" >
                                <FinalOrderIssuedEnteredDate>
                                    <xsl:value-of select="v1:FinalOrderIssuedEnteredDate" />
                                </FinalOrderIssuedEnteredDate>
                                </xsl:if>
                                <xsl:if test="v1:AirEnforcementActionResolvedDate!= ''" >
                                <AirResolvedDate>
                                    <xsl:value-of select="v1:AirEnforcementActionResolvedDate" />
                                </AirResolvedDate>
                                </xsl:if>
                                <xsl:if test="v1:CashCivilPenaltyRequiredAmount!= ''" >
                                <CashCivilPenaltyRequiredAmount>
                                    <xsl:value-of select="v1:CashCivilPenaltyRequiredAmount" />
                                </CashCivilPenaltyRequiredAmount>
                                </xsl:if>
                                <xsl:if test="v1:OtherComments!= ''" >
                                <OtherComments>
                                    <xsl:value-of select="v1:OtherComments" />
                                </OtherComments>
                                </xsl:if>
                                <xsl:if test="v1:DemandStipulatedPenaltyAmount!= ''" >
                                    <DemandStipulatedPenaltyData>
                                        <DemandStipulatedPenaltyAmount>
                                            <xsl:value-of select="v1:DemandStipulatedPenaltyAmount" />
                                        </DemandStipulatedPenaltyAmount>
                                        <DemandStipulatedPenaltyPaidDate>
                                            <xsl:value-of select="v1:DemandStipulatedPenaltyPaidDate" />
                                        </DemandStipulatedPenaltyPaidDate>
                                    </DemandStipulatedPenaltyData>
                                </xsl:if>
                            </AirDAFinalOrder>
                        </xsl:for-each>
                        <LeadAgencyCode>
                            <xsl:value-of select="v1:LeadAgencyCode" />
                        </LeadAgencyCode>
                        <xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:EnforcementActionId=$EnforcementActionId][v1:CodeName='EnforcementAgencyTypeCode'][not(self::v1:record/v1:EnforcementActionCodeId=following-sibling::v1:record/v1:EnforcementActionCodeId)]">
                            <EnforcementAgencyTypeCode>
                                <xsl:value-of select="v1:CodeValue" />
                            </EnforcementAgencyTypeCode>
                        </xsl:for-each>
                        <xsl:if test="v1:EnforcementAgencyName!= ''" >
                        <EnforcementAgencyName>
                            <xsl:value-of select="v1:EnforcementAgencyName" />
                        </EnforcementAgencyName>
                        </xsl:if>
                        <xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:EnforcementActionId=$EnforcementActionId][v1:ElectronicAddressText!=''][not(self::v1:record/v1:ContactId=following-sibling::v1:record/v1:ContactId)]">
                            <EnforcementActionGovernmentContact>
                                <xsl:if test="v1:AffiliationTypeText!= ''" >
                                    <AffiliationTypeText>
                                        <xsl:value-of select="v1:AffiliationTypeText" />
                                    </AffiliationTypeText>
                                </xsl:if>
                                <ElectronicAddressText>
                                    <xsl:value-of select="v1:ElectronicAddressText" />
                                </ElectronicAddressText>
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
                            </EnforcementActionGovernmentContact>
                        </xsl:for-each>
                        <xsl:if test="v1:OtherAgencyInitiativeText!= ''" >
                        <OtherAgencyInitiativeText>
                            <xsl:value-of select="v1:OtherAgencyInitiativeText" />
                        </OtherAgencyInitiativeText>
                        </xsl:if>
                        <xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:EnforcementActionId=$EnforcementActionId][v1:CodeName='AirPollutantCode'][not(self::v1:record/v1:EnforcementActionCodeId=following-sibling::v1:record/v1:EnforcementActionCodeId)]">
                            <AirPollutantCode>
                                <xsl:value-of select="v1:CodeValue" />
                            </AirPollutantCode>
                        </xsl:for-each>
                        <xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:EnforcementActionId=$EnforcementActionId][v1:CommentName='EnforcementActionCommentText'][not(self::v1:record/v1:EAInspectionCommentId=following-sibling::v1:record/v1:EAInspectionCommentId)]">
                            <EnforcementActionCommentText>
                                <xsl:value-of select="v1:CommentText" />
                            </EnforcementActionCommentText>
                        </xsl:for-each>
                        <xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:EnforcementActionId=$EnforcementActionId][v1:CommentName='SensitiveCommentText'][not(self::v1:record/v1:EAInspectionCommentId=following-sibling::v1:record/v1:EAInspectionCommentId)]">
                            <SensitiveCommentText>
                                <xsl:value-of select="v1:CommentText" />
                            </SensitiveCommentText>
                        </xsl:for-each>
                    </AirDAFormalEnforcementAction>
                </xsl:for-each>
            </AirDAFormalEnforcementActionData>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>