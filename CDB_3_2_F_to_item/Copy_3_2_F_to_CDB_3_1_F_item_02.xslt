<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
JCO : 19/10/2012 -> 12/09/2013
Convert CDB 3.2 XML detailed version to the list version
version 02 handles productions, events and actors and puts them the lhe list element for each type

JCO : 27/11/2015 : See UDB-2411 fixing issues in xslt for transform=list
heading removed
zip added
available_to added
keyworde added
reservation added
creationdate changed to created.d
contact added
-calendartype added
	- timestamp = 1
	- timestamps = 2
	- period= 3
	- permanent = 4
-->
<xsl:stylesheet version="1.0" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:cdb="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="cdb" xsi:schemaLocation="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL/CdbXSD.xsd">
	<xsl:template match="cdb:cdbxml">
		<!-- <xsl:element name="{name()}" namespace="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL"> -->
		<cdbxml>
			<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL/CdbXSD.xsd</xsl:attribute>
			<nofrecords>
				<xsl:value-of select="cdb:nofrecords"/>
			</nofrecords>
			<xsl:if test="string(./cdb:event) != ''">
				<events>
					<xsl:for-each select="cdb:event">
						<item>
							<xsl:attribute name="address"><xsl:value-of select="cdb:location/cdb:address/cdb:physical/cdb:street"/><xsl:value-of select="' '"/><xsl:value-of select="cdb:location/cdb:address/cdb:physical/cdb:housenr"/><xsl:value-of select="', '"/><xsl:value-of select="cdb:location/cdb:address/cdb:physical/cdb:zipcode"/><xsl:value-of select="', '"/><xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:city"/><xsl:value-of select="', '"/><xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:country"/></xsl:attribute>
							<xsl:attribute name="cdbid"><xsl:value-of select="@cdbid"/></xsl:attribute>
							<xsl:attribute name="externalid"><xsl:value-of select="@externalid"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="cdb:eventdetails/cdb:eventdetail/cdb:title"/></xsl:attribute>
							<xsl:attribute name="shortdescription"><xsl:value-of select="cdb:eventdetails/cdb:eventdetail/cdb:shortdescription"/></xsl:attribute>
							<xsl:attribute name="contactinfo"><xsl:value-of select="cdb:contactinfo/cdb:phone"/><xsl:if test="string(cdb:contactinfo/cdb:phone) != '' and string(cdb:contactinfo/cdb:mail) != ''"><xsl:value-of select="' , '"/></xsl:if><xsl:value-of select="cdb:contactinfo/cdb:mail"/><xsl:if test="(string(cdb:contactinfo/cdb:phone) != '' or string(cdb:contactinfo/cdb:mail) != '' ) and string(cdb:contactinfo/cdb:url) != ''"><xsl:value-of select="' , '"/></xsl:if><xsl:value-of select="cdb:contactinfo/cdb:url"/></xsl:attribute>
							<xsl:attribute name="thumbnail"><xsl:value-of select="cdb:eventdetails/cdb:eventdetail/cdb:media/cdb:file/cdb:hlink[../cdb:mediatype='photo']"/></xsl:attribute>
							<xsl:attribute name="calendar"><xsl:value-of select="cdb:eventdetails/cdb:eventdetail/cdb:calendarsummary"/></xsl:attribute>
							<xsl:attribute name="calendarsummary"><xsl:value-of select="cdb:eventdetails/cdb:eventdetail/cdb:calendarsummary"/></xsl:attribute>
							<!--	<xsl:attribute name="calendartype"><xsl:value-of select="@cdbid"/></xsl:attribute>	-->
							<!--	<xsl:attribute name="headingid"><xsl:value-of select="@cdbid"/></xsl:attribute>	-->
							<!--  just use the type and theme -->
							<!-- <xsl:attribute name="heading"><xsl:value-of select="cdb:categories/cdb:category[@type='eventtype']"/>,<xsl:value-of select="cdb:categories/cdb:category[@type='theme']"/></xsl:attribute> -->
							<xsl:attribute name="city"><xsl:value-of select="cdb:location/cdb:address/cdb:physical/cdb:city"/></xsl:attribute>
							<!--<xsl:attribute name="zip"><xsl:value-of select="cdb:location/cdb:address/cdb:physical/cdb:zipcode"/></xsl:attribute>-->
							<xsl:attribute name="location"><xsl:value-of select="cdb:location/cdb:label"/></xsl:attribute>
							<xsl:attribute name="locationid"><xsl:value-of select="cdb:location/cdb:label/@cdbid"/></xsl:attribute>
							<xsl:attribute name="agefrom"><xsl:value-of select="cdb:agefrom"/></xsl:attribute>
							<xsl:attribute name="performers"><xsl:variable name="count_performers"><xsl:value-of select="count(event/cdb:eventdetails/cdb:eventdetail/cdb:performers/cdb:performer)"/></xsl:variable><xsl:for-each select="cdb:eventdetails/cdb:eventdetail/cdb:performers/cdb:performer"><xsl:choose><xsl:when test="string(cdb:label) != ''"><xsl:value-of select="cdb:label"/></xsl:when><xsl:otherwise><xsl:value-of select="cdb:actor/cdb:actordetails/cdb:actordetail/cdb:title"/></xsl:otherwise></xsl:choose><xsl:if test="position() != $count_performers"><xsl:value-of select="'; '"/></xsl:if></xsl:for-each></xsl:attribute>
							<xsl:attribute name="available_to"><xsl:value-of select="@availableto"/></xsl:attribute>
							<xsl:attribute name="createdby"><xsl:value-of select="@createdby"/></xsl:attribute>
							<xsl:attribute name="created"><xsl:value-of select="@creationdate"/></xsl:attribute>
							<xsl:attribute name="modifiedby"><xsl:value-of select="@lastupdatedby"/></xsl:attribute>
							<xsl:attribute name="modifiedon"><xsl:value-of select="@lastupdated"/></xsl:attribute>
							<xsl:attribute name="owner"><xsl:value-of select="@owner"/></xsl:attribute>
							<xsl:attribute name="pctcomplete"><xsl:value-of select="@pctcomplete"/></xsl:attribute>
							<xsl:attribute name="latlng"><xsl:value-of select="cdb:location/cdb:address/cdb:physical/cdb:gis/cdb:ycoordinate"/><xsl:value-of select="';'"/><xsl:value-of select="cdb:location/cdb:address/cdb:physical/cdb:gis/cdb:xcoordinate"/></xsl:attribute>
							<xsl:attribute name="theme"><xsl:value-of select="cdb:categories/cdb:category[@type='theme']"/></xsl:attribute>
							<xsl:attribute name="eventtype"><xsl:value-of select="cdb:categories/cdb:category[@type='eventtype']"/></xsl:attribute>
							<xsl:attribute name="validator"><xsl:value-of select="@validator"/></xsl:attribute>
							<xsl:attribute name="wfstatus"><xsl:value-of select="@wfstatus"/></xsl:attribute>
							<xsl:attribute name="zip"><xsl:value-of select="cdb:location/cdb:address/cdb:physical/cdb:zipcode"/></xsl:attribute>
							<xsl:attribute name="keywords"><xsl:value-of select="translate(cdb:keywords,';',',')"/></xsl:attribute>
							<xsl:attribute name="reservation"><xsl:variable name="reservation"><xsl:for-each select="cdb:contactinfo/cdb:url"><xsl:if test="@reservation = 'true'"><xsl:value-of select="."/><xsl:value-of select="';'"/></xsl:if></xsl:for-each><xsl:for-each select="cdb:contactinfo/cdb:mail"><xsl:if test="@reservation = 'true'"><xsl:value-of select="."/><xsl:value-of select="';'"/></xsl:if></xsl:for-each></xsl:variable><xsl:value-of select="substring($reservation,1,string-length($reservation)-1)"/></xsl:attribute>
							<xsl:attribute name="contact"><xsl:variable name="contact"><!-- street and housenr optional 
							<xsl:if test="cdb:contactinfo/cdb:address/cdb:physical != ''">
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:housenr"/>
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:street"/>
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:city"/>
								<xsl:value-of select="','  "></xsl:value-of>
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:zipcode"/>
								<xsl:value-of select="', ' "></xsl:value-of>
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:country"/>
							</xsl:if>
							<xsl:if test="cdb:contactinfo/cdb:address/cdb:virtual != ''">
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:virtual/cdb:title"/>
							</xsl:if>  --><xsl:for-each select="cdb:contactinfo/cdb:mail"><xsl:choose><xsl:when test="./@reservation"><xsl:if test="@reservation = 'false'"><xsl:value-of select="."/><xsl:value-of select="';'"/></xsl:if></xsl:when><xsl:otherwise><xsl:value-of select="."/><xsl:value-of select="';'"/></xsl:otherwise></xsl:choose><!--xxx<xsl:value-of select="@reservation"></xsl:value-of>zzz
								<xsl:if test="@reservation != 'true' or @reservation != ''">
									<xsl:value-of select="."/>
									<xsl:value-of select="','"/>
								</xsl:if> --></xsl:for-each></xsl:variable><xsl:value-of select="substring($contact,1,string-length($contact)-1)"/></xsl:attribute>
							<xsl:attribute name="calendartype"><xsl:choose><xsl:when test="string(cdb:calendar/cdb:permanentopeningtimes)  != ''"><xsl:value-of select="'4'"/></xsl:when><xsl:when test="string(cdb:calendar/cdb:periods) != ''"><xsl:value-of select="'3'"/></xsl:when><xsl:when test="count(cdb:calendar/cdb:timestamps/cdb:timestamp) =1"><xsl:value-of select="'1'"/></xsl:when><xsl:otherwise><xsl:value-of select="'2'"/></xsl:otherwise><!--<xsl:otherwise><xsl:value-of select = "count(cdb:calendar/cdb:timestamps/cdb:timestamp)"></xsl:value-of></xsl:otherwise>--></xsl:choose></xsl:attribute>
							<xsl:attribute name="categoryid"><xsl:variable name="categoryid"><xsl:for-each select="cdb:categories"><xsl:for-each select="cdb:category"><xsl:value-of select="@catid"/><xsl:value-of select="';'"/></xsl:for-each></xsl:for-each></xsl:variable><xsl:value-of select="substring($categoryid,1,string-length($categoryid)-1)"/></xsl:attribute>
						</item>
					</xsl:for-each>
				</events>
			</xsl:if>
			<xsl:if test="string(./cdb:actor) != ''">
				<actors>
					<xsl:for-each select="cdb:actor">
						<item>
							<xsl:attribute name="title"><xsl:value-of select="cdb:actordetails/cdb:actordetail/cdb:title"/></xsl:attribute>
							<xsl:attribute name="thumbnail"><xsl:value-of select="cdb:actordetails/cdb:actordetail/cdb:media/cdb:file/cdb:hlink[../cdb:mediatype='photo']"/></xsl:attribute>
							<xsl:attribute name="calendar"><xsl:value-of select="cdb:actordetails/cdb:actordetail/cdb:calendarsummary"/></xsl:attribute>
							<xsl:attribute name="calendarsummary"><xsl:value-of select="cdb:actordetails/cdb:actordetail/cdb:calendarsummary"/></xsl:attribute>
							<xsl:attribute name="shortdescription"><xsl:value-of select="cdb:actordetails/cdb:actordetail/cdb:shortdescription"/></xsl:attribute>
							<xsl:attribute name="available_to"><xsl:value-of select="@availableto"/></xsl:attribute>
							<xsl:attribute name="createdby"><xsl:value-of select="@createdby"/></xsl:attribute>
							<xsl:attribute name="created"><xsl:value-of select="@creationdate"/></xsl:attribute>
							<xsl:attribute name="cdbid"><xsl:value-of select="@cdbid"/></xsl:attribute>
							<xsl:attribute name="externalid"><xsl:value-of select="@externalid"/></xsl:attribute>
							<xsl:attribute name="modifiedby"><xsl:value-of select="@lastupdatedby"/></xsl:attribute>
							<xsl:attribute name="modifiedon"><xsl:value-of select="@lastupdated"/></xsl:attribute>
							<xsl:attribute name="owner"><xsl:value-of select="@owner"/></xsl:attribute>
							<xsl:attribute name="theme"><xsl:value-of select="cdb:categories/cdb:category[@type='theme']"/></xsl:attribute>
							<xsl:attribute name="actortype"><xsl:value-of select="cdb:categories/cdb:category[@type='actortype']"/></xsl:attribute>
							<xsl:attribute name="wfstatus"><xsl:value-of select="@wfstatus"/></xsl:attribute>
							<xsl:attribute name="keywords"><xsl:value-of select="translate(cdb:keywords,';',',')"/></xsl:attribute>
							<xsl:attribute name="categoryid"><xsl:variable name="categoryid"><xsl:for-each select="cdb:categories"><xsl:for-each select="cdb:category"><xsl:value-of select="@catid"/><xsl:value-of select="';'"/></xsl:for-each></xsl:for-each></xsl:variable><xsl:value-of select="substring($categoryid,1,string-length($categoryid)-1)"/></xsl:attribute>
							<xsl:attribute name="contact"><xsl:variable name="contact"><!-- street and housenr optional 
							<xsl:if test="cdb:contactinfo/cdb:address/cdb:physical != ''">
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:housenr"/>
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:street"/>
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:city"/>
								<xsl:value-of select="','  "></xsl:value-of>
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:zipcode"/>
								<xsl:value-of select="', ' "></xsl:value-of>
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:country"/>
							</xsl:if>
							<xsl:if test="cdb:contactinfo/cdb:address/cdb:virtual != ''">
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:virtual/cdb:title"/>
							</xsl:if>  --><xsl:for-each select="cdb:contactinfo/cdb:mail"><xsl:choose><xsl:when test="./@reservation"><xsl:if test="@reservation = 'false'"><xsl:value-of select="."/><xsl:value-of select="';'"/></xsl:if></xsl:when><xsl:otherwise><xsl:value-of select="."/><xsl:value-of select="';'"/></xsl:otherwise></xsl:choose><!--xxx<xsl:value-of select="@reservation"></xsl:value-of>zzz
								<xsl:if test="@reservation != 'true' or @reservation != ''">
									<xsl:value-of select="."/>
									<xsl:value-of select="','"/>
								</xsl:if> --></xsl:for-each></xsl:variable><xsl:value-of select="substring($contact,1,string-length($contact)-1)"/></xsl:attribute>
								<xsl:attribute name="contactinfo">
									<xsl:value-of select="cdb:contactinfo/cdb:phone"/>
										<xsl:if test="string(cdb:contactinfo/cdb:phone) != '' and string(cdb:contactinfo/cdb:mail) != ''">
											<xsl:value-of select="' , '"/>
										</xsl:if>
										<xsl:value-of select="cdb:contactinfo/cdb:mail"/>
										<xsl:if test="(string(cdb:contactinfo/cdb:phone) != '' or string(cdb:contactinfo/cdb:mail) != '' ) and string(cdb:contactinfo/cdb:url) != ''">
											<xsl:value-of select="' , '"/>
										</xsl:if>
										<xsl:value-of select="cdb:contactinfo/cdb:url"/>
									</xsl:attribute>
								<xsl:attribute name="reservation"><xsl:variable name="reservation"><xsl:for-each select="cdb:contactinfo/cdb:url"><xsl:if test="@reservation = 'true'"><xsl:value-of select="."/><xsl:value-of select="';'"/></xsl:if></xsl:for-each><xsl:for-each select="cdb:contactinfo/cdb:mail"><xsl:if test="@reservation = 'true'"><xsl:value-of select="."/><xsl:value-of select="';'"/></xsl:if></xsl:for-each></xsl:variable><xsl:value-of select="substring($reservation,1,string-length($reservation)-1)"/></xsl:attribute>
						</item>
					</xsl:for-each>
				</actors>
			</xsl:if>
			<xsl:if test="string(./cdb:production) != ''">
				<production>
					<xsl:for-each select="cdb:production">
						<item>
							<xsl:attribute name="title"><xsl:value-of select="cdb:productiondetails/cdb:productiondetail/cdb:title"/></xsl:attribute>
							<xsl:attribute name="thumbnail"><xsl:value-of select="cdb:productiondetails/cdb:productiondetail/cdb:media/cdb:file/cdb:hlink[../cdb:mediatype='photo']"/></xsl:attribute>
							<xsl:attribute name="shortdescription"><xsl:value-of select="cdb:productiondetails/cdb:productiondetail/cdb:shortdescription"/></xsl:attribute>
							<xsl:attribute name="available_to"><xsl:value-of select="@availableto"/></xsl:attribute>
							<xsl:attribute name="createdby"><xsl:value-of select="@createdby"/></xsl:attribute>
							<xsl:attribute name="created"><xsl:value-of select="@creationdate"/></xsl:attribute>
							<xsl:attribute name="cdbid"><xsl:value-of select="@cdbid"/></xsl:attribute>
							<xsl:attribute name="externalid"><xsl:value-of select="@externalid"/></xsl:attribute>
							<xsl:attribute name="modifiedby"><xsl:value-of select="@lastupdatedby"/></xsl:attribute>
							<xsl:attribute name="modifiedon"><xsl:value-of select="@lastupdated"/></xsl:attribute>
							<xsl:attribute name="owner"><xsl:value-of select="@owner"/></xsl:attribute>
							<xsl:attribute name="theme"><xsl:value-of select="cdb:categories/cdb:category[@type='theme']"/></xsl:attribute>
							<xsl:attribute name="eventtype"><xsl:value-of select="cdb:categories/cdb:category[@type='eventtype']"/></xsl:attribute>
							<xsl:attribute name="wfstatus"><xsl:value-of select="@wfstatus"/></xsl:attribute>
							<xsl:attribute name="keywords"><xsl:value-of select="translate(cdb:keywords,';',',')"/></xsl:attribute>
							<xsl:attribute name="categoryid"><xsl:variable name="categoryid"><xsl:for-each select="cdb:categories"><xsl:for-each select="cdb:category"><xsl:value-of select="@catid"/><xsl:value-of select="';'"/></xsl:for-each></xsl:for-each></xsl:variable><xsl:value-of select="substring($categoryid,1,string-length($categoryid)-1)"/></xsl:attribute>
							<xsl:attribute name="agefrom"><xsl:value-of select="cdb:agefrom"/></xsl:attribute>
							<xsl:attribute name="contact"><xsl:variable name="contact"><!-- street and housenr optional 
							<xsl:if test="cdb:contactinfo/cdb:address/cdb:physical != ''">
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:housenr"/>
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:street"/>
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:city"/>
								<xsl:value-of select="','  "></xsl:value-of>
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:zipcode"/>
								<xsl:value-of select="', ' "></xsl:value-of>
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:physical/cdb:country"/>
							</xsl:if>
							<xsl:if test="cdb:contactinfo/cdb:address/cdb:virtual != ''">
								<xsl:value-of select="cdb:contactinfo/cdb:address/cdb:virtual/cdb:title"/>
							</xsl:if>  --><xsl:for-each select="cdb:contactinfo/cdb:mail"><xsl:choose><xsl:when test="./@reservation"><xsl:if test="@reservation = 'false'"><xsl:value-of select="."/><xsl:value-of select="';'"/></xsl:if></xsl:when><xsl:otherwise><xsl:value-of select="."/><xsl:value-of select="';'"/></xsl:otherwise></xsl:choose><!--xxx<xsl:value-of select="@reservation"></xsl:value-of>zzz
								<xsl:if test="@reservation != 'true' or @reservation != ''">
									<xsl:value-of select="."/>
									<xsl:value-of select="','"/>
								</xsl:if> --></xsl:for-each></xsl:variable><xsl:value-of select="substring($contact,1,string-length($contact)-1)"/></xsl:attribute>
								<xsl:attribute name="contactinfo"><xsl:value-of select="cdb:contactinfo/cdb:phone"/><xsl:if test="string(cdb:contactinfo/cdb:phone) != '' and string(cdb:contactinfo/cdb:mail) != ''"><xsl:value-of select="' , '"/></xsl:if><xsl:value-of select="cdb:contactinfo/cdb:mail"/><xsl:if test="(string(cdb:contactinfo/cdb:phone) != '' or string(cdb:contactinfo/cdb:mail) != '' ) and string(cdb:contactinfo/cdb:url) != ''"><xsl:value-of select="' , '"/></xsl:if><xsl:value-of select="cdb:contactinfo/cdb:url"/></xsl:attribute>
								<xsl:attribute name="reservation"><xsl:variable name="reservation"><xsl:for-each select="cdb:contactinfo/cdb:url"><xsl:if test="@reservation = 'true'"><xsl:value-of select="."/><xsl:value-of select="';'"/></xsl:if></xsl:for-each><xsl:for-each select="cdb:contactinfo/cdb:mail"><xsl:if test="@reservation = 'true'"><xsl:value-of select="."/><xsl:value-of select="';'"/></xsl:if></xsl:for-each></xsl:variable><xsl:value-of select="substring($reservation,1,string-length($reservation)-1)"/></xsl:attribute>
								<xsl:attribute name="performers"><xsl:variable name="count_performers"><xsl:value-of select="count(cdb:productiondetails/cdb:productiondetail/cdb:performers/cdb:performer)"/></xsl:variable><xsl:for-each select="cdb:productiondetails/cdb:productiondetail/cdb:performers/cdb:performer"><xsl:choose><xsl:when test="string(cdb:label) != ''"><xsl:value-of select="cdb:label"/></xsl:when><xsl:otherwise><xsl:value-of select="cdb:actor/cdb:actordetails/cdb:actordetail/cdb:title"/></xsl:otherwise></xsl:choose><xsl:if test="position() != $count_performers"><xsl:value-of select="'; '"/></xsl:if></xsl:for-each></xsl:attribute>
					</item>
					</xsl:for-each>
				</production>
			</xsl:if>
		</cdbxml>
	</xsl:template>
</xsl:stylesheet>
