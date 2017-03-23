<?xml version="1.0" encoding="ISO-8859-1"?>
<!--

-->
<xsl:stylesheet version="1.0" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cc="http://www.cultuurdatabank.be/XMLSchema/Culture_CS" xmlns:sc="http://www.cultuurdatabank.be/XMLSchema/SA_comp" xmlns:ad="http://www.cultuurdatabank.be/XMLSchema/address" xmlns:ca="http://www.cultuurdatabank.be/XMLSchema/categorisation" xmlns:ci="http://www.cultuurdatabank.be/XMLSchema/city_area" xmlns:ct="http://www.cultuurdatabank.be/XMLSchema/city_comp" xmlns:co="http://www.cultuurdatabank.be/XMLSchema/country" xmlns:ec="http://www.cultuurdatabank.be/XMLSchema/event_cluster" xmlns:ed="http://www.cultuurdatabank.be/XMLSchema/event_date" xmlns:gc="http://www.cultuurdatabank.be/XMLSchema/gis_comp" xmlns:lc="http://www.cultuurdatabank.be/XMLSchema/language_comp" xmlns:mc="http://www.cultuurdatabank.be/XMLSchema/mail_comp" xmlns:me="http://www.cultuurdatabank.be/XMLSchema/media" xmlns:md="http://www.cultuurdatabank.be/XMLSchema/metadata" xmlns:na="http://www.cultuurdatabank.be/XMLSchema/name_comp" xmlns:no="http://www.cultuurdatabank.be/XMLSchema/note_comp" xmlns:ot="http://www.cultuurdatabank.be/XMLSchema/opening_times" xmlns:or="http://www.cultuurdatabank.be/XMLSchema/organisation" xmlns:pe="http://www.cultuurdatabank.be/XMLSchema/person" xmlns:ph="http://www.cultuurdatabank.be/XMLSchema/phone" xmlns:pr="http://www.cultuurdatabank.be/XMLSchema/price" xmlns:ref="http://www.cultuurdatabank.be/XMLSchema/reference_item" xmlns:rn="http://www.cultuurdatabank.be/XMLSchema/region_nat" xmlns:rel="http://www.cultuurdatabank.be/XMLSchema/relation_item" xmlns:sp="http://www.cultuurdatabank.be/XMLSchema/street_part" xmlns:uc="http://www.cultuurdatabank.be/XMLSchema/url_comp" xmlns:zc="http://www.cultuurdatabank.be/XMLSchema/zip_codes" xmlns:xalan="http://xml.apache.org/xalan" xmlns:java="http://xml.apache.org/xalan/java" xmlns:extfun="external_functions" exclude-result-prefixes="n1 xs zc uc sp rel rn ref pr ph pe or ot no na me mc lc gc ed co ct ci ca ad sc cc java">
	<xsl:output method="xml" encoding="ISO-8859-1" indent="no"/>
	<!--				-->
	<!-- We need to check that the locations belonging to the GHGP list have the correct objectids that have been sent to VRT  -->
	<!-- For each location check if it has a category of Lokaal, Regionaal, Nationaal, Internationaal and if so check that its  		-->
	<!-- cdbid and title match those in GHGP_List.xml																														-->
	<!-- Note that every organisation in the GHGP list has a category of either Lokaal, Regionaal, Nationaal or Internationaal		-->
	<!-- but that not all organisations with categories Lokaal, Regionaal, Nationaal or Internationaal are in the GHGP list				-->
	<!-- Note that an organisation name can appear in the GHGP list more than once, with different objectids								-->
	<!-- Do this also for organisers -->
	<!--				-->
	<xsl:param name="ghgp_list" select="'read_only\GHGP_List.xml'"/>
	<xsl:template match="/n1:cdbxml">
		<cdbxml>
			<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL
		http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL/CdbXSD.xsd</xsl:attribute>
			<xsl:copy-of select="n1:metadata"/>
			<events>
				<xsl:for-each select="n1:events">
					<xsl:for-each select="n1:event">
						<xsl:variable name="location_id">
							<xsl:value-of select="n1:location/n1:actor/@cdbid"/>
						</xsl:variable>
						<xsl:variable name="event_name">
							<xsl:value-of select="n1:eventdetails/n1:eventdetail/n1:title"/>
						</xsl:variable>
						<xsl:variable name="event_id">
							<xsl:value-of select="@cdbid"/>
						</xsl:variable>
						<xsl:variable name="location_name">
							<xsl:value-of select="n1:location/n1:actor/n1:actordetails/n1:actordetail/n1:title"/>
						</xsl:variable>
						<xsl:variable name="organiser_id">
							<xsl:value-of select="n1:organiser/n1:actor/@cdbid"/>
						</xsl:variable>
						<xsl:variable name="organiser_name">
							<xsl:value-of select="n1:organiser/n1:actor/n1:actordetails/n1:actordetail/n1:title"/>
						</xsl:variable>
						<xsl:choose>
							<xsl:when test="string(n1:location/n1:actor/n1:actorcategories/n1:publicscope) = 'Lokaal' or
											string(n1:location/n1:actor/n1:actorcategories/n1:publicscope) = 'Regionaal' or
											string(n1:location/n1:actor/n1:actorcategories/n1:publicscope) = 'Nationaal' or
											string(n1:location/n1:actor/n1:actorcategories/n1:publicscope) = 'Internationaal' or
											string(n1:organiser/n1:actor/n1:actorcategories/n1:publicscope) = 'Lokaal' or
											string(n1:organiser/n1:actor/n1:actorcategories/n1:publicscope) = 'Regionaal' or
											string(n1:organiser/n1:actor/n1:actorcategories/n1:publicscope) = 'Nationaal' or
											string(n1:organiser/n1:actor/n1:actorcategories/n1:publicscope) = 'Internationaal'">
								<!-- find out if the organisation is in the list -->
								<xsl:variable name="loc_add_to_xml">
									<xsl:for-each select="document($ghgp_list)/Import/Row[label_x0020_organisatie_x0020_CDB = $location_name]">
										<!-- get the id from the list -->
										<xsl:variable name="id_from_list">
											<xsl:value-of select="./CultuurDatabank_x0020_ID_x0020__x0028_GUID_x0029_"/>
										</xsl:variable>
										<xsl:if test="string($id_from_list) = string($location_id)">
											<xsl:value-of select="'OK'"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:variable>
								<xsl:variable name="org_add_to_xml">
									<xsl:for-each select="document($ghgp_list)/Import/Row[label_x0020_organisatie_x0020_CDB = $organiser_name]">
										<!-- get the id from the list -->
										<xsl:variable name="id_from_list">
											<xsl:value-of select="./CultuurDatabank_x0020_ID_x0020__x0028_GUID_x0029_"/>
										</xsl:variable>
										<xsl:if test="string($id_from_list) = string($organiser_id)">
											<xsl:value-of select="'OK'"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:variable>
								<!--
								<xsl:value-of select="$add_to_xml"/>
								-->
								<!-- check if the organisation is in the GHGP list -->
								<xsl:variable name="row_from_list_loc">
									<xsl:value-of select="document($ghgp_list)/Import/Row[label_x0020_organisatie_x0020_CDB = $location_name]"/>
								</xsl:variable>
								<xsl:variable name="row_from_list_org">
									<xsl:value-of select="document($ghgp_list)/Import/Row[label_x0020_organisatie_x0020_CDB = $organiser_name]"/>
								</xsl:variable>
								<!--
								xxxxx
								<xsl:value-of select="$loc_add_to_xml"></xsl:value-of>/
								<xsl:value-of select="$row_from_list_loc"></xsl:value-of>/
								<xsl:value-of select="$org_add_to_xml"></xsl:value-of>/
								<xsl:value-of select="$row_from_list_org"></xsl:value-of>/
								<xsl:value-of select="(contains($loc_add_to_xml,'OK') or string($row_from_list_loc) = '')"></xsl:value-of>/
								<xsl:value-of select="(contains($org_add_to_xml,'OK') or string($row_from_list_org) = '')"></xsl:value-of>
								zzzzz
-->
								<xsl:choose>
									<xsl:when test="(contains($loc_add_to_xml,'OK') or string($row_from_list_loc) = '') and (contains($org_add_to_xml,'OK') or string($row_from_list_org) = '')">
										<xsl:copy-of select="."/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="not(contains($org_add_to_xml,'OK') or string($row_from_list_org) = '')">
												<xsl:value-of select="'FAILED '"/>
												<xsl:value-of select="'check organiser '"/>
												<xsl:value-of select="$organiser_name"/>
												<xsl:value-of select="' / '"/>
												<xsl:value-of select="$organiser_id"/>
												<xsl:value-of select="'  in event '"/>
												<xsl:value-of select="$event_name"/>
												<xsl:value-of select="' / '"/>
												<xsl:value-of select="$event_id"/>
												<xsl:copy-of select="."/>
											</xsl:when>
											<xsl:when test="not(contains($loc_add_to_xml,'OK') or string($row_from_list_loc) = '')">
												<xsl:value-of select="'FAILED '"/>
												<xsl:value-of select="'check location : '"/>
												<xsl:value-of select="$location_name"/>
												<xsl:value-of select="' / '"/>
												<xsl:value-of select="$location_id"/>
												<xsl:value-of select="'  in event '"/>
												<xsl:value-of select="$event_name"/>
												<xsl:value-of select="' / '"/>
												<xsl:value-of select="$event_id"/>
												<xsl:copy-of select="."/>
											</xsl:when>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<!--locations that have a different category can be copied with no checks -->
								<xsl:copy-of select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:for-each>
			</events>
		</cdbxml>
	</xsl:template>
</xsl:stylesheet>
