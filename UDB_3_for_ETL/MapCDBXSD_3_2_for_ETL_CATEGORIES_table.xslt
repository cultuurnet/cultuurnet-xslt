<?xml version="1.0" encoding="UTF-8"?>
<!--
Transform CDB XSD 3.2 Final to Categories
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
					<xsl:for-each select="n1:categories/n1:category">
							<eventlcategories>
								<xsl:attribute name="id"/>
								<xsl:attribute name="eventid"/>
								<xsl:attribute name="cdbid"><xsl:value-of select="$cdbid"/></xsl:attribute>
								<xsl:attribute name="catid"><xsl:value-of select="@catid"></xsl:value-of></xsl:attribute>
								<xsl:attribute name="type"><xsl:value-of select="@type"></xsl:value-of></xsl:attribute>
								<xsl:attribute name="category"><xsl:value-of select="."></xsl:value-of></xsl:attribute>
							</eventlcategories>
					</xsl:for-each>
					<xsl:for-each select="n1:keywords">	
								<xsl:call-template name="extract_keywords">
									<xsl:with-param name="keywords" select="."/>
									<xsl:with-param name="cdbid" select="$cdbid"></xsl:with-param>
								</xsl:call-template>
					</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="n1:production">
				<xsl:variable name="cdbid">
					<xsl:value-of select="@cdbid"/>
				</xsl:variable>
					<xsl:for-each select="n1:categories/n1:category">
							<eventlcategories>
								<xsl:attribute name="id"/>
								<xsl:attribute name="eventid"/>
								<xsl:attribute name="cdbid"><xsl:value-of select="$cdbid"/></xsl:attribute>
								<xsl:attribute name="catid"><xsl:value-of select="@catid"></xsl:value-of></xsl:attribute>
								<xsl:attribute name="type"><xsl:value-of select="@type"></xsl:value-of></xsl:attribute>
								<xsl:attribute name="category"><xsl:value-of select="."></xsl:value-of></xsl:attribute>
							</eventlcategories>
					</xsl:for-each>
					<xsl:for-each select="n1:keywords">	
								<xsl:call-template name="extract_keywords">
									<xsl:with-param name="keywords" select="."/>
									<xsl:with-param name="cdbid" select="$cdbid"></xsl:with-param>
								</xsl:call-template>
					</xsl:for-each>
			</xsl:for-each>
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
	<xsl:template name="extract_keywords">
		<xsl:param name="keywords"/>
		<xsl:param name="cdbid"/>
			<xsl:choose>
				<xsl:when test="contains($keywords,';')">
					<eventlcategories>
						<xsl:attribute name="id"/>
						<xsl:attribute name="eventid"/>
						<xsl:attribute name="cdbid"><xsl:value-of select="$cdbid"/></xsl:attribute>
						<xsl:attribute name="catid"></xsl:attribute>
						<xsl:attribute name="type"><xsl:value-of select="'keyword'"></xsl:value-of></xsl:attribute>
						<xsl:attribute name="category"><xsl:value-of select="substring-before($keywords,';')"/></xsl:attribute>
					</eventlcategories>
					<xsl:call-template name="extract_keywords">
							<xsl:with-param name="keywords" select="substring-after($keywords,';')"/>
							<xsl:with-param name="cdbid" select="$cdbid"></xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<eventlcategories>
						<xsl:attribute name="id"/>
						<xsl:attribute name="eventid"/>
						<xsl:attribute name="cdbid"><xsl:value-of select="$cdbid"/></xsl:attribute>
						<xsl:attribute name="catid"></xsl:attribute>
						<xsl:attribute name="type"><xsl:value-of select="'keyword'"></xsl:value-of></xsl:attribute>
						<xsl:attribute name="category"><xsl:value-of select="$keywords"></xsl:value-of></xsl:attribute>
						</eventlcategories>
				</xsl:otherwise>
			</xsl:choose>
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
