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
		<AirFacilityData xmlns="http://www.exchangenetwork.net/schema/icis/5">
			<TransactionHeader>
				<TransactionType>
					<xsl:value-of select="v1:TransactionType" />
				</TransactionType>
				<TransactionTimestamp>
					<xsl:value-of select="v1:TransactionTimestamp" />
				</TransactionTimestamp>
			</TransactionHeader>
			<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][not(self::v1:record/v1:AirFacilityID=following-sibling::v1:record/v1:AirFacilityID)]">
            <xsl:variable name="AirFacilityID" select="v1:AirFacilityID"/>
            <AirFacility>
					<AirFacilityIdentifier>
						<xsl:value-of select="v1:AirFacilityID" />
					</AirFacilityIdentifier>
					<FacilitySiteName>
						<xsl:value-of select="v1:FacilitySiteName" />
					</FacilitySiteName>
					<LocationAddressText>
						<xsl:value-of select="v1:LocationAddressText" />
					</LocationAddressText>
					<xsl:if test="v1:SupplementalLocationText!= ''" >
					<SupplementalLocationText>
						<xsl:value-of select="v1:SupplementalLocationText" />
					</SupplementalLocationText>
					</xsl:if>
					<xsl:if test="v1:GNISCityCode!= ''" >
					<LocationAddressCityCode >
						<xsl:value-of select="v1:GNISCityCode" />
					</LocationAddressCityCode >
					</xsl:if>
					<xsl:if test="v1:LocalityName!= ''" >
					<LocalityName >
						<xsl:value-of select="v1:LocalityName" />
					</LocalityName >
					<LocationAddressCountyCode >
						<xsl:value-of select="v1:LocationAddressCountyCode" />
					</LocationAddressCountyCode >
					</xsl:if>
					<xsl:if test="v1:LocationStateCode!= ''" >
					<LocationStateCode>
						<xsl:value-of select="v1:LocationStateCode" />
					</LocationStateCode>
					</xsl:if>
					<xsl:if test="v1:LocationZipCode!= ''" >
					<LocationZipCode>
						<xsl:value-of select="v1:LocationZipCode" />
					</LocationZipCode>
					</xsl:if>
					<xsl:if test="v1:LCONCode!= ''" >
					<LCONCode>
						<xsl:value-of select="v1:LCONCode" />
					</LCONCode>
					</xsl:if>
					<xsl:if test="v1:TribalLandCode!= ''" >
					<TribalLandCode>
						<xsl:value-of select="v1:TribalLandCode" />
					</TribalLandCode>
					</xsl:if>
					<xsl:if test="v1:FacilityDescription!= ''" >
					<FacilityDescription>
						<xsl:value-of select="v1:FacilityDescription" />
					</FacilityDescription>
					</xsl:if>
					<xsl:if test="v1:FacilityTypeOfOwnershipCode!= ''" >
					<FacilityTypeOfOwnershipCode>
						<xsl:value-of select="v1:FacilityTypeOfOwnershipCode" />
					</FacilityTypeOfOwnershipCode>
					</xsl:if>
					<xsl:if test="v1:RegistrationNumber!= ''" >
					<RegistrationNumber>
						<xsl:value-of select="v1:RegistrationNumber" />
					</RegistrationNumber>
					</xsl:if>
					<xsl:if test="v1:SmallBusinessIndicator!= ''" >
					<SmallBusinessIndicator>
						<xsl:value-of select="v1:SmallBusinessIndicator" />
					</SmallBusinessIndicator>
					</xsl:if>
					<xsl:if test="v1:FederallyReportableIndicator!= ''" >
					<FederallyReportableIndicator>
						<xsl:value-of select="v1:FederallyReportableIndicator" />
					</FederallyReportableIndicator>
					</xsl:if>
					<xsl:if test="v1:SourceUniformResourceLocatorURL!= ''" >
					<SourceUniformResourceLocatorURL>
						<xsl:value-of select="v1:SourceUniformResourceLocatorURL" />
					</SourceUniformResourceLocatorURL>
					</xsl:if>
					<xsl:if test="v1:EnvironmentalJusticeCode!= ''" >
					<EnvironmentalJusticeCode>
						<xsl:value-of select="v1:EnvironmentalJusticeCode" />
					</EnvironmentalJusticeCode>
					</xsl:if>
					<xsl:if test="v1:FacilityCongressionalDistrictNumber!= ''" >
					<FacilityCongressionalDistrictNumber>
						<xsl:value-of select="v1:FacilityCongressionalDistrictNumber" />
					</FacilityCongressionalDistrictNumber>
					</xsl:if>
					<xsl:if test="v1:FacilityUserDefinedField1!= ''" >
					<FacilityUserDefinedField1>
						<xsl:value-of select="v1:FacilityUserDefinedField1" />
					</FacilityUserDefinedField1>
					</xsl:if>
					<xsl:if test="v1:FacilityUserDefinedField2!= ''" >
					<FacilityUserDefinedField2>
						<xsl:value-of select="v1:FacilityUserDefinedField2" />
					</FacilityUserDefinedField2>
					</xsl:if>
					<xsl:if test="v1:FacilityUserDefinedField3!= ''" >
					<FacilityUserDefinedField3>
						<xsl:value-of select="v1:FacilityUserDefinedField3" />
					</FacilityUserDefinedField3>
					</xsl:if>
					<xsl:if test="v1:FacilityUserDefinedField4!= ''" >
					<FacilityUserDefinedField4>
						<xsl:value-of select="v1:FacilityUserDefinedField4" />
					</FacilityUserDefinedField4>
					</xsl:if>
					<xsl:if test="v1:FacilityUserDefinedField5!= ''" >
					<FacilityUserDefinedField5>
						<xsl:value-of select="v1:FacilityUserDefinedField5" />
					</FacilityUserDefinedField5>
					</xsl:if>
					<xsl:if test="v1:FacilityComments!= ''" >
					<FacilityComments>
						<xsl:value-of select="v1:FacilityComments" />
					</FacilityComments>
					</xsl:if>
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:AirFacilityID=$AirFacilityID][not(self::v1:record/v1:UniverseIndicatorId=following-sibling::v1:record/v1:UniverseIndicatorId)]">
					<xsl:if test="v1:UniverseIndicatorCode!= ''" >
					<UniverseIndicatorCode>
						<xsl:value-of select="v1:UniverseIndicatorCode" />
					</UniverseIndicatorCode>
					</xsl:if>
					</xsl:for-each>
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:AirFacilityID=$AirFacilityID][not(self::v1:record/v1:SICId=following-sibling::v1:record/v1:SICId)]">
					<xsl:if test="v1:SICCode!= ''" >
					<SICCodeDetails>
						<SICCode>
							<xsl:value-of select="v1:SICCode" />
						</SICCode>
						<xsl:if test="v1:SICPrimaryIndicatorCode!= ''" >
						<SICPrimaryIndicatorCode>
							<xsl:value-of select="v1:SICPrimaryIndicatorCode" />
						</SICPrimaryIndicatorCode>
						</xsl:if>
					</SICCodeDetails>
					</xsl:if>
					</xsl:for-each>
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:AirFacilityID=$AirFacilityID][not(self::v1:record/v1:NAICSId=following-sibling::v1:record/v1:NAICSId)]">
					<xsl:if test="v1:NAICSCode!= ''" >
					<NAICSCodeDetails>
						<NAICSCode>
							<xsl:value-of select="v1:NAICSCode" />
						</NAICSCode>
						<xsl:if test="v1:NAICSPrimaryIndicatorCode!= ''" >
						<NAICSPrimaryIndicatorCode>
							<xsl:value-of select="v1:NAICSPrimaryIndicatorCode" />
						</NAICSPrimaryIndicatorCode>
						</xsl:if>
					</NAICSCodeDetails>
					</xsl:if>
					</xsl:for-each>
					<xsl:if test="v1:LatitudeMeasure!= ''" >
					<AirGeographicCoordinateData>
						<LatitudeMeasure>
							<xsl:value-of select="v1:LatitudeMeasure" />
						</LatitudeMeasure>
						<xsl:if test="v1:LongitudeMeasure!= ''" >
						<LongitudeMeasure>
							<xsl:value-of select="v1:LongitudeMeasure" />
						</LongitudeMeasure>
						</xsl:if>
						<xsl:if test="v1:HorizontalAccuracyMeasure!= ''" >
						<HorizontalAccuracyMeasure>
							<xsl:value-of select="v1:HorizontalAccuracyMeasure" />
						</HorizontalAccuracyMeasure>
						</xsl:if>
						<xsl:if test="v1:GeometricTypeCode!= ''" >
						<GeometricTypeCode>
							<xsl:value-of select="v1:GeometricTypeCode" />
						</GeometricTypeCode>
						</xsl:if>
						<xsl:if test="v1:HorizontalCollectionMethodCode!= ''" >
						<HorizontalCollectionMethodCode>
							<xsl:value-of select="v1:HorizontalCollectionMethodCode" />
						</HorizontalCollectionMethodCode>
						</xsl:if>
						<xsl:if test="v1:HorizontalReferenceDatumCode!= ''" >
						<HorizontalReferenceDatumCode>
							<xsl:value-of select="v1:HorizontalReferenceDatumCode" />
						</HorizontalReferenceDatumCode>
						</xsl:if>
						<xsl:if test="v1:ReferencePointCode!= ''" >
						<ReferencePointCode>
							<xsl:value-of select="v1:ReferencePointCode" />
						</ReferencePointCode>
						</xsl:if>
						<xsl:if test="v1:SourceMapScaleNumber!= ''" >
						<SourceMapScaleNumber>
							<xsl:value-of select="v1:SourceMapScaleNumber" />
						</SourceMapScaleNumber>
						</xsl:if>
						<xsl:if test="v1:UTMCoordinate1!= ''" >
						<UTMCoordinate1>
							<xsl:value-of select="v1:UTMCoordinate1" />
						</UTMCoordinate1>
						</xsl:if>
						<xsl:if test="v1:UTMCoordinate2!= ''" >
						<UTMCoordinate2>
							<xsl:value-of select="v1:UTMCoordinate2" />
						</UTMCoordinate2>
						</xsl:if>
						<xsl:if test="v1:UTMCoordinate3!= ''" >
						<UTMCoordinate3>
							<xsl:value-of select="v1:UTMCoordinate3" />
						</UTMCoordinate3>
						</xsl:if>
					</AirGeographicCoordinateData>
					</xsl:if>
					<xsl:if test="v1:PortableSourceSiteName!= ''" >
					<PortableSourceData>
						<xsl:if test="v1:PortableSourceIndicator!= ''" >
						<PortableSourceIndicator>
							<xsl:value-of select="v1:PortableSourceIndicator" />
						</PortableSourceIndicator>
						</xsl:if>
						<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:AirFacilityID=$AirFacilityID][not(self::v1:record/v1:PortableSourceSiteName=following-sibling::v1:record/v1:PortableSourceSiteName)]">
						<PortableSource>
							<PortableSourceSiteName>
								<xsl:value-of select="v1:PortableSourceSiteName" />
							</PortableSourceSiteName>
							<xsl:if test="v1:PortableSourceStartDate!= ''" >
							<PortableSourceStartDate>
								<xsl:value-of select="v1:PortableSourceStartDate" />
							</PortableSourceStartDate>
							</xsl:if>
							<xsl:if test="v1:PortableSourceEndDate!= ''" >
							<PortableSourceEndDate>
								<xsl:value-of select="v1:PortableSourceEndDate" />
							</PortableSourceEndDate>
							</xsl:if>
						</PortableSource>
						</xsl:for-each>
					</PortableSourceData>
					</xsl:if>
					<xsl:if test="v1:FirstName!= ''" >
					<FacilityContact>
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:AirFacilityID=$AirFacilityID][not(self::v1:record/v1:ContactId=following-sibling::v1:record/v1:ContactId)]">
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
							<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:AirFacilityID=$AirFacilityID][v1:ContactId=$ContactId][not(self::v1:record/v1:TelephoneID=following-sibling::v1:record/v1:TelephoneID)]">
							<xsl:if test="v1:TelephoneNumber!= ''" >
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
							</xsl:if>
							</xsl:for-each>
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
					</FacilityContact>
					</xsl:if>
					<xsl:for-each select="//v1:record[v1:TransactionID=$TransactionID][v1:AirFacilityID=$AirFacilityID][not(self::v1:record/v1:FacilityAddressID=following-sibling::v1:record/v1:FacilityAddressID)]">
					<xsl:if test="v1:OrganizationFormalName_a != ''" >
					<FacilityAddress>
						<Address>
							<xsl:if test="v1:AffiliationTypeText_a != ''" >
							<AffiliationTypeText>
								<xsl:value-of select="v1:AffiliationTypeText_a" />
							</AffiliationTypeText>
							</xsl:if>
							<OrganizationFormalName>
								<xsl:value-of select="v1:OrganizationFormalName_a" />
							</OrganizationFormalName>
							<xsl:if test="v1:OrganizationDUNSNumber != ''" >
							<OrganizationDUNSNumber>
								<xsl:value-of select="v1:OrganizationDUNSNumber" />
							</OrganizationDUNSNumber>
							</xsl:if>
							<xsl:if test="v1:MailingAddressText != ''" >
							<MailingAddressText>
								<xsl:value-of select="v1:MailingAddressText" />
							</MailingAddressText>
							</xsl:if>
							<xsl:if test="v1:SupplementalAddressText != ''" >
							<SupplementalAddressText>
								<xsl:value-of select="v1:SupplementalAddressText" />
							</SupplementalAddressText>
							</xsl:if>
							<xsl:if test="v1:MailingAddressCityName != ''" >
							<MailingAddressCityName>
								<xsl:value-of select="v1:MailingAddressCityName" />
							</MailingAddressCityName>
							</xsl:if>
							<xsl:if test="v1:MailingAddressStateCode != ''" >
							<MailingAddressStateCode>
								<xsl:value-of select="v1:MailingAddressStateCode" />
							</MailingAddressStateCode>
							</xsl:if>
							<xsl:if test="v1:MailingAddressZipCode != ''" >
							<MailingAddressZipCode>
								<xsl:value-of select="v1:MailingAddressZipCode" />
							</MailingAddressZipCode>
							</xsl:if>
							<xsl:if test="v1:CountyName != ''" >
							<CountyName>
								<xsl:value-of select="v1:CountyName" />
							</CountyName>
							</xsl:if>
							<xsl:if test="v1:MailingAddressCountryCode != ''" >
							<MailingAddressCountryCode>
								<xsl:value-of select="v1:MailingAddressCountryCode" />
							</MailingAddressCountryCode>
							</xsl:if>
							<xsl:if test="v1:DivisionName != ''" >
							<DivisionName>
								<xsl:value-of select="v1:DivisionName" />
							</DivisionName>
							</xsl:if>
							<xsl:if test="v1:LocationProvince != ''" >
							<LocationProvince>
								<xsl:value-of select="v1:LocationProvince" />
							</LocationProvince>
							</xsl:if>
							<xsl:if test="v1:TelephoneNumber_a != ''" >
							<Telephone>
								<xsl:if test="v1:TelephoneNumberTypeCode_a != ''" >
								<TelephoneNumberTypeCode>
									<xsl:value-of select="v1:TelephoneNumberTypeCode_a" />
								</TelephoneNumberTypeCode>
								</xsl:if>
								<TelephoneNumber>
									<xsl:value-of select="v1:TelephoneNumber_a" />
								</TelephoneNumber>
								<xsl:if test="v1:TelephoneExtensionNumber_a != ''" >
								<TelephoneExtensionNumber>
									<xsl:value-of select="v1:TelephoneExtensionNumber_a" />
								</TelephoneExtensionNumber>
								</xsl:if>
							</Telephone>
							</xsl:if>
							<xsl:if test="v1:ElectronicAddressText_a != ''" >
							<ElectronicAddressText>
								<xsl:value-of select="v1:ElectronicAddressText_a" />
							</ElectronicAddressText>
							</xsl:if>
							<xsl:if test="v1:StartDateOfAddressAssociation != ''" >
							<StartDateOfAddressAssociation>
								<xsl:value-of select="v1:StartDateOfAddressAssociation" />
							</StartDateOfAddressAssociation>
							</xsl:if>
							<xsl:if test="v1:EndDateOfAddressAssociation != ''" >
							<EndDateOfAddressAssociation>
								<xsl:value-of select="v1:EndDateOfAddressAssociation" />
							</EndDateOfAddressAssociation>
							</xsl:if>
						</Address>
					</FacilityAddress>
					</xsl:if>
					</xsl:for-each>
            </AirFacility>
			</xsl:for-each>
        </AirFacilityData>
		</xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
