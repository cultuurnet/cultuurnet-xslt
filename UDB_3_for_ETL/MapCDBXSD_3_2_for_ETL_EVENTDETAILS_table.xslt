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
				<xsl:variable name="cdbid">
					<xsl:value-of select="@cdbid"/>
				</xsl:variable>
				<xsl:for-each select="n1:eventdetails">
					<xsl:for-each select="n1:eventdetail">
						<eventdetails>
							<xsl:attribute name="id"/>
							<xsl:attribute name="eventid"/>
							<xsl:attribute name="cdbid"><xsl:value-of select="$cdbid"/></xsl:attribute>
							<xsl:attribute name="languageId">
								<xsl:choose>
									<xsl:when test="@lang='nl'"><xsl:value-of select="4"/></xsl:when>
									<xsl:when test="@lang='fr'"><xsl:value-of select="3"/></xsl:when>
									<xsl:when test="@lang='en'"><xsl:value-of select="2"/></xsl:when>
									<xsl:when test="@lang='de'"><xsl:value-of select="1"/></xsl:when>
								</xsl:choose>
							</xsl:attribute>
							<xsl:attribute name="label"><xsl:value-of select="n1:title"/></xsl:attribute>
							<xsl:attribute name="longDescription"><xsl:value-of select="n1:longdescription"/></xsl:attribute>
						</eventdetails>
					</xsl:for-each>
				</xsl:for-each>
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
