<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
JCO : 19/10/2012
Convert CDB 3.1 XML detailed version to the list version
version 03 handles productions, events and actors and puts them in the list/item tag. Will need one more attribute so we know which item is which
-->
<xsl:stylesheet version="1.0" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:cdb="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="cdb" xsi:schemaLocation="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL D:\XML\XSD\CDB_3_1\FINAL\CdbXSD.xsd">
	<xsl:template match="result">
		<!-- <xsl:element name="{name()}" namespace="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL"> -->
		<cdbxml>
			<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL D:\XML\XSD\CDB_3_1\FINAL\CdbXSD.xsd</xsl:attribute>
			<nofrecords>
				<xsl:value-of select="total"/>
			</nofrecords>
			<list>
				<xsl:for-each select="items">
					<xsl:for-each select="item[@type = 'event']">
						<item>
							<xsl:attribute name="itemtype"><xsl:value-of select="'event'"/></xsl:attribute>
							<xsl:attribute name="cdbid"><xsl:value-of select="event/@cdbid"/></xsl:attribute>
							<xsl:attribute name="externalid"><xsl:value-of select="event/@externalid"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="event/cdb:eventdetails/cdb:eventdetail/cdb:title"/></xsl:attribute>
							<xsl:attribute name="shortdescription"><xsl:value-of select="event/cdb:eventdetails/cdb:eventdetail/cdb:shortdescription"/></xsl:attribute>
							<xsl:attribute name="thumbnail"><xsl:value-of select="event/cdb:eventdetails/cdb:eventdetail/cdb:media/cdb:file/cdb:hlink[../cdb:mediatype='photo']"/></xsl:attribute>
							<xsl:attribute name="calendarsummary"><xsl:value-of select="event/cdb:eventdetails/cdb:eventdetail/cdb:calendarsummary"/></xsl:attribute>
							<!--	<xsl:attribute name="calendartype"><xsl:value-of select="@cdbid"/></xsl:attribute>	-->
							<!--	<xsl:attribute name="headingid"><xsl:value-of select="@cdbid"/></xsl:attribute>	-->
							<!--  just use the type and theme -->
							<xsl:attribute name="heading"><xsl:value-of select="event/cdb:categories/cdb:category[@type='eventtype']"/><xsl:value-of select="', '"/><xsl:value-of select="event/cdb:categories/cdb:category[@type='theme']"/></xsl:attribute>
							<xsl:attribute name="city"><xsl:value-of select="event/cdb:location/cdb:address/cdb:physical/cdb:city"/></xsl:attribute>
							<xsl:attribute name="zip"><xsl:value-of select="event/cdb:location/cdb:address/cdb:physical/cdb:zipcode"/></xsl:attribute>
							<xsl:attribute name="location"><xsl:value-of select="event/cdb:location/cdb:actor/cdb:actordetails/cdb:actordetail/cdb:title"/></xsl:attribute>
							<xsl:attribute name="locationid"><xsl:value-of select="event/cdb:location/cdb:actor/@cdbid"/></xsl:attribute>
							<xsl:attribute name="agefrom"><xsl:value-of select="event/cdb:agefrom"/></xsl:attribute>
							<xsl:attribute name="performers"><xsl:variable name="count_performers"><xsl:value-of select="count(event/cdb:eventdetails/cdb:eventdetail/cdb:performers/cdb:performer)"/></xsl:variable><xsl:for-each select="event/cdb:eventdetails/cdb:eventdetail/cdb:performers/cdb:performer"><xsl:choose><xsl:when test="string(cdb:label) != ''"><xsl:value-of select="cdb:label"/></xsl:when><xsl:otherwise><xsl:value-of select="cdb:actor/cdb:actordetails/cdb:actordetail/cdb:title"/></xsl:otherwise></xsl:choose><xsl:if test="position() != $count_performers"><xsl:value-of select="'; '"/></xsl:if></xsl:for-each></xsl:attribute>
							<xsl:attribute name="available_to"><xsl:value-of select="event/@availableto"/></xsl:attribute>
							<xsl:attribute name="created"><xsl:value-of select="event/@creationdate"/></xsl:attribute>
							<xsl:attribute name="latlng"><xsl:value-of select="event/cdb:location/cdb:address/cdb:physical/cdb:gis/cdb:ycoordinate"/><xsl:value-of select="';'"/><xsl:value-of select="event/cdb:location/cdb:address/cdb:physical/cdb:gis/cdb:xcoordinate"/></xsl:attribute>
							<xsl:attribute name="address"><xsl:value-of select="event/cdb:location/cdb:address/cdb:physical/cdb:street"/><xsl:value-of select="' '"/><xsl:value-of select="event/cdb:location/cdb:address/cdb:physical/cdb:housenr"/><xsl:value-of select="', '"/><xsl:value-of select="event/cdb:location/cdb:address/cdb:physical/cdb:zipcode"/><xsl:value-of select="', '"/><xsl:value-of select="event/cdb:location/cdb:address/cdb:physical/cdb:city"/><xsl:value-of select="', '"/><xsl:value-of select="event/cdb:location/cdb:address/cdb:physical/cdb:country"/></xsl:attribute>
							<xsl:attribute name="theme"><xsl:value-of select="event/cdb:categories/cdb:category[@type='eventtype']"/></xsl:attribute>
							<!-- needed ? -->
							<xsl:attribute name="type"><xsl:value-of select="event/cdb:categories/cdb:category[@type='theme']"/></xsl:attribute>
							<!-- needed ? -->
						</item>
					</xsl:for-each>
					<xsl:for-each select="item[@type = 'actor']">
						<item>
							<xsl:attribute name="itemtype"><xsl:value-of select="'actor'"/></xsl:attribute>
							<xsl:attribute name="cdbid"><xsl:value-of select="actor/@cdbid"/></xsl:attribute>
							<xsl:attribute name="externalid"><xsl:value-of select="actor/@externalid"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="actor/cdb:actordetails/cdb:actordetail/cdb:title"/></xsl:attribute>
							<xsl:attribute name="shortdescription"><xsl:value-of select="actor/cdb:actordetails/cdb:actordetail/cdb:shortdescription"/></xsl:attribute>
							<xsl:attribute name="thumbnail"><xsl:value-of select="actor/cdb:actordetails/cdb:actordetail/cdb:media/cdb:file/cdb:hlink[../cdb:mediatype='photo']"/></xsl:attribute>
							<xsl:attribute name="calendarsummary"><xsl:value-of select="actor/cdb:actordetails/cdb:actordetail/cdb:calendarsummary"/></xsl:attribute>
							<!--	<xsl:attribute name="calendartype"><xsl:value-of select="@cdbid"/></xsl:attribute>	-->
							<!--	<xsl:attribute name="headingid"><xsl:value-of select="@cdbid"/></xsl:attribute>	-->
							<!--  just use the type and theme -->
							<xsl:attribute name="heading"><xsl:value-of select="actor/cdb:categories/cdb:category[@type='actortype']"/>
								<xsl:if test="string(actor/cdb:categories/cdb:category[@type='theme']) != ''">
									<xsl:value-of select="', '"/><xsl:value-of select="actor/cdb:categories/cdb:category[@type='theme']"/>
								</xsl:if>
							</xsl:attribute>
							<xsl:attribute name="agefrom"/>
							<xsl:attribute name="performers"/>
							<xsl:attribute name="address"><xsl:value-of select="actor/cdb:contactinfo/cdb:address/cdb:physical/cdb:street"/><xsl:value-of select="' '"/><xsl:value-of select="actor/cdb:contactinfo//cdb:address/cdb:physical/cdb:housenr"/><xsl:value-of select="', '"/><xsl:value-of select="actor/cdb:contactinfo/cdb:address/cdb:physical/cdb:zipcode"/><xsl:value-of select="', '"/><xsl:value-of select="actor/cdb:contactinfo/cdb:address/cdb:physical/cdb:city"/><xsl:value-of select="', '"/><xsl:value-of select="actor/cdb:location/cdb:address/cdb:physical/cdb:country"/></xsl:attribute>
							<xsl:attribute name="created"><xsl:value-of select="event/@creationdate"/></xsl:attribute>
							<!-- <xsl:attribute name="latlng"><xsl:value-of select="event/cdb:location/cdb:address/cdb:physical/cdb:gis/cdb:ycoordinate"/><xsl:value-of select="';'"/><xsl:value-of select="event/cdb:location/cdb:address/cdb:physical/cdb:gis/cdb:xcoordinate"/></xsl:attribute> -->
							<xsl:attribute name="theme"><xsl:value-of select="actor/cdb:categories/cdb:category[@type='actortype']"/></xsl:attribute>
							<!-- needed ? -->
							<xsl:attribute name="type"><xsl:value-of select="actor/cdb:categories/cdb:category[@type='theme']"/></xsl:attribute>
							<!-- needed ? -->
						</item>
					</xsl:for-each>
					<xsl:for-each select="item[@type = 'production']">
						<item>
							<xsl:attribute name="itemtype"><xsl:value-of select="'production'"/></xsl:attribute>
							<xsl:attribute name="cdbid"><xsl:value-of select="production/@cdbid"/></xsl:attribute>
							<xsl:attribute name="externalid"><xsl:value-of select="production/@externalid"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="production/cdb:productiondetails/cdb:productiondetail/cdb:title"/></xsl:attribute>
							<xsl:attribute name="shortdescription"><xsl:value-of select="production/cdb:productiondetails/cdb:productiondetail/cdb:shortdescription"/></xsl:attribute>
							<xsl:attribute name="thumbnail"><xsl:value-of select="production/cdb:productiondetails/cdb:productiondetail/cdb:media/cdb:file/cdb:hlink[../cdb:mediatype='photo']"/></xsl:attribute>
							<xsl:attribute name="calendarsummary"><xsl:value-of select="'n/a'"/></xsl:attribute>
							<!--	<xsl:attribute name="calendartype"><xsl:value-of select="@cdbid"/></xsl:attribute>	-->
							<!--	<xsl:attribute name="headingid"><xsl:value-of select="@cdbid"/></xsl:attribute>	-->
							<!--  just use the type and theme -->
							<xsl:attribute name="heading"><xsl:value-of select="production/cdb:categories/cdb:category[@type='eventtype']"/><xsl:value-of select="', '"/><xsl:value-of select="production/cdb:categories/cdb:category[@type='theme']"/></xsl:attribute>
							<xsl:attribute name="agefrom"><xsl:value-of select="production/cdb:agefrom"/></xsl:attribute>
							<xsl:attribute name="performers"><xsl:variable name="count_performers"><xsl:value-of select="count(production/cdb:productiondetails/cdb:productiondetail/cdb:performers/cdb:performer)"/></xsl:variable><xsl:for-each select="production/cdb:productiondetails/cdb:productiondetail/cdb:performers/cdb:performer"><xsl:choose><xsl:when test="string(cdb:label) != ''"><xsl:value-of select="cdb:label"/></xsl:when><xsl:otherwise><xsl:value-of select="cdb:actor/cdb:actordetails/cdb:actordetail/cdb:title"/></xsl:otherwise></xsl:choose><xsl:if test="position() != $count_performers"><xsl:value-of select="'; '"/></xsl:if></xsl:for-each></xsl:attribute>
							<xsl:attribute name="available_to"><xsl:value-of select="production/@availableto"/></xsl:attribute>
							<xsl:attribute name="created"><xsl:value-of select="production/@creationdate"/></xsl:attribute>
							<xsl:attribute name="theme"><xsl:value-of select="production/cdb:categories/cdb:category[@type='productiontype']"/></xsl:attribute>
							<!-- needed ? -->
							<xsl:attribute name="type"><xsl:value-of select="production/cdb:categories/cdb:category[@type='theme']"/></xsl:attribute>
							<!-- needed ? -->
						</item>
					</xsl:for-each>
				</xsl:for-each>
			</list>
		</cdbxml>
	</xsl:template>
</xsl:stylesheet>
