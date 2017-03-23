<?xml version="1.0" encoding="UTF-8"?>
<!--
Transform CDB XSD 3.2 Final to 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" xmlns:ns3="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="n1 xs ns3">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="n1:cdbxml">
		<cdbxml>
			<!--<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/FINAL/CdbXSD.xsd</xsl:attribute> -->
			<!--<events>-->
			<xsl:for-each select="n1:event">
				<!--<xsl:attribute name="id"/>-->
				<xsl:variable name="cdbid">
					<xsl:value-of select="@cdbid"/>
				</xsl:variable>
				<!--
						<xsl:choose>
							<xsl:when test="string(n1:calendar/n1:permanentopeningtimes) != ''"><xsl:value-of select="'PERM'"></xsl:value-of></xsl:when>
							<xsl:when test="string(n1:calendar/n1:periods) != ''"><xsl:value-of select="'PERIOD'"></xsl:value-of></xsl:when>
							<xsl:otherwise><xsl:value-of select="'TIMESTAMP'"></xsl:value-of></xsl:otherwise>
						</xsl:choose>
					-->
				<xsl:choose>
					<xsl:when test="n1:calendar/n1:permanentopeningtimes">
						<!--using a test on string lenght NOK in VS-->
						<!--<xsl:if test="@availablefrom != ''">-->
						<event>
							<xsl:attribute name="cdbid"><xsl:value-of select="$cdbid"/></xsl:attribute>
							<xsl:choose>
								<xsl:when test="@availablefrom != ''">
									<xsl:attribute name="startdate"><xsl:value-of select="substring(@availablefrom,1,10)"/></xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="startdate"><xsl:value-of select="substring(@creationdate,1,10)"/></xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
							<!--<xsl:attribute name="startdate"><xsl:value-of select="substring(@availablefrom,1,10)"/></xsl:attribute>-->
							<!--  <xsl:attribute name="enddate"><xsl:value-of select="substring(@availablefrom,1,4)+5"/><xsl:value-of select="'-12-31'"/></xsl:attribute>  -->
							<xsl:attribute name="enddate"><xsl:value-of select="'2025-12-31'"/></xsl:attribute>
							<xsl:attribute name="datetype"><xsl:value-of select="'permanent'"/></xsl:attribute>
						</event>
						<!--</xsl:if>-->
					</xsl:when>
					<xsl:when test="string(n1:calendar/n1:periods) != ''">
						<event>
							<xsl:attribute name="cdbid"><xsl:value-of select="$cdbid"/></xsl:attribute>
							<xsl:attribute name="startdate"><xsl:value-of select="n1:calendar/n1:periods/n1:period/n1:datefrom"/></xsl:attribute>
							<xsl:attribute name="enddate"><xsl:value-of select="n1:calendar/n1:periods/n1:period/n1:dateto"/></xsl:attribute>
							<xsl:attribute name="datetype"><xsl:value-of select="'period'"/></xsl:attribute>
						</event>
					</xsl:when>
					<!--
					<xsl:when test="string(n1:calendar/n1:periods) != ''">
						<xsl:call-template name="period">
							<xsl:with-param name="cdbid" select="$cdbid"/>
							<xsl:with-param name="datefrom" select="n1:calendar/n1:periods/n1:period/n1:datefrom"/>
							<xsl:with-param name="dateto" select="n1:calendar/n1:periods/n1:period/n1:dateto"/>
						</xsl:call-template>
					</xsl:when>
-->
					<xsl:otherwise>
						<xsl:call-template name="timestamp">
							<xsl:with-param name="cdbid" select="$cdbid"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			<xsl:for-each select="n1:production">
				<!--<xsl:attribute name="id"/>-->
				<xsl:variable name="cdbid">
					<xsl:value-of select="@cdbid"/>
				</xsl:variable>
				<!--
						<xsl:choose>
							<xsl:when test="string(n1:calendar/n1:permanentopeningtimes) != ''"><xsl:value-of select="'PERM'"></xsl:value-of></xsl:when>
							<xsl:when test="string(n1:calendar/n1:periods) != ''"><xsl:value-of select="'PERIOD'"></xsl:value-of></xsl:when>
							<xsl:otherwise><xsl:value-of select="'TIMESTAMP'"></xsl:value-of></xsl:otherwise>
						</xsl:choose>
					-->
				<event>
					<xsl:attribute name="cdbid"><xsl:value-of select="$cdbid"/></xsl:attribute>
					<xsl:choose>
						<xsl:when test="@availablefrom != ''">
							<xsl:attribute name="startdate"><xsl:value-of select="substring(@availablefrom,1,10)"/></xsl:attribute>
							
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="startdate"><xsl:value-of select="substring(@creationdate,1,10)"/></xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<!--<xsl:attribute name="startdate"><xsl:value-of select="substring(@availablefrom,1,10)"/></xsl:attribute>-->
					<!--  <xsl:attribute name="enddate"><xsl:value-of select="substring(@availablefrom,1,4)+5"/><xsl:value-of select="'-12-31'"/></xsl:attribute>  -->
					<xsl:attribute name="enddate"><xsl:value-of select="'2025-12-31'"/></xsl:attribute>
					<xsl:attribute name="datetype"><xsl:value-of select="'production'"/></xsl:attribute>
				</event>
			</xsl:for-each>
			<!--</events>-->
		</cdbxml>
	</xsl:template>
	<xsl:template name="timestamp">
		<xsl:param name="cdbid"/>
		<!-- remove doubles in ETL -->
		<xsl:for-each select="n1:calendar/n1:timestamps/n1:timestamp/n1:date">
			<event>
				<xsl:attribute name="cdbid"><xsl:value-of select="$cdbid"/></xsl:attribute>
				<xsl:attribute name="startdate"><xsl:value-of select="."/></xsl:attribute>
				<xsl:attribute name="enddate"><xsl:value-of select="."/></xsl:attribute>
				<xsl:attribute name="datetype"><xsl:value-of select="'timestamp'"/></xsl:attribute>
			</event>
		</xsl:for-each>
	</xsl:template>
	<!-- NOK. stack overfrows on some ranges 
	<xsl:template name="period">
		<xsl:param name="cdbid"/>
		<xsl:param name="datefrom"/>
		<xsl:param name="dateto"/>
		<event>
			<xsl:attribute name="cdbid"><xsl:value-of select="$cdbid"/></xsl:attribute>
			<xsl:attribute name="date"><xsl:value-of select="$datefrom"/></xsl:attribute>
		</event>
		
		<xsl:if test="$datefrom != $dateto">
			<xsl:call-template name="period">
				<xsl:with-param name="cdbid" select="$cdbid"/>
				<xsl:with-param name="datefrom">
					<xsl:call-template name="addOneToDate">
						<xsl:with-param name="date" select="$datefrom"/>
					</xsl:call-template>
				</xsl:with-param>
				<xsl:with-param name="dateto" select="$dateto"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	
	
	<xsl:template name="addOneToDate">
		<xsl:param name="date"/>
		<xsl:variable name="year" select="number(substring($date, 1, 4))"/>
		<xsl:variable name="month" select="number(substring($date, 6, 2))"/>
		<xsl:variable name="day" select="number(substring($date, 9, 2))"/>
		<xsl:variable name="daysInMonth">
			<xsl:choose>
				<xsl:when test="$month = 2">
					<xsl:choose>
						<xsl:when test="($year div 4 = 0 and $year div 100 != 0) or ($year div 400 = 0)">29</xsl:when>
						<xsl:otherwise>28</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$month = 4 or $month = 6 or $month = 9 or $month = 11">30</xsl:when>
				<xsl:otherwise>31</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$day != $daysInMonth">
				<xsl:value-of select="concat($year, '-', format-number($month, '00'), '-', format-number($day + 1, '00'))"/>
			</xsl:when>
			<xsl:when test="$month = 12">
				<xsl:value-of select="concat($year + 1, '-01-01')"/>
			</xsl:when>
			<xsl:otherwise>
				
				<xsl:value-of select="concat($year, '-', format-number($month + 1, '00'), '-01')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	-->
	<!--
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
	</xsl:template>-->
</xsl:stylesheet>
