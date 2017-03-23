<?xml version="1.0" encoding="UTF-8"?>
<!--
Transform CDB XSD 3.2 Final to 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" xmlns:ns3="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="n1 xs ns3">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="n1:cdbxml">
		<cdbxml>
			<!--<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL/CdbXSD.xsd</xsl:attribute> -->
			<actors>
				<!-- organisers have no cdbids -->
				<!-- do this in case a new non asset address has been added -->
				<!-- wait till we know what's going on 
				<xsl:for-each select="n1:event/n1:location">
					<xsl:if test="string(n1:label/@cdbid) != ''">
						<actor>
							<xsl:attribute name="id"/>
							<xsl:attribute name="cdbid"><xsl:value-of select="n1:label/@cdbid"/></xsl:attribute>
						</actor>
					</xsl:if>
				</xsl:for-each>
-->
				<xsl:for-each select="n1:actor">
					<actor>
						<xsl:attribute name="cdbid"><xsl:value-of select="@cdbid"/></xsl:attribute>
						<!--<xsl:attribute name="cdbidtest"><xsl:value-of select="string('abcde')" /></xsl:attribute>-->
						<!--
						<xsl:apply-templates select="@*"/>
						<xsl:apply-templates select="node()"/>
-->
					</actor>
				</xsl:for-each>
			</actors>
			<xsl:if test="string(n1:deletes) !=''">
				<deletes>
					<xsl:for-each select="n1:deletes">
						<xsl:copy-of select="."/>
					</xsl:for-each>
				</deletes>
			</xsl:if>
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
	<!--
	<xsl:template match="n1:category">
	<xsl:choose>
		<xsl:when test="string(@type) = 'educationlevel' or string(@type) = 'educationfield' or string(@type) = 'educationgrade' or string(@type) = 'flandersregion' or string(@type) = 'flanderstouristregion' or string(@type) = 'umv'"></xsl:when>
	<xsl:otherwise>
		<category>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates select="node()"/>
		</category>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="@publisher"/>
-->
</xsl:stylesheet>
