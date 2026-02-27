SELECT AirFacility.AirFacilityID, FacilitySiteName, LocationAddressText, SupplementalLocationText, GNISCityCode,
       LocalityName, LocationAddressCountyCode, LocationStateCode, LocationZipCode, LCONCode, TribalLandCode,
       FacilityDescription, FacilityTypeOfOwnershipCode, RegistrationNumber, SmallBusinessIndicator,
       FederallyReportableIndicator, SourceUniformResourceLocatorURL, EnvironmentalJusticeCode,
       FacilityCongressionalDistrictNumber, FacilityComments, UniverseIndicator.UniverseIndicatorId,
       UniverseIndicator.UniverseIndicatorCode, SIC.SICId, SIC.SICCode, SIC.SICPrimaryIndicatorCode, NAICS.NAICSId,
       NAICS.NAICSCode, NAICS.NAICSPrimaryIndicatorCode, FacilityUserDefinedField1, FacilityUserDefinedField2,
       FacilityUserDefinedField3, FacilityUserDefinedField4, FacilityUserDefinedField5, AirFacility.TransactionID,
       [Transaction].TransactionType,
       CONVERT(varchar(30), [Transaction].TransactionTimestamp, 126)                                               as TransactionTimestamp,
       LatitudeMeasure, LongitudeMeasure, HorizontalAccuracyMeasure, GeometricTypeCode, HorizontalCollectionMethodCode,
       HorizontalReferenceDatumCode, ReferencePointCode, SourceMapScaleNumber, UTMCoordinate1, UTMCoordinate2,
       UTMCoordinate3, PortableSource.PortableSourceIndicator, PortableSource.PortableSourceSiteName,
       PortableSourceStartDate, PortableSourceEndDate, Contact.ContactId, Contact.AffiliationTypeText, FirstName,
       MiddleName, LastName, IndividualTitleText, Contact.OrganizationFormalName, StateCode, RegionCode,
       Telephone.TelephoneID, Telephone.TelephoneNumberTypeCode, Telephone.TelephoneNumber,
       Telephone.TelephoneExtensionNumber, Contact.ElectronicAddressText, Contact.StartDateOfContactAssociation,
       Contact.EndDateOfContactAssociation, FacilityAddress.FacilityAddressID,
       FacilityAddress.AffiliationTypeText                                                                         AS AffiliationTypeText_a,
       FacilityAddress.OrganizationFormalName                                                                      AS OrganizationFormalName_a,
       FacilityAddress.OrganizationDUNSNumber, MailingAddressText, SupplementalAddressText, MailingAddressCityName,
       MailingAddressStateCode, MailingAddressZipCode, CountyName, MailingAddressCountryCode, DivisionName,
       FacilityAddress.TelephoneNumberTypeCode                                                                     AS TelephoneNumberTypeCode_a,
       FacilityAddress.TelephoneNumber                                                                             AS TelephoneNumber_a,
       FacilityAddress.TelephoneExtensionNumber                                                                    AS TelephoneExtensionNumber_a,
       FacilityAddress.ElectronicAddressText                                                                       AS ElectronicAddressText_a,
       FacilityAddress.StartDateOfAddressAssociation, FacilityAddress.EndDateOfAddressAssociation,
       FacilityAddress.LocationProvince
FROM AirFacility
    INNER JOIN [Transaction]
    ON AirFacility.TransactionID = [Transaction].TransactionID
    INNER JOIN SubmissionStatus
    ON AirFacility.TransactionID = SubmissionStatus.TransactionID
    LEFT JOIN AirGeographicCoordinate
    ON AirGeographicCoordinate.AirFacilityID = AirFacility.AirFacilityID
    LEFT JOIN GeographicCoordinate
    ON AirGeographicCoordinate.GeographicCoordinateId = GeographicCoordinate.GeographicCoordinateId
    LEFT JOIN UniverseIndicator
    ON UniverseIndicator.AirFacilityID = AirFacility.AirFacilityID
    LEFT JOIN SIC
    ON SIC.AirFacilityID = AirFacility.AirFacilityID
    LEFT JOIN NAICS
    ON NAICS.AirFacilityID = AirFacility.AirFacilityID
    LEFT JOIN PortableSource
    ON PortableSource.AirFacilityID = AirFacility.AirFacilityID
    LEFT JOIN FacilityContact
    ON FacilityContact.AirFacilityID = AirFacility.AirFacilityID
    LEFT JOIN Contact
    ON FacilityContact.ContactId = Contact.ContactID
    LEFT JOIN Telephone
    ON Contact.ContactID = Telephone.ContactID
    LEFT JOIN FacilityAddress
    ON FacilityAddress.AirFacilityID = AirFacility.AirFacilityID
WHERE SubmissionStatus.TableName = 'AirFacility'
  AND SubmissionStatus.Status is NULL
  AND SubmissionStatus.Operation <> 'delete'
--   AND SubmissionStatus.ID in ('{$AirFacilityID}')
--   AND [Transaction].TransactionTimestamp between '{$fromDate}' and '{$toDate}'