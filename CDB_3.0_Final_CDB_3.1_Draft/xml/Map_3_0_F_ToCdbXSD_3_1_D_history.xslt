<?xml version="1.0" encoding="UTF-8"?>
<!--
this xslt removes the namespace associated with 3.1 Draft
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT" exclude-result-prefixes="n1 xs">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:param name="old_categorisation" select="'old_categorisation_01.xml'"/>
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
	<!-- Removed for historical imports 
	<xsl:template match="@externalid">
		<xsl:attribute name="cdbid"><xsl:value-of select="substring(.,1,60)"/></xsl:attribute>
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template> -->
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
			<!-- updated 26/08/10 to prevent double category names -->
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
						<xsl:attribute name="catid"><xsl:value-of select="$catid"/></xsl:attribute>
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
	<xsl:template match="n1:hlink">
		<hlink>
			<xsl:choose>
				<xsl:when test="substring(.,1,4) = 'http'">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'ftp://media:cnET2008Udb@media.cultuurnet.be/partnermedia/'"/>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</hlink>
	</xsl:template>
	<xsl:template match="n1:actor">
		<!--
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy> -->
		<actor>
			<xsl:if test="string(@externalid) = ''">
				<xsl:attribute name="externalid"><xsl:value-of select="n1:actordetails/n1:actordetail/n1:title"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="string(@cdbid) = ''">
				<xsl:attribute name="cdbid"><xsl:value-of select="n1:actordetails/n1:actordetail/n1:title"/></xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="@* | node()"/>
		</actor>
	</xsl:template>
	<!-- added 1/09/10. Contactinfo can be empty but this causes problems in the OOS and the export -->
	<xsl:template match="n1:contactinfo">
		<xsl:choose>
			<xsl:when test="string(.) != ''">
				<xsl:copy-of select="."/>
			</xsl:when>
			<!--<xsl:when test="string(./n1:location/n1:address) != ''"><xsl:copy-of select="./n1:location/n1:address"></xsl:copy-of></xsl:when>-->
			<xsl:otherwise>
				<contactinfo>
					<xsl:copy-of select="../n1:location/n1:address"/>
				</contactinfo>
			</xsl:otherwise>
		</xsl:choose>
		<!--	<xsl:copy-of select="."></xsl:copy-of> -->
	</xsl:template>
	<!-- added for historical imports -->
	<xsl:template match="@cdbid">
	
		<xsl:if test="name(../.) = 'event' or name(../.) = 'actor'">
			<xsl:attribute name="cdbid"><xsl:value-of select="."/></xsl:attribute>
			<xsl:choose>
				<xsl:when test="string(@externalid) = ''">
					<xsl:attribute name="externalid"><xsl:value-of select="'CDB:'"/><xsl:value-of select="."/></xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="externalid"><xsl:value-of select="@externalid"/></xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:attribute name="creationdate"><xsl:value-of select="'2007-01-01T00:00:00+01:00'"/></xsl:attribute>
			<xsl:attribute name="lastupdated"><xsl:value-of select="'2007-01-01T00:00:00+01:00'"/></xsl:attribute>
			</xsl:if>
	</xsl:template>
</xsl:stylesheet>
