<?xml version="1.0" encoding="UTF-8"?>
<!--
Converts 3.0 Final to 3.1 Draft. Run Map_3_0_ToCdbXSD_3_1_fix_ns.xslt first.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL" exclude-result-prefixes="n1 xs">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="n1:cdbxml">
		<cdbxml>
		<!--
			<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL/CdbXSD.xsd</xsl:attribute> -->
		</cdbxml>
	</xsl:template>
	<xsl:template match="node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="/">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@*">ccc
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- remove these attributes -->
	<xsl:template match="@lastupdated"/>
	<xsl:template match="@owner"/>
	<xsl:template match="@method"/>
	<xsl:template match="@creationdate"/>
	<xsl:template match="@createdby"/>
	<xsl:template match="@validator"/>
	<xsl:template match="@lastupdatedby"/>
</xsl:stylesheet>
