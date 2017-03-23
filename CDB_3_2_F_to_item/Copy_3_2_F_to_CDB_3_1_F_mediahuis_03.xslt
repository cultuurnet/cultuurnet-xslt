<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
JCO : 19/10/2012 -> 12/09/2013
Convert CDB 3.2 XML detailed version to the list version
Updated 17-11-14 :
- new attribute permanent : true or fales
- punish Cursussen en Workshops (0.3.1.0.0). with -10000, same as film.
  use the catid to be sure because the mediahouse sample xml uses Cursus of workshop.

-updated 22/05/2015
- added attributres price, longdescription, organiser.
-->
<xsl:stylesheet version="1.0" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:cdb="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="cdb" xsi:schemaLocation="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL/CdbXSD.xsd">
	<xsl:template match="cdb:cdbxml">
		<!-- <xsl:element name="{name()}" namespace="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL"> -->
		<cdbxml>
			<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL/CdbXSD.xsd</xsl:attribute>
			<nofrecords>
				<xsl:value-of select="cdb:nofrecords"/>
			</nofrecords>
			<events>
				<xsl:for-each select="cdb:event">
					<item>
						<xsl:attribute name="address"><xsl:value-of select="cdb:location/cdb:address/cdb:physical/cdb:street"/><xsl:value-of select="' '"/><xsl:value-of select="cdb:location/cdb:address/cdb:physical/cdb:housenr"/><xsl:value-of select="', '"/><xsl:value-of select="cdb:location/cdb:address/cdb:physical/cdb:zipcode"/><xsl:value-of select="', '"/><xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:city"/><xsl:value-of select="', '"/><xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:country"/></xsl:attribute>
						<xsl:attribute name="calendarsummary"><xsl:value-of select="cdb:eventdetails/cdb:eventdetail/cdb:calendarsummary"/></xsl:attribute>
						<xsl:attribute name="cdbid"><xsl:value-of select="@cdbid"/></xsl:attribute>
						<xsl:attribute name="city"><xsl:value-of select="cdb:location/cdb:address/cdb:physical/cdb:city"/></xsl:attribute>
						<xsl:attribute name="eventtype"><xsl:value-of select="cdb:categories/cdb:category[@type='eventtype']"/></xsl:attribute>
						<xsl:attribute name="ends"><xsl:value-of select="cdb:location/cdb:address/cdb:physical/cdb:zipcode"/></xsl:attribute>
						<xsl:attribute name="ends"><xsl:choose><xsl:when test="string(cdb:calendar/cdb:timestamps) != ''"><xsl:choose><xsl:when test="count(cdb:calendar/cdb:timestamps/cdb:timestamp) &gt; 1"><xsl:value-of select="cdb:calendar/cdb:timestamps/cdb:timestamp[last()]/cdb:date"/><xsl:choose><xsl:when test="string(cdb:calendar/cdb:timestamps/cdb:timestamp[last()]//cdb:timeend) != ''"><xsl:value-of select="'T'"/><xsl:value-of select="cdb:calendar/cdb:timestamps/cdb:timestamp[last()]//cdb:timeend"/></xsl:when><xsl:otherwise><xsl:value-of select="'T'"/><xsl:value-of select="'23:59:00'"/></xsl:otherwise></xsl:choose></xsl:when><xsl:otherwise><xsl:value-of select="cdb:calendar/cdb:timestamps/cdb:timestamp[last()]/cdb:date"/><xsl:value-of select="'T'"/><xsl:value-of select="'23:59:00'"/></xsl:otherwise></xsl:choose></xsl:when><xsl:when test="string(cdb:calendar/cdb:permanentopeningtimes) != ''"><!-- empty --></xsl:when><xsl:when test="string(cdb:calendar/cdb:periods) != ''"><xsl:value-of select="cdb:calendar/cdb:periods/cdb:period/cdb:dateto"/><xsl:value-of select="'T'"/><xsl:value-of select="'23:59:00'"/></xsl:when></xsl:choose></xsl:attribute>
						<xsl:attribute name="keywords"><xsl:value-of select="cdb:keywords"/></xsl:attribute>
						<xsl:attribute name="link"><xsl:value-of select="cdb:contactinfo/cdb:url"/></xsl:attribute>
						<xsl:attribute name="latlng"><xsl:value-of select="cdb:location/cdb:address/cdb:physical/cdb:gis/cdb:ycoordinate"/><xsl:value-of select="';'"/><xsl:value-of select="cdb:location/cdb:address/cdb:physical/cdb:gis/cdb:xcoordinate"/></xsl:attribute>
						<xsl:attribute name="location"><xsl:value-of select="cdb:location/cdb:label"/></xsl:attribute>
						<!-- added 17-11-14-->
						<xsl:attribute name="permanent">
							<xsl:choose>
								<xsl:when test="string(cdb:calendar/cdb:permanentopeningtimes) != ''"><xsl:value-of select="'true'"></xsl:value-of></xsl:when>
								<xsl:otherwise><xsl:value-of select="'false'"></xsl:value-of></xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<xsl:attribute name="shortdescription"><xsl:value-of select="cdb:eventdetails/cdb:eventdetail/cdb:shortdescription"/></xsl:attribute>
						<xsl:attribute name="starts"><xsl:choose><xsl:when test="string(cdb:calendar/cdb:timestamps) != ''"><xsl:value-of select="cdb:calendar/cdb:timestamps/cdb:timestamp/cdb:date"/><xsl:choose><xsl:when test="string(cdb:calendar/cdb:timestamps/cdb:timestamp/cdb:timestart) != ''"><xsl:value-of select="'T'"/><xsl:value-of select="cdb:calendar/cdb:timestamps/cdb:timestamp/cdb:timestart"/></xsl:when><xsl:otherwise><xsl:value-of select="'T'"/><xsl:value-of select="'00:00:00'"/></xsl:otherwise></xsl:choose></xsl:when><xsl:when test="string(cdb:calendar/cdb:permanentopeningtimes) != ''"><xsl:value-of select="@availablefrom"/></xsl:when><xsl:when test="string(cdb:calendar/cdb:periods) != ''"><xsl:value-of select="cdb:calendar/cdb:periods/cdb:period/cdb:datefrom"/><xsl:value-of select="'T'"/><xsl:value-of select="'00:00:00'"/></xsl:when></xsl:choose></xsl:attribute>
						<xsl:attribute name="starts"><xsl:choose><xsl:when test="string(cdb:calendar/cdb:timestamps) != ''"><xsl:value-of select="cdb:calendar/cdb:timestamps/cdb:timestamp/cdb:date"/><xsl:choose><xsl:when test="string(cdb:calendar/cdb:timestamps/cdb:timestamp/cdb:timestart) != ''"><xsl:value-of select="'T'"/><xsl:value-of select="cdb:calendar/cdb:timestamps/cdb:timestamp/cdb:timestart"/></xsl:when><xsl:otherwise><xsl:value-of select="'T'"/><xsl:value-of select="'00:00:00'"/></xsl:otherwise></xsl:choose></xsl:when><xsl:when test="string(cdb:calendar/cdb:permanentopeningtimes) != ''"><xsl:value-of select="@availablefrom"/></xsl:when><xsl:when test="string(cdb:calendar/cdb:periods) != ''"><xsl:value-of select="cdb:calendar/cdb:periods/cdb:period/cdb:datefrom"/><xsl:value-of select="'T'"/><xsl:value-of select="'00:00:00'"/></xsl:when></xsl:choose></xsl:attribute>
						<xsl:attribute name="thumbnail"><xsl:value-of select="cdb:eventdetails/cdb:eventdetail/cdb:media/cdb:file/cdb:hlink[../cdb:mediatype='photo']"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="cdb:eventdetails/cdb:eventdetail/cdb:title"/></xsl:attribute>
						<!-- see MDH-6 XSLT for Mediahuis output for weight definition -->
						<xsl:variable name="weight_1">
							<xsl:choose>
								<xsl:when test="string-length(cdb:eventdetails/cdb:eventdetail/cdb:shortdescription) &gt; 50">
									<xsl:value-of select="7500"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="weight_2">
							<xsl:choose>
								<xsl:when test="string(cdb:contactinfo/cdb:url) != ''">
									<xsl:value-of select="2"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="weight_3">
							<xsl:choose>
								<xsl:when test="string-length(cdb:eventdetails/cdb:eventdetail/cdb:longdescription) &gt; 400">
									<xsl:value-of select="1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="weight_4">
							<xsl:choose>
								<xsl:when test="cdb:eventdetails/cdb:eventdetail/cdb:media/cdb:file/cdb:mediatype = 'photo'">
									<xsl:value-of select="1500"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="weight_5">
							<xsl:choose>
								<xsl:when test="cdb:categories/cdb:category = 'Internationaal'">
									<xsl:value-of select="10000"/>
								</xsl:when>
								<xsl:when test="cdb:categories/cdb:category = 'Nationaal'">
									<xsl:value-of select="100"/>
								</xsl:when>
								<xsl:when test="cdb:categories/cdb:category = 'Regionaal'">
									<xsl:value-of select="30"/>
								</xsl:when>
								<xsl:when test="cdb:categories/cdb:category = 'Lokaal'">
									<xsl:value-of select="30"/>
								</xsl:when>
								<xsl:when test="cdb:categories/cdb:category = 'Wijk of buurt'">
									<xsl:value-of select="10"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="weight_6">
							<xsl:choose>
								<xsl:when test="string(cdb:calendar/cdb:timestamps) != ''">
									<xsl:value-of select="15000 "/>
								</xsl:when>
								<xsl:when test="string(cdb:calendar/cdb:periods) != ''">
									<xsl:value-of select="10000"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="weight_7">
							<xsl:choose>
								<xsl:when test="cdb:categories/cdb:category/@catid ='0.50.4.0.0' or cdb:categories/cdb:category/@catid ='0.55.0.0.0' or cdb:categories/cdb:category/@catid ='0.54.0.0.0'
								or cdb:categories/cdb:category/@catid ='0.5.0.0.0' or cdb:categories/cdb:category/@catid ='0.0.0.0.0'">
									<xsl:value-of select="500"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="weight_8">
							<xsl:choose>
								<xsl:when test="cdb:categories/cdb:category = 'Film'">
									<xsl:value-of select="-10000"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="weight_9">
							<xsl:choose>
								<xsl:when test="cdb:categories/cdb:category/@catid = '0.3.1.0.0'">
									<xsl:value-of select="-10000"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:attribute name="weight"><xsl:value-of select="$weight_1 + $weight_2 +$weight_3+$weight_4+$weight_5+$weight_6+$weight_7+$weight_8 +$weight_9"/></xsl:attribute>
						<xsl:attribute name="zip"><xsl:value-of select="cdb:location/cdb:address/cdb:physical/cdb:zipcode"/></xsl:attribute>
						<!-- added 22/05/2015 -->
						<xsl:attribute name="price"><xsl:value-of select="cdb:eventdetails/cdb:eventdetail/cdb:price/cdb:pricevalue"/></xsl:attribute>
						<xsl:attribute name="longdescription"><xsl:value-of select="cdb:eventdetails/cdb:eventdetail/cdb:longdescription"/></xsl:attribute>
						<xsl:attribute name="organiser"><xsl:value-of select="cdb:organiser/cdb:label"/></xsl:attribute>
					</item>
				</xsl:for-each>
			</events>
		</cdbxml>
	</xsl:template>
</xsl:stylesheet>
