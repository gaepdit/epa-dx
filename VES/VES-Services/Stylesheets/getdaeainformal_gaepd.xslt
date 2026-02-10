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
            <AirDAInformalEnforcementActionData xmlns="http://www.exchangenetwork.net/schema/icis/5">
                <TransactionHeader>
                    <TransactionType>R</TransactionType>
                    <TransactionTimestamp>
                        <xsl:value-of select="v1:TransactionTimestamp" />
                    </TransactionTimestamp>
                </TransactionHeader>
                <xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][not(self::v1:record/v1:EnforcementActionId=following-sibling::v1:record/v1:EnforcementActionId)]">
                    <xsl:variable name="EnforcementActionId" select="v1:EnforcementActionId"/>
                    <xsl:variable name="AirFacilityId" select="v1:AirFacilityId"/>
                    <AirDAInformalEnforcementAction>
                        <AirDAEnforcementActionIdentifier>
                            <xsl:value-of select="v1:EnforcementActionId" />
                        </AirDAEnforcementActionIdentifier>
                        <AirFacilityIdentifier>
                            <xsl:value-of select="v1:AirFacilityId" />
                        </AirFacilityIdentifier>
                        <EnforcementActionTypeCode>
                            <xsl:value-of select="v1:EnforcementActionTypeCode" />
                        </EnforcementActionTypeCode>
                        <xsl:if test="v1:EnforcementActionName!= ''" >
                            <EnforcementActionName>
                                <xsl:value-of select="v1:EnforcementActionName" />
                            </EnforcementActionName>
                        </xsl:if>
                        <xsl:if test="v1:AchievedDate!= ''" >
                            <AchievedDate>
                                <xsl:value-of select="v1:AchievedDate" />
                            </AchievedDate>
                        </xsl:if>
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
                        <xsl:if test="v1:FileNumber!= ''" >
                            <FileNumber>
                                <xsl:value-of select="v1:FileNumber" />
                            </FileNumber>
                        </xsl:if>
                        <xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:EnforcementActionId=$EnforcementActionId][v1:CommentName='InformalEACommentText'][not(self::v1:record/v1:EAInspectionCommentId=following-sibling::v1:record/v1:EAInspectionCommentId)]">
                            <InformalEACommentText>
                                <xsl:value-of select="v1:CommentText" />
                            </InformalEACommentText>
                        </xsl:for-each>
                        <xsl:if test="v1:EAUserDefinedField1!= ''" >
                            <InformalEAUserDefinedField1>
                                <xsl:value-of select="v1:EAUserDefinedField1" />
                            </InformalEAUserDefinedField1>
                        </xsl:if>
                        <xsl:if test="v1:EAUserDefinedField2!= ''" >
                            <InformalEAUserDefinedField2>
                                <xsl:value-of select="v1:EAUserDefinedField2" />
                            </InformalEAUserDefinedField2>
                        </xsl:if>
                        <xsl:if test="v1:EAUserDefinedField3!= ''" >
                            <InformalEAUserDefinedField3>
                                <xsl:value-of select="v1:EAUserDefinedField3" />
                            </InformalEAUserDefinedField3>
                        </xsl:if>
                        <xsl:if test="v1:EAUserDefinedField4!= ''" >
                            <InformalEAUserDefinedField4>
                                <xsl:value-of select="v1:EAUserDefinedField4" />
                            </InformalEAUserDefinedField4>
                        </xsl:if>
                        <xsl:if test="v1:EAUserDefinedField5!= ''" >
                            <InformalEAUserDefinedField5>
                                <xsl:value-of select="v1:EAUserDefinedField5" />
                            </InformalEAUserDefinedField5>
                        </xsl:if>
                        <xsl:if test="v1:EAUserDefinedField6!= ''" >
                            <InformalEAUserDefinedField6>
                                <xsl:value-of select="v1:EAUserDefinedField6" />
                            </InformalEAUserDefinedField6>
                        </xsl:if>
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
                        <xsl:if test="v1:StateSectionsViolatedText!= ''" >
                            <StateSectionsViolatedText>
                                <xsl:value-of select="v1:StateSectionsViolatedText" />
                            </StateSectionsViolatedText>
                        </xsl:if>
                        <xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:EnforcementActionId=$EnforcementActionId][v1:CommentName='SensitiveCommentText'][not(self::v1:record/v1:EAInspectionCommentId=following-sibling::v1:record/v1:EAInspectionCommentId)]">
                            <SensitiveCommentText>
                                <xsl:value-of select="v1:CommentText" />
                            </SensitiveCommentText>
                        </xsl:for-each>
                    </AirDAInformalEnforcementAction>
                </xsl:for-each>
            </AirDAInformalEnforcementActionData>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>