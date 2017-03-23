<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT" xmlns:xs="http://www.w3.org/2001/XMLSchema"  xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT" exclude-result-prefixes="n1 xs">

	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	
	<xsl:template match="/n1:cdbxml">
	
		<cdbxml>
	<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT
		http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT/CdbXSD.xsd</xsl:attribute> 
		<!-- <xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL&#10;&#9;&#9;http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL/CdbXSD.xsd</xsl:attribute>  -->
			
			<calendarsummary>
				<xsl:for-each select="//calendarsummary">xxx
					<xsl:copy-of select="."></xsl:copy-of>
				</xsl:for-each>
			</calendarsummary>
			
		</cdbxml>
	</xsl:template>
</xsl:stylesheet>
