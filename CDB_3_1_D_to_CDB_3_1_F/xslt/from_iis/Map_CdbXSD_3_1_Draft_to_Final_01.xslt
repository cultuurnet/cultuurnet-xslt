<?xml version="1.0" encoding="UTF-8"?>
<!--

This xslt rmaps 3.1 Draft tto 3.1 Final
Use Map_3_1_D_to_3_1_F_fix_ns.xslt before and after this.

-->
<!-- 
I have to remove xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT" so that the xalan:nodeset works

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT" xmlns:ot="http://www.cultuurdatabank.be/XMLSchema/opening_times" xmlns:xalan="http://xml.apache.org/xalan" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT" xmlns:extfun="external_functions" exclude-result-prefixes="ot xalan n1 xs extfun">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>  -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL" xmlns:ot="http://www.cultuurdatabank.be/XMLSchema/opening_times" xmlns:xalan="http://xml.apache.org/xalan" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:extfun="external_functions" exclude-result-prefixes="ot xalan n1 xs extfun">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<!-- <xsl:include href="MapToOpeningTimes.xslt"/>
	<xsl:include href="summary.xslt"/>
	<xsl:param name="categories" select="'backwardmapping_01.xml'"/>
	<xsl:param name="old_categorisation" select="'old_categorisation_01.xml'"/> -->
	<!--
	<xsl:template match="n1:cdbxml">
		<cdbxml>
			<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/DRAFT http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFTL/CdbXSD.xsd</xsl:attribute>
		</cdbxml>
	</xsl:template> -->
	<xsl:template match="/">
		<xsl:apply-templates select="@*"/>
		<xsl:apply-templates select="node()"/>
	</xsl:template>
	<!--
	<xsl:template match="n1:cdbxml">
		<cdbxml>
			
		</cdbxml>
	</xsl:template> -->
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
	<xsl:template match="@*">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="n1:eventcategories">

	</xsl:template>
	<xsl:template match="n1:actorcategories">

	</xsl:template>
	<xsl:template match="n1:productioncategories">

	</xsl:template>
	<xsl:template match="n1:contactinfo">
		<xsl:if test="string(name(..)) = 'event'">
			<!-- event categories become categories -->
			<!-- test data
		<categories>
			<category type="eventtype" catid="0.50.4.0.0">Concert</category>
			<category type="theme" catid="1.8.1.0.0">Klassieke muziek </category>
			<category type="publicscope" catid="6.4.0.0.0">Internationaal</category>
		</categories>
		-->
			<categories>
				<xsl:for-each select="../n1:eventcategories/n1:themes/n1:theme">
					<category>
						<xsl:attribute name="type"><xsl:value-of select="'theme'"/></xsl:attribute>
						<xsl:attribute name="catid"><xsl:value-of select="@catid"/></xsl:attribute>
						<xsl:value-of select="."/>
					</category>
				</xsl:for-each>
				<xsl:for-each select="../n1:eventcategories/n1:types/n1:type">
					<category>
						<xsl:attribute name="type"><xsl:value-of select="'eventtype'"/></xsl:attribute>
						<xsl:attribute name="catid"><xsl:value-of select="@catid"/></xsl:attribute>
						<xsl:value-of select="."/>
					</category>
				</xsl:for-each>
				<xsl:for-each select="../n1:eventcategories/n1:publicscope">
					<category>
						<xsl:attribute name="type"><xsl:value-of select="'publicscope'"/></xsl:attribute>
						<xsl:attribute name="catid"><xsl:value-of select="@catid"/></xsl:attribute>
						<xsl:value-of select="."/>
					</category>
				</xsl:for-each>
				<xsl:for-each select="../n1:eventcategories/n1:targetaudiences/n1:targetaudience">
					<category>
						<xsl:attribute name="type"><xsl:value-of select="'targetaudience'"/></xsl:attribute>
						<xsl:attribute name="catid"><xsl:value-of select="@catid"/></xsl:attribute>
						<xsl:value-of select="."/>
					</category>
				</xsl:for-each>
				<xsl:for-each select="../n1:eventcategories/n1:facilities/n1:facility">
					<category>
						<xsl:attribute name="type"><xsl:value-of select="'facility'"/></xsl:attribute>
						<xsl:attribute name="catid"><xsl:value-of select="@catid"/></xsl:attribute>
						<xsl:value-of select="."/>
					</category>
				</xsl:for-each>
				<!-- 3.1 Final types
	actortype 			OK 
	eventtype 			OK
	municipal
	ipe
	theme 					OK
	facility					OK
	misc
	targetaudience 	OK
	publicscope 		OK

3.1 Draft
	admittance
	facilities				OK
	publicscope		OK		
	targetaudiences 	OK
	themes 				OK
	types 					OK
	-->
			</categories>
		</xsl:if>
		<!-- now copy the contact info -->
		<!-- remove the reservation url unless it's the only item in the contact infoand then copy it but with no reservation attribute-->
		<!-- <xsl:copy-of select="."/> -->
		<xsl:variable name="contactinfo">
			<contactinfo>
				<xsl:copy-of select="./n1:address"/>
				<xsl:copy-of select="./n1:mail"/>
				<xsl:copy-of select="./n1:phone"/>
				<xsl:for-each select="./n1:url">
					<xsl:if test="string(@reservation)  != 'true'">
						<xsl:copy-of select="."/>
					</xsl:if>
				</xsl:for-each>
			</contactinfo>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$contactinfo != ''">
				<xsl:copy-of select="$contactinfo"/>
			</xsl:when>
			<xsl:otherwise>
				<contactinfo>
					<url>
					<xsl:value-of select="./n1:url"/>
					</url>
				</contactinfo>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="n1:production/n1:languages">
		<categories>
			<xsl:for-each select="../n1:productioncategories/n1:themes/n1:theme">
				<category>
					<xsl:attribute name="type"><xsl:value-of select="'theme'"/></xsl:attribute>
					<xsl:attribute name="catid"><xsl:value-of select="@catid"/></xsl:attribute>
					<xsl:value-of select="."/>
				</category>
			</xsl:for-each>
			<xsl:for-each select="../n1:productioncategories/n1:types/n1:type">
				<category>
					<xsl:attribute name="type"><xsl:value-of select="'eventtype'"/></xsl:attribute>
					<xsl:attribute name="catid"><xsl:value-of select="@catid"/></xsl:attribute>
					<xsl:value-of select="."/>
				</category>
			</xsl:for-each>
			<xsl:for-each select="../n1:productioncategories/n1:publicscope">
				<category>
					<xsl:attribute name="type"><xsl:value-of select="'publicscope'"/></xsl:attribute>
					<xsl:attribute name="catid"><xsl:value-of select="@catid"/></xsl:attribute>
					<xsl:value-of select="."/>
				</category>
			</xsl:for-each>
			<xsl:for-each select="../n1:productioncategories/n1:targetaudiences">
				<category>
					<xsl:attribute name="type"><xsl:value-of select="'targetaudience'"/></xsl:attribute>
					<xsl:attribute name="catid"><xsl:value-of select="@catid"/></xsl:attribute>
					<xsl:value-of select="."/>
				</category>
			</xsl:for-each>
			<xsl:for-each select="../n1:productioncategories/n1:facilities/n1:facility">
				<category>
					<xsl:attribute name="type"><xsl:value-of select="'facility'"/></xsl:attribute>
					<xsl:attribute name="catid"><xsl:value-of select="@catid"/></xsl:attribute>
					<xsl:value-of select="."/>
				</category>
			</xsl:for-each>
		</categories>
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="n1:actordetails">
		<xsl:copy-of select="."/>
		<categories>
			<xsl:for-each select="../n1:actorcategories/n1:themes/n1:theme">
				<category>
					<xsl:attribute name="type"><xsl:value-of select="'theme'"/></xsl:attribute>
					<xsl:attribute name="catid"><xsl:value-of select="@catid"/></xsl:attribute>
					<xsl:value-of select="."/>
				</category>
			</xsl:for-each>
			<xsl:for-each select="../n1:actorcategories/n1:types/n1:type">
				<category>
					<xsl:attribute name="type"><xsl:value-of select="'actortype'"/></xsl:attribute>
					<xsl:attribute name="catid"><xsl:value-of select="@catid"/></xsl:attribute>
					<xsl:value-of select="."/>
				</category>
			</xsl:for-each>
			<xsl:for-each select="../n1:actorcategories/n1:publicscope">
				<category>
					<xsl:attribute name="type"><xsl:value-of select="'publicscope'"/></xsl:attribute>
					<xsl:attribute name="catid"><xsl:value-of select="@catid"/></xsl:attribute>
					<xsl:value-of select="."/>
				</category>
			</xsl:for-each>
			<xsl:for-each select="../n1:actorcategories/n1:targetaudiences">
				<category>
					<xsl:attribute name="type"><xsl:value-of select="'targetaudience'"/></xsl:attribute>
					<xsl:attribute name="catid"><xsl:value-of select="@catid"/></xsl:attribute>
					<xsl:value-of select="."/>
				</category>
			</xsl:for-each>
			<xsl:for-each select="../n1:actorcategories/n1:facilities">
				<category>
					<xsl:attribute name="type"><xsl:value-of select="'facility'"/></xsl:attribute>
					<xsl:attribute name="catid"><xsl:value-of select="@catid"/></xsl:attribute>
					<xsl:value-of select="."/>
				</category>
			</xsl:for-each>
		</categories>
	</xsl:template>
	<xsl:template match="n1:eventdetail">
		<eventdetail>
			<xsl:if test="@lang != ''">
				<xsl:attribute name="lang"><xsl:value-of select="@lang"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="n1:admission != ''">
				<xsl:copy-of select="n1:admission"/>
			</xsl:if>
			<xsl:if test="n1:calendarsummary != ''">
				<xsl:copy-of select="n1:calendarsummary"/>
			</xsl:if>
			<xsl:if test="n1:estimatedtime != ''">
				<xsl:copy-of select="n1:estimatedtime"/>
			</xsl:if>
			<xsl:if test="n1:performers != ''">
				<xsl:for-each select="n1:performers">
					<xsl:copy>
						<xsl:apply-templates select="@* | node()"/>
					</xsl:copy>
				</xsl:for-each>
			</xsl:if>
			<xsl:if test="n1:longdescription!= ''">
				<xsl:copy-of select="n1:longdescription"/>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="n1:media != ''">
					<media>
						<xsl:for-each select="n1:media/n1:file">
							<xsl:copy-of select="."/>
						</xsl:for-each>
						<xsl:if test="../../n1:contactinfo/n1:url/@reservation = 'true'">
							<file>
								<hlink>
									<xsl:value-of select="../../n1:contactinfo/n1:url"/>
								</hlink>
								<mediatype>
									<xsl:value-of select="'other'"/>
								</mediatype>
								<title>
									<xsl:value-of select="'Reservation'"/>
								</title>
							</file>
						</xsl:if>
					</media>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="../../n1:contactinfo/n1:url/@reservation = 'true'">
						<media>
							<file>
								<hlink>
									<xsl:value-of select="../../n1:contactinfo/n1:url[@reservation = 'true']"/>
								</hlink>
								<mediatype>
									<xsl:value-of select="'other'"/>
								</mediatype>
								<title>
									<xsl:value-of select="'Reservation'"/>
								</title>
							</file>
						</media>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="n1:price != ''">
				<xsl:copy-of select="n1:price"/>
			</xsl:if>
			<xsl:if test="n1:shortdescription!= ''">
				<xsl:copy-of select="n1:shortdescription"/>
			</xsl:if>
			<xsl:if test="n1:title!= ''">
				<xsl:copy-of select="n1:title"/>
			</xsl:if>
		</eventdetail>
	</xsl:template>
</xsl:stylesheet>
