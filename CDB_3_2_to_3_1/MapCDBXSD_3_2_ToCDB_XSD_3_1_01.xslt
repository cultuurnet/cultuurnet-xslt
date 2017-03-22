<?xml version="1.0" encoding="UTF-8"?>
<!--
Transform CDB XSD 3.2 Final to CDB XSD 3.1 Final
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL" xmlns:ns3="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="n1 xs ns3">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="n1:cdbxml">
	<cdbxml>
	<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL/CdbXSD.xsd</xsl:attribute> 
		   <xsl:for-each select="n1:nofrecords">
				<nofrecords>
					<xsl:apply-templates select="@*"/>
					<xsl:apply-templates select="node()"/>
				</nofrecords>
			</xsl:for-each>
			<events>
				<xsl:for-each select="n1:event">
					<event>
						
						<xsl:apply-templates select="@*"/>
						<xsl:apply-templates select="node()"/>
					</event>
				</xsl:for-each>
			</events>
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

</xsl:stylesheet>
