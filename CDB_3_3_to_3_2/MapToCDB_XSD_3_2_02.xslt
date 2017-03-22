<?xml version="1.0" encoding="UTF-8"?>
<!--
Transform CDB XSD 3.3 Final to CDB XSD 3.2 Final
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.3/FINAL" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" xmlns:ns3="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="n1 xs ns3">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="n1:cdbxml">
		<cdbxml>
			<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL C:\XML\XSD\CDB_XSD_3_2\CdbXSD.xsd</xsl:attribute>
			<!-- http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL/CdbXSD.xsd -->
			<xsl:for-each select="n1:nofrecords">
				<nofrecords>
					<xsl:apply-templates select="@*"/>
					<xsl:apply-templates select="node()"/>
				</nofrecords>
			</xsl:for-each>
			<!--<events> -->
			<xsl:for-each select="n1:event">
				<event>
					<xsl:apply-templates select="@*"/>
					<xsl:apply-templates select="node()"/>
				</event>
			</xsl:for-each>
			<xsl:for-each select="n1:actor">
				<actor>
					<xsl:apply-templates select="@*"/>
					<xsl:apply-templates select="node()"/>
				</actor>
			</xsl:for-each>
			<xsl:for-each select="n1:production">
				<production>
					<xsl:apply-templates select="@*"/>
					<xsl:apply-templates select="node()"/>
				</production>
			</xsl:for-each>
			
			<!-- </events>-->
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
	<xsl:template match="*">
		<xsl:element name="{name()}" namespace="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<!--
	<xsl:template match="n1:category">zzzzzzzzzz
	<xsl:choose>
		<xsl:when test="string(@type) = 'educationlevel' or string(@type) = 'educationfield' or string(@type) = 'educationgrade' or string(@type) = 'flandersregion'"></xsl:when>
	<xsl:otherwise>
		<category>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates select="node()"/>
		</category>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
-->
	<xsl:template match="n1:keywords">
		<!--<xsl:value-of select="string-length(.)"/>-->
		<xsl:if test="string-length(.) != 0">
			<keywords>
				<xsl:for-each select="n1:keyword">
					<xsl:value-of select=".">	</xsl:value-of>
					<xsl:value-of select="','"/>
				</xsl:for-each>
			</keywords>
		</xsl:if>
	</xsl:template>
	<xsl:template match="n1:description"/>
	<xsl:template match="n1:publisher"/>
	<xsl:template match="@weight"/>
</xsl:stylesheet>
