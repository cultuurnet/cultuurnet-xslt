<?xml version="1.0" encoding="UTF-8"?>
<!--
JCO : 12/03/15
Transform CDB XSD 3.2 Final to CDB XSD 3.3 Final
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:cdb="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.3/FINAL" xmlns:ns3="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs ns3">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="cdb:cdbxml">
		<cdbxml>
			<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.3/FINAL C:\XML\XSD\CDB_XSD_3_3\CdbXSD.xsd</xsl:attribute>
			<!-- http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL/CdbXSD.xsd -->
			<!--<events> -->
			<xsl:for-each select="cdb:event">
				<event>
					<xsl:apply-templates select="@*"/>
					<xsl:apply-templates select="node()"/>
				</event>
			</xsl:for-each>
			<xsl:for-each select="cdb:actor">
				<actor>
					<xsl:apply-templates select="@*"/>
					<xsl:apply-templates select="node()"/>
				</actor>
			</xsl:for-each>
			<xsl:for-each select="cdb:production">
				<production>
					<xsl:apply-templates select="@*"/>
					<xsl:apply-templates select="node()"/>
				</production>
			</xsl:for-each>
			<xsl:for-each select="cdb:deletes">
				<deletes>
					<xsl:apply-templates select="@*"/>
					<xsl:apply-templates select="node()"/>
				</deletes>
			</xsl:for-each>
			<!-- </events>-->
			<!--
			<xsl:if test="string(cdb:deletes) !=''">
				<deletes>
					<xsl:for-each select="cdb:deletes">
					<xsl:for-each select="cdb:delete">
						<xsl:copy-of select="."/>
						</xsl:for-each>
					</xsl:for-each> 
				 </deletes>
			</xsl:if>
-->
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
		<xsl:element name="{name()}" namespace="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.3/FINAL">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="cdb:keywords">
		<!--<xsl:value-of select="string-length(.)"/>-->
		<xsl:if test="string-length(.) != 0">
			<keywords>
				<xsl:call-template name="replace-string">
					<xsl:with-param name="text" select="."/>
					<xsl:with-param name="replace" select="';'"/>
				</xsl:call-template>
			</keywords>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cdb:comments">
		<xsl:if test="string-length(.) != 0">
			<xsl:value-of select="."/>
		</xsl:if>
	</xsl:template>
	<!-- for test to get a valid xml	
	<xsl:template match="cdb:longdescription">
		<longdescription>
			<xsl:value-of select="'&lt;![CDATA['"/>
			<xsl:value-of select="."/>
			<xsl:value-of select="']]>'"/>
		</longdescription>
	</xsl:template>
-->
	<xsl:template name="replace-string">
		<xsl:param name="text"/>
		<xsl:param name="replace"/>
		<xsl:choose>
			<xsl:when test="contains($text,$replace)">
				<keyword>
					<xsl:value-of select="substring-before($text,$replace)"/>
				</keyword>
				<xsl:call-template name="replace-string">
					<xsl:with-param name="text" select="substring-after($text,$replace)"/>
					<xsl:with-param name="replace" select="$replace"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<keyword>
					<xsl:value-of select="$text"/>
				</keyword>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
