<?xml version="1.0" encoding="UTF-8"?>
<!--
this xslt removes the namespace associated with 3.1 Draft
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT" exclude-result-prefixes="n1 xs">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:param name="old_categorisation" select="'old_categorisation_01.xml'"/>
	<xsl:param name="iis.publication.name"/>
	<!--
	<xsl:template match="n1:cdbxml">
		<cdbxml>
			<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT/CdbXSD.xsd</xsl:attribute>
			<xsl:apply-templates/>
		</cdbxml>
	</xsl:template> -->
	<xsl:template match="/">
		<xsl:apply-templates select="@*"/>
		<xsl:apply-templates select="node()"/>
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
	<xsl:template match="@externalid">
		<xsl:attribute name="cdbid"><xsl:value-of select="substring(.,1,60)"/></xsl:attribute>
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- we have to add the category names if they don't exist -->
	<!-- except for sector -->
	<xsl:template match="@catid">
		<xsl:variable name="catid">
			<xsl:value-of select="translate(.,' ','')"/>
		</xsl:variable>
		<xsl:if test="string($catid) != ''">
			<xsl:variable name="category">
				<xsl:value-of select="name(../.)"/>
			</xsl:variable>
			<xsl:variable name="category_name">
				<xsl:value-of select="document($old_categorisation)/cdbxml/categorisation/item[@catid=$catid]/@label"/>
			</xsl:variable>
			<xsl:attribute name="catid"><xsl:value-of select="$catid"/></xsl:attribute>
			<!-- added 26/03/13 to prevent duplication of cat names if the partner sends a name -->
			<xsl:if test="string(../.) = ''">
				<xsl:if test="string(name(../.)) != 'sector'">
					<xsl:value-of select="$category_name"/>
				</xsl:if>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<!-- this is needed bacause sometimes targetaudience doesn't contain a catid -->
	<xsl:template match="n1:targetaudiences">
		<xsl:variable name="all_targets">
			<xsl:for-each select="n1:targetaudience">
				<xsl:variable name="catid">
					<xsl:value-of select="translate(@catid,' ','')"/>
				</xsl:variable>
				<xsl:if test="string($catid) != ''">
					<xsl:variable name="category">
						<xsl:value-of select="name(../.)"/>
					</xsl:variable>
					<xsl:variable name="category_name">
						<xsl:value-of select="document($old_categorisation)/cdbxml/categorisation/item[@catid=$catid]/@label"/>
					</xsl:variable>
					<targetaudience>
						<!-- Modified on 22/03/13 so that 2.2.6.0.0 is translated to 2.1.5.0.0 for Senioren -->
						<!-- <xsl:attribute name="catid"><xsl:value-of select="$catid"/></xsl:attribute> -->
						<xsl:choose>
							<xsl:when test="string($catid) = '2.2.6.0.0'">
								<xsl:attribute name="catid"><xsl:value-of select="'2.1.5.0.0'"/></xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="catid"><xsl:value-of select="$catid"/></xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="$category_name"/>
					</targetaudience>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:if test="string($all_targets) != ''">
			<targetaudiences>
				<xsl:copy-of select="$all_targets"/>
			</targetaudiences>
		</xsl:if>
	</xsl:template>
	<!-- anaxis sends urls with reservation=true but the urls are not ticketing links -->
	<xsl:template match="n1:url">
		<xsl:choose>
			<xsl:when test="string($iis.publication.name) = 'anaxisimportl' or string($iis.publication.name) = 'vzwderand'">
				<url>
					<!-- <xsl:attribute name="reservation"><xsl:value-of select="false()"/></xsl:attribute> not needed -->
					<xsl:value-of select="."/>
				</url>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
