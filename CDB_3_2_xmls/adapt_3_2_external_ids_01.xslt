<?xml version="1.0" encoding="UTF-8"?>
<!--

Use this on the Zap exports from the new IIS to remove the externalds of organisations and locations that end in :null

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" exclude-result-prefixes="n1 xs">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<xsl:apply-templates select="@*"/>
		<xsl:apply-templates select="node()"/>
	</xsl:template>
	<xsl:template match="node()">
		<xsl:choose>
			<xsl:when test="name() = 'label'">
				<label>
					<xsl:if test="substring(@externalid,string-length(@externalid)-4,5) != ':null'">
						<xsl:apply-templates select="@*"/>
					</xsl:if>
					<xsl:apply-templates select="node()"/>
					<!-- test <xsl:value-of select ="substring(@externalid,string-length(@externalid)-4,5)"></xsl:value-of> -->
				</label>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@* | node()"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="@*">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
