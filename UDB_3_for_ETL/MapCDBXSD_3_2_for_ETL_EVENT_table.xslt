<?xml version="1.0" encoding="UTF-8"?>
<!--
Transform CDB XSD 3.2 Final to 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" xmlns:ns3="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="n1 xs ns3">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="n1:cdbxml">
		<cdbxml>
			<!--<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL/CdbXSD.xsd</xsl:attribute> -->
			<!--<events>-->
			<xsl:for-each select="n1:event">
				<event>
					<xsl:attribute name="id"/>
					<xsl:attribute name="periodinfo"/>
					<xsl:attribute name="label"><xsl:value-of select="n1:eventdetails/n1:eventdetail/n1:title"/></xsl:attribute>
					<xsl:attribute name="shortdescription"><xsl:value-of select="n1:eventdetails/n1:eventdetail/n1:shortdescription"/></xsl:attribute>
					<xsl:attribute name="cdbid"><xsl:value-of select="@cdbid"/></xsl:attribute>
					<xsl:attribute name="createdby"><xsl:value-of select="@createdby"/></xsl:attribute>
					<xsl:attribute name="lastModifiedby"><xsl:value-of select="@lastupdatedby"/></xsl:attribute>
					<xsl:attribute name="ownerUserPool"><xsl:value-of select="@owner"/></xsl:attribute>																									<!-- update D_EVENT to take this if -->
					<!--	<xsl:attribute name="ownerUserPool_length"><xsl:value-of select="string-length(@owner)"/></xsl:attribute>		-->		
					<xsl:attribute name="createdon"><xsl:value-of select="@creationdate"/></xsl:attribute>
					<xsl:attribute name="lastModifiedon"><xsl:value-of select="@lastupdated"/></xsl:attribute>
          <!--
          <xsl:attribute name="availablefrom">
            <xsl:value-of select="@availablefrom"/>
          </xsl:attribute>
          
          <xsl:attribute name="availableto">
            <xsl:value-of select="@availableto"/>
          </xsl:attribute>
          -->
					<xsl:if test="@availablefrom != ''">
						<xsl:attribute name="availablefrom"><xsl:value-of select="@availablefrom"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="@availableto != ''">
						<xsl:attribute name="availableto"><xsl:value-of select="@availableto"/></xsl:attribute>
					</xsl:if>
          
					<xsl:attribute name="isPerson"></xsl:attribute>
					<xsl:if test="@private != ''">
						<xsl:attribute name="private"><xsl:value-of select="@private"/></xsl:attribute>
					</xsl:if>
					<xsl:attribute name="publicationlevel">
						<xsl:choose>
							<xsl:when test="@wfstatus='draft'"><xsl:value-of select="1"/></xsl:when>
							<xsl:when test="@wfstatus='readyforvalidation'"><xsl:value-of select="2"/></xsl:when>
							<xsl:when test="@wfstatus='approved'"><xsl:value-of select="3"/></xsl:when>
							<xsl:when test="@wfstatus='rejected'"><xsl:value-of select="4"/></xsl:when>
							<xsl:when test="@wfstatus='deleted'"><xsl:value-of select="5"/><!-- </xsl:when><xsl:when test="@wfstatus='calculating'"><xsl:value-of select="6"/> not in the xsd --></xsl:when>
							<xsl:otherwise><xsl:value-of select="0"/></xsl:otherwise></xsl:choose></xsl:attribute>
					<xsl:attribute name="location"><xsl:value-of select="n1:location/n1:label"/></xsl:attribute>
					<xsl:attribute name="zipcode"><xsl:value-of select="n1:location/n1:address/n1:physical/n1:zipcode"/></xsl:attribute>
					<xsl:attribute name="city"><xsl:value-of select="n1:location/n1:address/n1:physical/n1:city"/></xsl:attribute>
					<xsl:attribute name="countryid"/>
					<xsl:if test="n1:location/n1:address/n1:physical/n1:country  != ''">
						<xsl:attribute name="country"><xsl:value-of select="n1:location/n1:address/n1:physical/n1:country"/></xsl:attribute>
					</xsl:if>
					<xsl:attribute name="organiser"><xsl:value-of select="n1:organiser/n1:label"/></xsl:attribute>
					<xsl:attribute name="beginsat">
						<xsl:choose>
							<xsl:when test="n1:calendar/n1:timestamps/n1:timestamp != ''">
								<xsl:value-of select="n1:calendar/n1:timestamps/n1:timestamp/n1:date"/>
							</xsl:when>
							<xsl:when test ="n1:calendar/n1:permanentopeningtimes"><xsl:value-of select="@availablefrom"/></xsl:when>
							<xsl:when test="n1:calendar/n1:periods/n1:period != ''"><xsl:value-of select="n1:calendar/n1:periods/n1:period/n1:datefrom"/></xsl:when></xsl:choose></xsl:attribute>
					<xsl:attribute name="endsat"><xsl:value-of select="@availableto"/></xsl:attribute>
					<xsl:attribute name="calendarsummary"><xsl:value-of select="n1:eventdetails/n1:eventdetail/n1:calendarsummary"/></xsl:attribute>
					<xsl:attribute name="weight"/>
					<xsl:attribute name="userDefinedWeight"/>
					<xsl:attribute name="lastImportedOn"/>
					<xsl:if test="n1:location/n1:address/n1:physical/n1:gis/n1:xcoordinate  != ''">
						<xsl:attribute name="xCoordinate"><xsl:value-of select="n1:location/n1:address/n1:physical/n1:gis/n1:xcoordinate"/></xsl:attribute>
						<xsl:attribute name="yCoordinate"><xsl:value-of select="n1:location/n1:address/n1:physical/n1:gis/n1:ycoordinate"/></xsl:attribute>
					</xsl:if>
					<xsl:attribute name="actief"/>
								<xsl:attribute name="lcidId"/> 
					<xsl:attribute name="deletedon"/>											<!-- from another xslt -->
					<xsl:attribute name="deleted"/>												<!-- from another xslt -->
					<xsl:attribute name="channelId"/>											<!-- ??? 1 or null -->
					<xsl:attribute name="userid"/>												<!-- ??? mailed Carlo,Stan,Luk-->
					<xsl:attribute name="isparent"><xsl:value-of select="0"/></xsl:attribute>
					<xsl:attribute name="opafspraak"/> 										<!-- n1:timestamp/n1:opentype last used April 2014 -->
					<xsl:attribute name="beslotenAanbod"/>
					<xsl:attribute name="hedendaags"/>
					<xsl:attribute name="permanent">		
						<xsl:choose>
								<xsl:when test ="n1:calendar/n1:permanentopeningtimes"><xsl:value-of select="1"></xsl:value-of></xsl:when>
							<xsl:otherwise><xsl:value-of select="0"></xsl:value-of></xsl:otherwise>
						</xsl:choose>
					  </xsl:attribute>	
					<xsl:attribute name="rankfactor"/>
					<xsl:if test="@published != ''">
						<xsl:attribute name="published"><xsl:value-of select="@published"/></xsl:attribute>
					</xsl:if>
					<xsl:attribute name="toBeValidatedBy"/>
					<xsl:attribute name="validatedBy"/>
					<xsl:if test="@pctcomplete != ''">
						<xsl:attribute name="completeness"><xsl:value-of select="@pctcomplete"/></xsl:attribute>
					</xsl:if>
					<xsl:attribute name="type"/>
					<xsl:attribute name="thema"/>
					<xsl:attribute name="tags"><xsl:value-of select="n1:keywords"/></xsl:attribute>
					<xsl:variable name="performers">
						<xsl:for-each select="n1:eventdetails/n1:eventdetail/n1:performers/n1:performer/n1:label">
							<xsl:value-of select=".">
						</xsl:value-of>
						</xsl:for-each>
						<xsl:value-of select="','"/>
					</xsl:variable>
					<xsl:attribute name="performersxxx"><xsl:value-of select="string-length($performers)"/></xsl:attribute>
					<xsl:attribute name="performers"><xsl:value-of select="substring($performers,1,string-length($performers)-1)"/></xsl:attribute>
					<xsl:attribute name="deeplink"><xsl:for-each select="n1:contactinfo/n1:url"><xsl:if test="@main='true'"><xsl:value-of select="."/></xsl:if></xsl:for-each></xsl:attribute>
					<xsl:attribute name="defaultthumbnail"><xsl:for-each select="n1:eventdetails/n1:eventdetail/n1:media/n1:file"><xsl:if test="n1:mediatype='photo'"><xsl:value-of select="n1:filename"/></xsl:if></xsl:for-each></xsl:attribute>
					<xsl:attribute name="contactInfo"/>			<!-- not used -->
					<xsl:attribute name="soldout"/>				<!-- not in D_EVENT -->
					<xsl:attribute name="cancelled"/>			<!-- not in D_EVENT -->
					<xsl:attribute name="validatedOn"/>
					<xsl:attribute name="excludeHolidaysSundays"/>
					<xsl:attribute name="calendarComment"/>
					<xsl:attribute name="isKoepelaanbod"/>
					<xsl:attribute name="CleanLabel"/>
					<xsl:attribute name="ImportBlock"/>
					<xsl:if test="n1:bookingperiod/n1:datefrom != ''">
						<xsl:attribute name="bookingfrom"><xsl:value-of select="n1:bookingperiod/n1:datefrom"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="n1:bookingperiod/n1:dateto != ''">
						<xsl:attribute name="bookingto"><xsl:value-of select="n1:bookingperiod/n1:dateto"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="n1:maxparticipants != ''">
						<xsl:attribute name="maxParticipants"><xsl:value-of select="n1:maxparticipants"/></xsl:attribute>
					</xsl:if>
					<xsl:attribute name="isProduction"><xsl:value-of select="'0'"></xsl:value-of></xsl:attribute>
					<xsl:attribute name="hoofdgemeente"/>	<!-- generate this like it's done in STG_EVENT -->
					<xsl:attribute name="deleteReason"/>		<!-- not in xml -->
					<xsl:if test="n1:location/n1:label/@cdbid != ''">
						<xsl:attribute name="location_cdbid"><xsl:value-of select="n1:location/n1:label/@cdbid"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="n1:organiser/n1:label/@cdbid != ''">
						<xsl:attribute name="organiser_cdbid"><xsl:value-of select="n1:organiser/n1:label/@cdbid"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="n1:location/n1:address/n1:physical/n1:street != ''">
						<xsl:attribute name="street"><xsl:value-of select="n1:location/n1:address/n1:physical/n1:street"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="n1:location/n1:address/n1:physical/n1:housenr != ''">
						<xsl:attribute name="housenr"><xsl:value-of select="n1:location/n1:address/n1:physical/n1:housenr"/></xsl:attribute>
					</xsl:if>
				</event>
			</xsl:for-each>
			<!--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-->
			<xsl:for-each select="n1:production">
				<event>
					<xsl:attribute name="id"/>
					<xsl:attribute name="periodinfo"/>
					<xsl:attribute name="label"><xsl:value-of select="n1:productiondetails/n1:productiondetail/n1:title"/></xsl:attribute>
					<xsl:attribute name="shortdescription"><xsl:value-of select="n1:productiondetails/n1:productiondetail/n1:shortdescription"/></xsl:attribute>
					<xsl:attribute name="cdbid"><xsl:value-of select="@cdbid"/></xsl:attribute>
					<xsl:attribute name="createdby"><xsl:value-of select="@createdby"/></xsl:attribute>
					<xsl:attribute name="lastModifiedby"><xsl:value-of select="@lastupdatedby"/></xsl:attribute>
					<xsl:attribute name="ownerUserPool"><xsl:value-of select="@owner"/></xsl:attribute>																									<!-- update D_EVENT to take this if -->
					<!--	<xsl:attribute name="ownerUserPool_length"><xsl:value-of select="string-length(@owner)"/></xsl:attribute>		-->		
					<xsl:attribute name="createdon"><xsl:value-of select="@creationdate"/></xsl:attribute>
					<xsl:attribute name="lastModifiedon"><xsl:value-of select="@lastupdated"/></xsl:attribute>
					<xsl:attribute name="availablefrom"><xsl:value-of select="@availablefrom"/></xsl:attribute>
					<xsl:attribute name="availableto"><xsl:value-of select="@availableto"/></xsl:attribute>
					<!--<xsl:attribute name="private"><xsl:value-of select="@private"/></xsl:attribute> not in prods -->
					<xsl:attribute name="publicationlevel">
						<xsl:choose>
							<xsl:when test="@wfstatus='draft'"><xsl:value-of select="1"/></xsl:when>
							<xsl:when test="@wfstatus='readyforvalidation'"><xsl:value-of select="2"/></xsl:when>
							<xsl:when test="@wfstatus='approved'"><xsl:value-of select="3"/></xsl:when>
							<xsl:when test="@wfstatus='rejected'"><xsl:value-of select="4"/></xsl:when>
							<xsl:when test="@wfstatus='deleted'"><xsl:value-of select="5"/><!-- </xsl:when><xsl:when test="@wfstatus='calculating'"><xsl:value-of select="6"/> not in the xsd --></xsl:when>
							<xsl:otherwise><xsl:value-of select="0"/></xsl:otherwise></xsl:choose></xsl:attribute>
					<xsl:attribute name="location"><xsl:value-of select="n1:location/n1:label"/></xsl:attribute>
					<xsl:attribute name="zipcode"><xsl:value-of select="n1:location/n1:address/n1:physical/n1:zipcode"/></xsl:attribute>
					<xsl:attribute name="city"><xsl:value-of select="n1:location/n1:address/n1:physical/n1:city"/></xsl:attribute>
					<xsl:attribute name="countryid"/>
					<xsl:if test="n1:location/n1:address/n1:physical/n1:country  != ''">
						<xsl:attribute name="country"><xsl:value-of select="n1:location/n1:address/n1:physical/n1:country"/></xsl:attribute>
					</xsl:if>
					<xsl:attribute name="organiser"><xsl:value-of select="n1:organiser/n1:label"/></xsl:attribute>
					<xsl:attribute name="beginsat">
						<xsl:choose>
							<xsl:when test="n1:calendar/n1:timestamps/n1:timestamp != ''">
								<xsl:value-of select="n1:calendar/n1:timestamps/n1:timestamp/n1:date"/>
							</xsl:when>
							<xsl:when test ="n1:calendar/n1:permanentopeningtimes"><xsl:value-of select="@availablefrom"/></xsl:when>
							<xsl:when test="n1:calendar/n1:periods/n1:period != ''"><xsl:value-of select="n1:calendar/n1:periods/n1:period/n1:datefrom"/></xsl:when></xsl:choose></xsl:attribute>
					<xsl:attribute name="endsat"><xsl:value-of select="@availableto"/></xsl:attribute>
					<xsl:attribute name="calendarsummary"><xsl:value-of select="n1:productiondetails/n1:productiondetail/n1:calendarsummary"/></xsl:attribute>
					<xsl:attribute name="weight"/>
					<xsl:attribute name="userDefinedWeight"/>
					<xsl:attribute name="lastImportedOn"/>
					<xsl:if test="n1:location/n1:address/n1:physical/n1:gis/n1:xcoordinate  != ''">
						<xsl:attribute name="xCoordinate"><xsl:value-of select="n1:location/n1:address/n1:physical/n1:gis/n1:xcoordinate"/></xsl:attribute>
						<xsl:attribute name="yCoordinate"><xsl:value-of select="n1:location/n1:address/n1:physical/n1:gis/n1:ycoordinate"/></xsl:attribute>
					</xsl:if>
					<xsl:attribute name="actief"/>
								<xsl:attribute name="lcidId"/> 
					<xsl:attribute name="deletedon"/>											<!-- from another xslt -->
					<xsl:attribute name="deleted"/>												<!-- from another xslt -->
					<xsl:attribute name="channelId"/>											<!-- ??? 1 or null -->
					<xsl:attribute name="userid"/>												<!-- ??? mailed Carlo,Stan,Luk-->
					<xsl:attribute name="isparent"><xsl:value-of select="0"/></xsl:attribute>
					<xsl:attribute name="opafspraak"/> 										<!-- n1:timestamp/n1:opentype last used April 2014 -->
					<xsl:attribute name="beslotenAanbod"/>
					<xsl:attribute name="hedendaags"/>
					<xsl:attribute name="permanent">		
						<xsl:choose>
								<xsl:when test ="n1:calendar/n1:permanentopeningtimes"><xsl:value-of select="1"></xsl:value-of></xsl:when>
							<xsl:otherwise><xsl:value-of select="0"></xsl:value-of></xsl:otherwise>
						</xsl:choose>
					  </xsl:attribute>	
					<xsl:attribute name="rankfactor"/>
					<xsl:if test="@published != ''">
						<xsl:attribute name="published"><xsl:value-of select="@published"/></xsl:attribute>
					</xsl:if>
					<xsl:attribute name="toBeValidatedBy"/>
					<xsl:attribute name="validatedBy"/>
					<!--<xsl:attribute name="completeness"><xsl:value-of select="@pctcomplete"/></xsl:attribute>not in prods -->
					<xsl:attribute name="type"/>
					<xsl:attribute name="thema"/>
					<xsl:attribute name="tags"><xsl:value-of select="n1:keywords"/></xsl:attribute>
					<xsl:variable name="performers">
						<xsl:for-each select="n1:productiondetails/n1:productiondetail/n1:performers/n1:performer/n1:label">
							<xsl:value-of select=".">
						</xsl:value-of>
						</xsl:for-each>
						<xsl:value-of select="','"/>
					</xsl:variable>
					<xsl:attribute name="performersxxx"><xsl:value-of select="string-length($performers)"/></xsl:attribute>
					<xsl:attribute name="performers"><xsl:value-of select="substring($performers,1,string-length($performers)-1)"/></xsl:attribute>
					<xsl:attribute name="deeplink"><xsl:for-each select="n1:contactinfo/n1:url"><xsl:if test="@main='true'"><xsl:value-of select="."/></xsl:if></xsl:for-each></xsl:attribute>
					<xsl:attribute name="defaultthumbnail"><xsl:for-each select="n1:eventdetails/n1:eventdetail/n1:media/n1:file"><xsl:if test="n1:mediatype='photo'"><xsl:value-of select="n1:filename"/></xsl:if></xsl:for-each></xsl:attribute>
					<xsl:attribute name="contactInfo"/>			<!-- not used -->
					<xsl:attribute name="soldout"/>				<!-- not in D_EVENT -->
					<xsl:attribute name="cancelled"/>			<!-- not in D_EVENT -->
					<xsl:attribute name="validatedOn"/>
					<xsl:attribute name="excludeHolidaysSundays"/>
					<xsl:attribute name="calendarComment"/>
					<xsl:attribute name="isKoepelaanbod"/>
					<xsl:attribute name="CleanLabel"/>
					<xsl:attribute name="ImportBlock"/>
					<xsl:if test="n1:bookingperiod/n1:datefrom != ''">
						<xsl:attribute name="bookingfrom"><xsl:value-of select="n1:bookingperiod/n1:datefrom"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="n1:bookingperiod/n1:dateto != ''">
						<xsl:attribute name="bookingto"><xsl:value-of select="n1:bookingperiod/n1:dateto"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="n1:maxparticipants != ''">
						<xsl:attribute name="maxParticipants"><xsl:value-of select="n1:maxparticipants"/></xsl:attribute>
					</xsl:if>
					<xsl:attribute name="isProduction"><xsl:value-of select="'1'"></xsl:value-of></xsl:attribute>
					<xsl:attribute name="hoofdgemeente"/>	<!-- generate this like it's done in STG_EVENT -->
					<xsl:attribute name="deleteReason"/>		<!-- not in xml -->
					<xsl:if test="n1:location/n1:label/@cdbid != ''">
						<xsl:attribute name="location_cdbid"><xsl:value-of select="n1:location/n1:label/@cdbid"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="n1:organiser/n1:label/@cdbid != ''">
						<xsl:attribute name="organiser_cdbid"><xsl:value-of select="n1:organiser/n1:label/@cdbid"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="n1:location/n1:address/n1:physical/n1:street != ''">
						<xsl:attribute name="street"><xsl:value-of select="n1:location/n1:address/n1:physical/n1:street"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="n1:location/n1:address/n1:physical/n1:housenr != ''">
						<xsl:attribute name="housenr"><xsl:value-of select="n1:location/n1:address/n1:physical/n1:housenr"/></xsl:attribute>
					</xsl:if>
				</event>
			</xsl:for-each>
			<!--</events>-->
		</cdbxml>
	</xsl:template>
	<xsl:template match="node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@*">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="/">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
<!--
<xsl:variable name="cdbid">
						<xsl:value-of select="@cdbid"/>
					</xsl:variable>
					<xsl:for-each select="n1:categories">
						<xsl:for-each select="n1:category">
							<categories>
								<xsl:attribute name="cdbid"><xsl:value-of select="$cdbid"/></xsl:attribute>
								<xsl:attribute name="catid"><xsl:value-of select="@catid"/></xsl:attribute>
								<xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
								<xsl:attribute name="text"><xsl:value-of select="."/></xsl:attribute>
							</categories>
						</xsl:for-each>
					</xsl:for-each>
-->
