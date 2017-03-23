<?xml version="1.0" encoding="UTF-8"?>
<!--
Transform CDB XSD 3.2 Final to Actor

       [id]
		  ,[label]
		  ,[shortDescription]
		  ,[cdbId]
		  ,[createdOn]
		  ,[createdBy]
		  ,[lastModifiedOn]
		  ,[lastModifiedBy]
      ,[deletedOn]
      ,[deleted]
      ,[ownerUserPool]
		  ,[availableFrom]
		  ,[availableTo]
      ,xxx[private] 
      ,[archived]
      ,xxx[publicationLevel]
		  ,[isPerson]
      ,xx[lcidId]
		  ,[isLocatie]
		  ,[isOrganisator]
		  ,[isUitvoerder]
      ,[statusId]
      ,[completeness]
      ,[channelId]
      ,[userId]
      ,[defaultThumbnail]
      ,[contactInfo]
      ,[published]
      ,[ImportBlock]
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" xmlns:ns3="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="n1 xs ns3">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="n1:cdbxml">
		<cdbxml>
			<!--<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL/CdbXSD.xsd</xsl:attribute> -->
			<!--<events>-->
			<xsl:for-each select="n1:actor">
				<actor>
					
					<xsl:attribute name="id"/>
					<xsl:attribute name="label"><xsl:value-of select="n1:actordetails/n1:actordetail/n1:title"/></xsl:attribute>
					<xsl:attribute name="shortdescription"><xsl:value-of select="n1:actordetails/n1:actordetail/n1:shortdescription"/></xsl:attribute>
					<!--	<xsl:attribute name="shortdescriptionlength"><xsl:value-of select="string-length(n1:actordetails/n1:actordetail/n1:shortdescription)"/></xsl:attribute> -->
					<xsl:attribute name="cdbid"><xsl:value-of select="@cdbid"/></xsl:attribute>
					<xsl:attribute name="createdby"><xsl:value-of select="@createdby"/></xsl:attribute>
					<xsl:attribute name="lastModifiedby"><xsl:value-of select="@lastupdatedby"/></xsl:attribute>
					<xsl:attribute name="ownerUserPool"><xsl:value-of select="@owner"/></xsl:attribute>																									<!-- update D_EVENT to take this if -->
					<!--	<xsl:attribute name="ownerUserPool_length"><xsl:value-of select="string-length(@owner)"/></xsl:attribute>		-->		
					<xsl:attribute name="createdon"><xsl:value-of select="@creationdate"/></xsl:attribute>
					<xsl:attribute name="lastModifiedon"><xsl:value-of select="@lastupdated"/></xsl:attribute>
					
					<xsl:if test="availablefrom != ''">
						<xsl:attribute name="availablefrom"><xsl:value-of select="@availablefrom"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="availableto != ''">
						<xsl:attribute name="availableto"><xsl:value-of select="@availableto"/></xsl:attribute>
					</xsl:if>
					<xsl:attribute name="isPerson"></xsl:attribute>
					<!--
						<xsl:choose>
							<xsl:when test=". = 'Locatie'"><xsl:value-of select="1"></xsl:value-of></xsl:when>
							<xsl:otherwise><xsl:value-of select="0"></xsl:value-of></xsl:otherwise>
						</xsl:choose>-->
					<xsl:variable name="isloc">
						<xsl:for-each select="n1:categories/n1:category">
							<xsl:if test=". = 'Locatie'"><xsl:value-of select="1"></xsl:value-of></xsl:if>
						</xsl:for-each>
					</xsl:variable>
					<xsl:attribute name="isLocatie">
						<xsl:choose>
							<xsl:when test="$isloc = 1"><xsl:value-of select="1"></xsl:value-of></xsl:when>
							<xsl:otherwise><xsl:value-of select="0"></xsl:value-of></xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					
					<xsl:variable name="isorg">
						<xsl:for-each select="n1:categories/n1:category">
							<xsl:if test=". = 'Organisator(en)'"><xsl:value-of select="1"></xsl:value-of></xsl:if>
						</xsl:for-each>
					</xsl:variable>
					<xsl:attribute name="isOrganisator">
						<xsl:choose>
							<xsl:when test="$isorg = 1"><xsl:value-of select="1"></xsl:value-of></xsl:when>
							<xsl:otherwise><xsl:value-of select="0"></xsl:value-of></xsl:otherwise>
							</xsl:choose>
					</xsl:attribute>

					<xsl:attribute name="isUitvoerder"></xsl:attribute>
					
			
				</actor>
			</xsl:for-each>
			<!--</events>-->
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
