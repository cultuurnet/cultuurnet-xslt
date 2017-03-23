<?xml version="1.0" encoding="UTF-8"?>
<!--
this xslt removes the namespace associated with 3.1 Draft
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT"  exclude-result-prefixes="n1 xs">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="n1:cdbxml">
		<cdbxml>
			<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL D:\XML\XSD\CDB_3_1\UitDB_XSD\CdbXSD31.xsd</xsl:attribute>
			<xsl:apply-templates/>
		</cdbxml>
	</xsl:template>
	<xsl:template match="*">
		<xsl:element name="{name()}" namespace="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>




