<?xml version="1.0" encoding="UTF-8"?>
<!--
Transform CDB XSD 3.2 Final to ActorAddress

       <cdb:physical>
	<cdb:city>Turnhout</cdb:city>
	<cdb:country>BE</cdb:country>
	<cdb:gis>
		<cdb:xcoordinate>4.951435</cdb:xcoordinate>
		<cdb:ycoordinate>51.320192</cdb:ycoordinate>
	</cdb:gis>
	<cdb:housenr>18</cdb:housenr>
	<cdb:street>Druivenstraat</cdb:street>
	<cdb:zipcode>2300</cdb:zipcode>
</cdb:physical>
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" xmlns:ns3="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="n1 xs ns3">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="n1:cdbxml">
		<cdbxml>
			<!--<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL/CdbXSD.xsd</xsl:attribute> -->
			<!--<events>-->
			<!-- wait with this.... also add it to actor if needed ??
			<xsl:for-each select="n1:event/n1:location">
				<xsl:if test="string(n1:label/@cdbid) != ''">
					<actoraddress>
						<xsl:attribute name="id"/>
						<xsl:attribute name="cdbid"><xsl:value-of select="n1:label/@cdbid"/></xsl:attribute>
						<xsl:attribute name="city"><xsl:value-of select="n1:address/n1:physical/n1:city"/></xsl:attribute>
						<xsl:attribute name="country"><xsl:value-of select="n1:address/n1:physical/n1:country"/></xsl:attribute>
						<xsl:if test="string(n1:address/n1:physical/n1:gis) != ''">
							<xsl:attribute name="xcoordinate"><xsl:value-of select="n1:address/n1:physical/n1:gis/n1:xcoordinate"/></xsl:attribute>
							<xsl:attribute name="ycoordinate"><xsl:value-of select="n1:address/n1:physical/n1:gis/n1:ycoordinate"/></xsl:attribute>
						</xsl:if>
						<xsl:if test="string(n1:address/n1:physical/n1:housenr) != ''">
							<xsl:attribute name="housenr"><xsl:value-of select="n1:address/n1:physical/n1:housenr"/></xsl:attribute>
						</xsl:if>
						<xsl:if test="string(n1:address/n1:physical/n1:street) != ''">
							<xsl:attribute name="street"><xsl:value-of select="n1:address/n1:physical/n1:street"/></xsl:attribute>
						</xsl:if>
						<xsl:attribute name="zipcode"><xsl:value-of select="n1:address/n1:physical/n1:zipcode"/></xsl:attribute>
					</actoraddress>
				</xsl:if>
			</xsl:for-each> -->
			<xsl:for-each select="n1:actor">
				
					<actoraddress>
						<xsl:attribute name="id"/>
						<xsl:attribute name="cdbid"><xsl:value-of select="@cdbid"/></xsl:attribute>		
						<xsl:attribute name="city"><xsl:value-of select="n1:contactinfo/n1:address/n1:physical/n1:city"/></xsl:attribute>
						<xsl:attribute name="country"><xsl:value-of select="n1:contactinfo/n1:address/n1:physical/n1:country"/></xsl:attribute>
						<xsl:if test="string(n1:contactinfo/n1:address/n1:physical/n1:gis) != ''">
							<xsl:attribute name="xcoordinate"><xsl:value-of select="n1:contactinfo/n1:address/n1:physical/n1:gis/n1:xcoordinate"/></xsl:attribute>
							<xsl:attribute name="ycoordinate"><xsl:value-of select="n1:contactinfo/n1:address/n1:physical/n1:gis/n1:ycoordinate"/></xsl:attribute>
						</xsl:if>
						<xsl:if test="string(n1:contactinfo/n1:address/n1:physical/n1:housenr) != ''">
							<xsl:attribute name="housenr"><xsl:value-of select="n1:contactinfo/n1:address/n1:physical/n1:housenr"/></xsl:attribute>
						</xsl:if>
						<xsl:if test="string(n1:contactinfo/n1:address/n1:physical/n1:street) != ''">
							<xsl:attribute name="street"><xsl:value-of select="n1:contactinfo/n1:address/n1:physical/n1:street"/></xsl:attribute>
						</xsl:if>
						<xsl:attribute name="zipcode"><xsl:value-of select="n1:contactinfo/n1:address/n1:physical/n1:zipcode"/></xsl:attribute>
					</actoraddress>
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
