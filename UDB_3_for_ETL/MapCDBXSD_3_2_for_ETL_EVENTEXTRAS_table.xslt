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
				<eventextras>
					<xsl:attribute name="id"/>
					<xsl:attribute name="eventid"/>
					<xsl:attribute name="cdbid"><xsl:value-of select="@cdbid"/></xsl:attribute>
					<xsl:attribute name="productionId"/>
					<xsl:attribute name="externalId"><xsl:value-of select="@externalid"/></xsl:attribute>
					<xsl:attribute name="validatedOn"/>
					<xsl:attribute name="legalOwner"/>
					<xsl:if test="n1:agefrom != ''">
						<xsl:attribute name="agefrom"><xsl:value-of select="n1:agefrom"/></xsl:attribute>
					</xsl:if>
					<xsl:attribute name="estimatedTime"><xsl:value-of select="n1:eventdetails/n1:eventdetail/n1:estimatedtime"/></xsl:attribute>
					<xsl:attribute name="longDescription"><xsl:value-of select="n1:eventdetails/n1:eventdetail/n1:longdescription"/></xsl:attribute>
					<xsl:attribute name="admission"/>
					<xsl:if test="n1:eventdetails/n1:eventdetail/n1:price/n1:pricevalue!= ''">
					
					<xsl:choose>
						<xsl:when test="contains(n1:eventdetails/n1:eventdetail/n1:price/n1:pricevalue,'E')">
						<!--  NOK
						<xsl:variable name="value"><xsl:value-of select="substring-before(n1:eventdetails/n1:eventdetail/n1:price/n1:pricevalue,'E')"></xsl:value-of></xsl:variable>
						<xsl:variable name="exp"><xsl:value-of select="substring-after(n1:eventdetails/n1:eventdetail/n1:price/n1:pricevalue,'E')"></xsl:value-of></xsl:variable>
						<xsl:variable name="new_price"><xsl:value-of select="number($value)*number($exp*10)"></xsl:value-of></xsl:variable>
-->
						<xsl:attribute name="price"><xsl:value-of select="0"/></xsl:attribute> 
						</xsl:when>
						
						
						<xsl:otherwise><xsl:attribute name="price"><xsl:value-of select="n1:eventdetails/n1:eventdetail/n1:price/n1:pricevalue"/></xsl:attribute></xsl:otherwise>
					</xsl:choose>


					<!--  <xsl:attribute name="price"><xsl:value-of select="n1:eventdetails/n1:eventdetail/n1:price/n1:pricevalue"/></xsl:attribute>  -->
					</xsl:if>
					<xsl:attribute name="pricedescription"><xsl:value-of select="n1:eventdetails/n1:eventdetail/n1:price/n1:pricedescription"/></xsl:attribute>	
					<xsl:attribute name="locationId"/>
					<xsl:attribute name="organiserId"/>
					<xsl:attribute name="reservations"/>
					<xsl:attribute name="reservationsId"/>
					<xsl:attribute name="street"/>
					<xsl:attribute name="houseNr"/>
					<xsl:attribute name="cityId"/>
					<xsl:attribute name="thumbnail"/>
					<xsl:attribute name="parentEventId"/>
					<xsl:if test="n1:location/n1:label/@cdbid != ''">
						<xsl:attribute name="location_cdbid"><xsl:value-of select="n1:location/n1:label/@cdbid"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="n1:organiser/n1:label/@cdbid != ''">
						<xsl:attribute name="organiser_cdbid"><xsl:value-of select="n1:organiser/n1:label/@cdbid"/></xsl:attribute>
					</xsl:if>
				</eventextras>
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
