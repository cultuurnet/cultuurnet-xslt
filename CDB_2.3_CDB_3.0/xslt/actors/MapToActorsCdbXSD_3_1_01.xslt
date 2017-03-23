<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT" xmlns:xs="http://www.w3.org/2001/XMLSchema"  xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT" exclude-result-prefixes="n1 xs">

	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	
	 <xsl:template match="/n1:cdbxml">
	 
	  

	
		<cdbxml>
	<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT
		http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT/CdbXSD.xsd</xsl:attribute> 
		<!-- <xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL&#10;&#9;&#9;http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL/CdbXSD.xsd</xsl:attribute>  -->
			<metadata>
				<versions>
					<categorisation>
						<xsl:attribute name="url"><xsl:value-of select="'http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL/categories/1.13/categorisation.xml'"/></xsl:attribute>
					</categorisation>
					<regions>
						<xsl:attribute name="url"><xsl:value-of select="'http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL/regions/1.0/regions.xml'"/></xsl:attribute>
					</regions>
				</versions>
			</metadata>
			<xsl:for-each select="//n1:events">
			<actors>
				<xsl:for-each select="//n1:actor">
					<xsl:copy-of select="."></xsl:copy-of>
				</xsl:for-each>
			</actors>
			</xsl:for-each>
			
		</cdbxml>
	</xsl:template>
</xsl:stylesheet>
