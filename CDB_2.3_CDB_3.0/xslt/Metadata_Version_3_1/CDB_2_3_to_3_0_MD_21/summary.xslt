<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ot="http://www.cultuurdatabank.be/XMLSchema/opening_times" extension-element-prefixes="extfun" xmlns:extfun="external_functions" xmlns:xalan="http://xml.apache.org/xalan" version="1.0" exclude-result-prefixes="ot">
	<xsl:output method="xml" encoding="ISO-8859-1" indent="yes"/>
	<xsl:template name="tijdelijk_summary">
		<xsl:variable name="grouped_times_1">
			<xsl:for-each select="ot:opening_times">
				<xsl:call-template name="group_times_1"/>
			</xsl:for-each>
		</xsl:variable>
		<!-- <xsl:value-of select="$grouped_times_1"/> -->
		<xsl:choose>
			<xsl:when test="string($grouped_times_1) != ''"><xsl:value-of select="$grouped_times_1"/></xsl:when>
		<xsl:otherwise>
		<xsl:for-each select="ot:opening_times">
			<xsl:for-each select="opening_times_instance">
				<xsl:variable name="pos" select="position()"/>
				<xsl:if test="position() = 1">
					<!--  <xsl:value-of select="day_type"/>  -->
					<xsl:call-template name="shorten_day"/>
					<xsl:value-of select="' '"/>
					<xsl:value-of select="substring(time_start,9,2)"/>
					<xsl:value-of select="'/'"/>
					<xsl:value-of select="substring(time_start,6,2)"/>
					<xsl:value-of select="'/'"/>
					<!-- use 08 instead of 2008 -->
					<xsl:value-of select="substring(time_start,3,2)"/>
					<xsl:if test="substring(time_start,12,8) != '00:00:00' and substring(time_start,12,5) !='23:59'">
						<xsl:choose>
							<xsl:when test="substring(time_end,12,8) != '00:00:00' and substring(time_end,12,5) !='23:59' and
							substring(time_start,12,8) != substring(time_end,12,8)">
								<xsl:value-of select="' van '"/>
								<xsl:value-of select="substring(time_start,12,5)"/>
								<xsl:value-of select="' tot '"/>
								<xsl:value-of select="substring(time_end,12,5)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="' om '"/>
								<xsl:value-of select="substring(time_start,12,5)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</xsl:if>
				<xsl:if test="position() != 1">
					<!--xxx<xsl:copy-of select="../../ot:opening_times/opening_times_instance[position() = $pos - 1]/time_start"></xsl:copy-of>zzz
						xxx<xsl:value-of select="time_start"></xsl:value-of>xxx
						zzz<xsl:value-of select="../../ot:opening_times/opening_times_instance[position() = $pos - 1]/time_start"></xsl:value-of>zzz-->
					<xsl:value-of select="', '"/>
					<xsl:if test="substring(time_start,1,10) !=substring(../../ot:opening_times/opening_times_instance[position() = $pos - 1]/time_start,1,10)">
						<!-- add a cf if the day is different -->
						<xsl:value-of select="'&#xA;'"/>
						<!-- <xsl:value-of select="day_type"/>  -->
						<xsl:call-template name="shorten_day"/>
						<xsl:value-of select="' '"/>
						<xsl:value-of select="substring(time_start,9,2)"/>
						<xsl:value-of select="'/'"/>
						<xsl:value-of select="substring(time_start,6,2)"/>
						<xsl:value-of select="'/'"/>
						<!-- use 08 instead of 2008 -->
						<xsl:value-of select="substring(time_start,3,2)"/>
					</xsl:if>
					<xsl:if test="substring(time_start,12,8) != '00:00:00' and substring(time_start,12,5) !='23:59'">
						<xsl:choose>
							<xsl:when test="substring(time_end,12,8) != '00:00:00' and substring(time_end,12,5) !='23:59' and
							substring(time_start,12,8) != substring(time_end,12,8)">
								<xsl:value-of select="' van '"/>
								<xsl:value-of select="substring(time_start,12,5)"/>
								<xsl:value-of select="' tot '"/>
								<xsl:value-of select="substring(time_end,12,5)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="' om '"/>
								<xsl:value-of select="substring(time_start,12,5)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="group_times_1">
		<!-- check if all the opening times instances have the same timestart and end -->
		
		
		<xsl:variable name="check_times">
			<xsl:for-each select="opening_times_instance">
				<xsl:variable name="pos" select="position()"/>
				<xsl:choose>
					<xsl:when test="((substring(time_start,12,8) = substring(../../ot:opening_times/opening_times_instance[position() = $pos + 1]/time_start,12,8)) and
									(substring(time_end,12,8) = substring(../../ot:opening_times/opening_times_instance[position() = $pos + 1]/time_end,12,8))) or
									(substring(../../ot:opening_times/opening_times_instance[position() = $pos + 1]/time_end,12,8) = '')">
						<xsl:value-of select="'true'"/>
						
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'false'"/>
						
						
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="(substring(time_start,12,8) = substring(../../ot:opening_times/opening_times_instance[position() = $pos + 1]/time_start,12,8)) and
									(substring(time_end,12,8) = substring(../../ot:opening_times/opening_times_instance[position() = $pos + 1]/time_end,12,8))">
			</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		
			<!-- <xsl:value-of select="$check_times"/> -->
		
			<xsl:if test="not(contains(string($check_times),'false'))">
			
			<xsl:for-each select="opening_times_instance">
				<xsl:variable name="pos" select="position()"/>
				<xsl:if test="position() = 1">
					<!--  <xsl:value-of select="day_type"/>  -->
					<xsl:call-template name="shorten_day"/>
					<xsl:value-of select="' '"/>
					<xsl:value-of select="substring(time_start,9,2)"/>
					<xsl:value-of select="'/'"/>
					<xsl:value-of select="substring(time_start,6,2)"/>
					<xsl:value-of select="'/'"/>
					<!-- use 08 instead of 2008 -->
					<xsl:value-of select="substring(time_start,3,2)"/>
					<xsl:if test="substring(time_start,12,8) != '00:00:00' and substring(time_start,12,5) !='23:59'">
						<xsl:if test="substring(time_start,12,8) != substring(../../ot:opening_times/opening_times_instance[position() = $pos + 1]/time_start,12,8)">
							<xsl:choose>
								<xsl:when test="substring(time_end,12,8) != '00:00:00' and substring(time_end,12,5) !='23:59' and
							substring(time_start,12,8) != substring(time_end,12,8)">
									<xsl:value-of select="' van '"/>
									<xsl:value-of select="substring(time_start,12,5)"/>
									<xsl:value-of select="' tot '"/>
									<xsl:value-of select="substring(time_end,12,5)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="' om '"/>
									<xsl:value-of select="substring(time_start,12,5)"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</xsl:if>
				</xsl:if>
				<xsl:if test="position() != 1">
					<xsl:value-of select="', '"/>
					<xsl:if test="substring(time_start,1,10) !=substring(../../ot:opening_times/opening_times_instance[position() = $pos - 1]/time_start,1,10)">
						<!-- add a cf if the day is different. Not in the case of a group -->
						<!--<xsl:value-of select="'&#xA;'"/> -->
						<!-- <xsl:value-of select="day_type"/>  -->
						<xsl:call-template name="shorten_day"/>
						<xsl:value-of select="' '"/>
						<xsl:value-of select="substring(time_start,9,2)"/>
						<xsl:value-of select="'/'"/>
						<xsl:value-of select="substring(time_start,6,2)"/>
						<xsl:value-of select="'/'"/>
						<!-- use 08 instead of 2008 -->
						<xsl:value-of select="substring(time_start,3,2)"/>
					</xsl:if>
					<xsl:if test="substring(time_start,12,8) != '00:00:00' and substring(time_start,12,5) !='23:59'">
						<xsl:if test="substring(time_start,12,8) != substring(../../ot:opening_times/opening_times_instance[position() = $pos + 1]/time_start,12,8)">
							<xsl:choose>
								<xsl:when test="substring(time_end,12,8) != '00:00:00' and substring(time_end,12,5) !='23:59' and
							substring(time_start,12,8) != substring(time_end,12,8)">
									<xsl:value-of select="' van '"/>
									<xsl:value-of select="substring(time_start,12,5)"/>
									<xsl:value-of select="' tot '"/>
									<xsl:value-of select="substring(time_end,12,5)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="' om '"/>
									<xsl:value-of select="substring(time_start,12,5)"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	<xsl:template name="period_summary">
		<xsl:value-of select="'Van '"/>
		<xsl:value-of select="substring(date_from,9,2)"/>
		<xsl:value-of select="'/'"/>
		<xsl:value-of select="substring(date_from,6,2)"/>
		<xsl:value-of select="'/'"/>
		<xsl:value-of select="substring(date_from,3,2)"/>
		<xsl:value-of select="' tot '"/>
		<xsl:value-of select="substring(date_to,9,2)"/>
		<xsl:value-of select="'/'"/>
		<xsl:value-of select="substring(date_to,6,2)"/>
		<xsl:value-of select="'/'"/>
		<xsl:value-of select="substring(date_to,3,2)"/>
		<xsl:value-of select="'&#xA;'"/>
		<xsl:value-of select="'open '"/>
		<!-- A period event is just the same as a permanent event except it has a start and an end date -->
		<!-- see previous versons for the old code -->
		<xsl:call-template name="org_summary"/>
	</xsl:template>
	<!-- following used for permanent events and organisations -->
	<xsl:template name="org_summary">
		<!-- an organisation is always considered as a permanent event, but it may be cloosed all the time 	-->
		<!-- first process the week schemas ie the year = 1970																		-->
		<xsl:for-each select="ot:opening_times">
			<!-- create strings of the opening time without the &#xA; to check for patterns -->
			<xsl:variable name="times_mon">
				<xsl:for-each select="opening_times_instance[open_type = 'open' and day_type = 'maandag' and year = '1970']">
					<xsl:call-template name="times_string"/>
				</xsl:for-each>
			</xsl:variable>
			<xsl:variable name="times_tue">
				<xsl:for-each select="opening_times_instance[open_type = 'open' and day_type = 'dinsdag' and year = '1970']">
					<xsl:call-template name="times_string"/>
				</xsl:for-each>
			</xsl:variable>
			<xsl:variable name="times_wed">
				<xsl:for-each select="opening_times_instance[open_type = 'open' and day_type = 'woensdag' and year = '1970']">
					<xsl:call-template name="times_string"/>
				</xsl:for-each>
			</xsl:variable>
			<xsl:variable name="times_thu">
				<xsl:for-each select="opening_times_instance[open_type = 'open' and day_type = 'donderdag' and year = '1970']">
					<xsl:call-template name="times_string"/>
				</xsl:for-each>
			</xsl:variable>
			<xsl:variable name="times_fri">
				<xsl:for-each select="opening_times_instance[open_type = 'open' and day_type = 'vrijdag' and year = '1970']">
					<xsl:call-template name="times_string"/>
				</xsl:for-each>
			</xsl:variable>
			<xsl:variable name="times_sat">
				<xsl:for-each select="opening_times_instance[open_type = 'open' and day_type = 'zaterdag' and year = '1970']">
					<xsl:call-template name="times_string"/>
				</xsl:for-each>
			</xsl:variable>
			<xsl:variable name="times_sun">
				<xsl:for-each select="opening_times_instance[open_type = 'open' and day_type = 'zondag' and year = '1970']">
					<xsl:call-template name="times_string"/>
				</xsl:for-each>
			</xsl:variable>
			
			<!-- get a list of the days that are open wil include doubles etc-->
			<!-- include the year so that we don't take the exceptions -->
			<xsl:variable name="days_open">
				<!-- <xsl:for-each select="opening_times_instance[open_type = 'open']">  -->
				<xsl:for-each select="opening_times_instance[open_type = 'open' and year = '1970']">
					<xsl:value-of select="day_type"/>
				</xsl:for-each>
			</xsl:variable>
			<xsl:variable name="sequences_1">
				<xsl:if test="($times_mon = $times_tue) and string($times_tue) != ''">
					<xsl:value-of select="1"/>
				</xsl:if>
				<xsl:if test="($times_tue = $times_wed) and string($times_wed) != ''">
					<xsl:value-of select="2"/>
				</xsl:if>
				<xsl:if test="($times_wed = $times_thu) and string($times_thu) != ''">
					<xsl:value-of select="3"/>
				</xsl:if>
				<xsl:if test="($times_thu = $times_fri) and string($times_fri) != ''">
					<xsl:value-of select="4"/>
				</xsl:if>
				<xsl:if test="($times_fri = $times_sat) and string($times_sat) != ''">
					<xsl:value-of select="5"/>
				</xsl:if>
				<xsl:if test="($times_sat = $times_sun) and string($times_sun) != ''">
					<xsl:value-of select="6"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="group_1">
				<xsl:if test="($times_mon = $times_tue) and string($times_tue) != ''">
					<xsl:value-of select="1"/>
				</xsl:if>
				<xsl:if test="($times_mon = $times_wed) and string($times_wed) != ''">
					<xsl:value-of select="2"/>
				</xsl:if>
				<xsl:if test="($times_mon = $times_thu) and string($times_thu) != ''">
					<xsl:value-of select="3"/>
				</xsl:if>
				<xsl:if test="($times_mon = $times_fri) and string($times_fri) != ''">
					<xsl:value-of select="4"/>
				</xsl:if>
				<xsl:if test="($times_mon = $times_sat) and string($times_sat) != ''">
					<xsl:value-of select="5"/>
				</xsl:if>
				<xsl:if test="($times_mon = $times_sun) and string($times_sun) != ''">
					<xsl:value-of select="6"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="group_2">
				<xsl:if test="($times_tue = $times_wed) and string($times_wed) != ''">
					<xsl:value-of select="2"/>
				</xsl:if>
				<xsl:if test="($times_tue = $times_thu) and string($times_thu) != ''">
					<xsl:value-of select="3"/>
				</xsl:if>
				<xsl:if test="($times_tue = $times_fri) and string($times_fri) != ''">
					<xsl:value-of select="4"/>
				</xsl:if>
				<xsl:if test="($times_tue = $times_sat) and string($times_sat) != ''">
					<xsl:value-of select="5"/>
				</xsl:if>
				<xsl:if test="($times_tue = $times_sun) and string($times_sun) != ''">
					<xsl:value-of select="6"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="group_3">
				<xsl:if test="($times_wed = $times_thu) and string($times_thu) != ''">
					<xsl:value-of select="3"/>
				</xsl:if>
				<xsl:if test="($times_wed = $times_fri) and string($times_fri) != ''">
					<xsl:value-of select="4"/>
				</xsl:if>
				<xsl:if test="($times_wed= $times_sat) and string($times_sat) != ''">
					<xsl:value-of select="5"/>
				</xsl:if>
				<xsl:if test="($times_wed = $times_sun) and string($times_sun) != ''">
					<xsl:value-of select="6"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="group_4">
				<xsl:if test="($times_thu= $times_fri) and string($times_fri) != ''">
					<xsl:value-of select="4"/>
				</xsl:if>
				<xsl:if test="($times_thu= $times_sat) and string($times_sat) != ''">
					<xsl:value-of select="5"/>
				</xsl:if>
				<xsl:if test="($times_thu = $times_sun) and string($times_sun) != ''">
					<xsl:value-of select="6"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="group_5">
				<xsl:if test="($times_fri= $times_sat) and string($times_sat) != ''">
					<xsl:value-of select="5"/>
				</xsl:if>
				<xsl:if test="($times_fri = $times_sun) and string($times_sun) != ''">
					<xsl:value-of select="6"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="group_6">
				<xsl:if test="($times_sat = $times_sun) and string($times_sun) != ''">
					<xsl:value-of select="6"/>
				</xsl:if>
			</xsl:variable>
			<!-- find the open days that have no times ( also incluse days closed )-->
			<xsl:variable name="single_1">
				<xsl:if test="string($times_mon) = '' and contains($days_open,'maandag')">
					<xsl:value-of select="'ma'"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="single_2">
				<xsl:if test="string($times_tue) = '' and contains($days_open,'dinsdag')">
					<xsl:value-of select="'di'"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="single_3">
				<xsl:if test="string($times_wed) = '' and contains($days_open,'woensdag')">
					<xsl:value-of select="'woe'"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="single_4">
				<xsl:if test="string($times_thu) = '' and contains($days_open,'donderdag')">
					<xsl:value-of select="'do'"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="single_5">
				<xsl:if test="string($times_fri) = '' and contains($days_open,'vrijdag')">
					<xsl:value-of select="'vrij'"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="single_6">
				<xsl:if test="string($times_sat) = '' and contains($days_open,'zaterdag')">
					<xsl:value-of select="'za'"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="single_7">
				<xsl:if test="string($times_sun) = '' and contains($days_open,'zondag')">
					<xsl:value-of select="'zo'"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="times_string">
				<xsl:for-each select="opening_times_instance[open_type = 'open']">
					<xsl:call-template name="times_string"/>
				</xsl:for-each>
			</xsl:variable>
			<!-- times_string does not contain days -->
			<xsl:variable name="times_open">
				<xsl:for-each select="opening_times_instance[open_type = 'open' and year = '1970']">
					<xsl:variable name="pos" select="position()"/>
					<xsl:if test="position() = 1">
						<!-- <xsl:value-of select="'Open op '"/> -->
						<xsl:call-template name="shorten_day"/>
					</xsl:if>
					<!-- if there are any relevant times -->
					<xsl:if test="position() != 1">
						<xsl:value-of select="','"/>
						<!-- <xsl:value-of select="' '"/> -->
						<xsl:if test="string(day_type)  !=string(../../ot:opening_times/opening_times_instance[position() = $pos - 1]/day_type)">
							<!-- only when there is a proper time -->
							<xsl:choose>
								<xsl:when test="substring(time_start,12,8) != '00:00:00' and substring(time_start,12,5) !='23:59'">
									<xsl:value-of select="'&#xA;'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="' '"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:call-template name="shorten_day"/>
						</xsl:if>
					</xsl:if>
					<xsl:if test="substring(time_start,12,8) != '00:00:00' and substring(time_start,12,5) !='23:59'">
						<xsl:choose>
							<xsl:when test="substring(time_end,12,8) != '00:00:00' and substring(time_end,12,5) !='23:59' and
							substring(time_start,12,8) != substring(time_end,12,8)">
								<xsl:value-of select="' van '"/>
								<xsl:value-of select="substring(time_start,12,5)"/>
								<xsl:value-of select="' tot '"/>
								<xsl:value-of select="substring(time_end,12,5)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="' om '"/>
								<xsl:value-of select="substring(time_start,12,5)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<!--
					<xsl:if test="substring(time_start,12,8) != '00:00:00' and substring(time_start,12,5) !='23:59'">
						<xsl:value-of select="' '"/>
						<xsl:value-of select="substring(time_start,12,5)"/>
					</xsl:if> -->
				</xsl:for-each>
			</xsl:variable>
		
			<!-- format the opening times -->
			<xsl:variable name="length">
				<xsl:value-of select="string-length($times_open)"/>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="string($times_open) = 'ma, di, woe, do, vrij, za, zo'">
					<!-- open appears twice -->
					<!-- <xsl:value-of select="'ma tot zo open'"/> -->
					<xsl:value-of select="'ma tot zo'"/>
				</xsl:when>
				<!--
				<xsl:variable name="length">
					<xsl:value-of select="string-length($times_open)"/>
				</xsl:variable>  -->
				<xsl:when test="$length = 6">
					<xsl:value-of select="substring($times_open,1,2)"/>
					<xsl:value-of select="' en '"/>
					<xsl:value-of select="substring($times_open,5,6)"/>
					<xsl:value-of select="' open'"/>
					<!--
					<xsl:if test="contains($times_open,'ma, di')">
						<xsl:value-of select="substring($times_open,1,2)"/>
						<xsl:value-of select="' en '"/>
						<xsl:value-of select="substring($times_open,1,2)"/>
						<xsl:value-of select="'open'"/>
						<xsl:value-of select="'ma en di open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'ma, do')">
						<xsl:value-of select="'ma en di open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'ma, za')">
						<xsl:value-of select="substring($times_open,1,2)"/>
						<xsl:value-of select="' en '"/>
						<xsl:value-of select="substring($times_open,5,6)"/>
						<xsl:value-of select="' open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'ma, zo')">
						<xsl:value-of select="'ma en di open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'di, do')">
						<xsl:value-of select="'ma en di open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'di, za')">
						<xsl:value-of select="'ma en di open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'di, zo')">
						<xsl:value-of select="'ma en di open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'do, za')">
						<xsl:value-of select="'ma en di open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'do, zo')">
						<xsl:value-of select="'ma en di open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'za, zo')">
						<xsl:value-of select="'za en zo open'"/>
					</xsl:if>-->
				</xsl:when>
				<xsl:when test="$length = 7">
					<xsl:if test="contains($times_open,'ma, woe')">
						<xsl:value-of select="'ma en woe open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'di, woe')">
						<xsl:value-of select="'di en woe open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'do, woe')">
						<xsl:value-of select="'do en woe open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'za, woe')">
						<xsl:value-of select="'za en woe open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'zo, woe')">
						<xsl:value-of select="'zo en woe open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'woe, ma')">
						<xsl:value-of select="'woe en ma open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'woe, di')">
						<xsl:value-of select="'woe en di open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'woe, do')">
						<xsl:value-of select="'woe en do open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'woe, za')">
						<xsl:value-of select="'woe en za open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'woe, zo')">
						<xsl:value-of select="'woe en zo open'"/>
					</xsl:if>
				</xsl:when>
				<xsl:when test="$length = 8">
					<xsl:if test="contains($times_open,'ma, vrij')">
						<xsl:value-of select="'ma en vrij open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'di, vrij')">
						<xsl:value-of select="'di en vrij open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'do, vrij')">
						<xsl:value-of select="'do en vrij open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'za, vrij')">
						<xsl:value-of select="'za en vrij open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'zo, vrij')">
						<xsl:value-of select="'zo en vrij open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'vrij, ma')">
						<xsl:value-of select="'vrij en ma open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'vrij, di')">
						<xsl:value-of select="'vrij en di open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'vrij, do')">
						<xsl:value-of select="'vrij en zo open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'vrij, za')">
						<xsl:value-of select="'vrij en za open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'vrij, zo')">
						<xsl:value-of select="'vrij en zo open'"/>
					</xsl:if>
				</xsl:when>
				<xsl:when test="$length = 9">
					<xsl:if test="contains($times_open,'woe, vrij')">
						<xsl:value-of select="'woe en vrij open'"/>
					</xsl:if>
					<xsl:if test="contains($times_open,'vrij, woe')">
						<xsl:value-of select="'vrij en woe open'"/>
					</xsl:if>
				</xsl:when>
				<!-- the most common cases -->
				<!--
						<xsl:when test="($times_mon = $times_tue) and ($times_tue = $times_wed) and 
												($times_wed = $times_thu) and ($times_thu = $times_fri) and
												($times_fri = $times_sat) and ($times_sat = $times_sun)">
							<xsl:value-of select="'ma tot zo '"/>
							<xsl:value-of select="$times_mon"/>
						</xsl:when>
-->
				<!-- sequences : covered by the groups. 
					<xsl:when test="string($sequences_1)='123456'">
						<xsl:value-of select="'ma tot zo '"/>
						<xsl:value-of select="$times_sun"/>
					</xsl:when>
					<xsl:when test="string($sequences_1)='23456'">
						<xsl:value-of select="'do tot zo '"/>
						<xsl:value-of select="$times_sun"/>
					</xsl:when>
					<xsl:when test="string($sequences_1)='3456'">
						<xsl:value-of select="'woe tot zo '"/>
						<xsl:value-of select="$times_sun"/>
					</xsl:when>
					<xsl:when test="string($sequences_1)='456'">
						<xsl:value-of select="'di tot zo '"/>
						<xsl:value-of select="$times_sun"/>
					</xsl:when>
					<xsl:when test="string($sequences_1)='56'">
						<xsl:value-of select="'vrij tot zo '"/>
						<xsl:value-of select="$times_sun"/>
					</xsl:when>
					<xsl:when test="string($sequences_1)='6'">
						<xsl:value-of select="'zat en zo '"/>
						<xsl:value-of select="$times_sun"/>
					</xsl:when>  -->
				<!-- check the groups -->
				<xsl:when test="$group_1 != '' or $group_2 != '' or $group_3 != '' or $group_4 != '' or $group_5 != '' or $group_6 != ''">
					<!-- test data :   xxxx   
						<xsl:value-of select="$group_1"/>x
						<xsl:value-of select="$group_2"/>x
						<xsl:value-of select="$group_3"/>x
						<xsl:value-of select="$group_4"/>x
						<xsl:value-of select="$group_5"/>x
						<xsl:value-of select="$group_6"/>x
						zzzzz -->
					<xsl:variable name="group_1_times">
						<xsl:if test="$group_1 != ''">
							<xsl:value-of select="'ma'"/>
							<xsl:if test="contains($group_1,1)">
								<xsl:value-of select="', di'"/>
								<!-- <xsl:value-of select="'&#xA;'"/> -->
							</xsl:if>
							<xsl:if test="contains($group_1,2)">
								<xsl:value-of select="', woe'"/>
							</xsl:if>
							<xsl:if test="contains($group_1,3)">
								<xsl:value-of select="', do'"/>
							</xsl:if>
							<xsl:if test="contains($group_1,4)">
								<xsl:value-of select="', vrij'"/>
							</xsl:if>
							<xsl:if test="contains($group_1,5)">
								<xsl:value-of select="', za'"/>
							</xsl:if>
							<xsl:if test="contains($group_1,6)">
								<xsl:value-of select="', zo'"/>
							</xsl:if>
							<xsl:value-of select="' '"/>
							<xsl:value-of select="$times_mon"/>
						</xsl:if>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="substring($group_1_times,1,29) = 'ma, di, woe, do, vrij, za, zo'">
							<xsl:value-of select="'ma tot zo '"/>
							<xsl:value-of select="$times_mon"/>
						</xsl:when>
						<xsl:when test="substring($group_1_times,1,25) = 'ma, di, woe, do, vrij, za'">
							<xsl:value-of select="'ma tot za '"/>
							<xsl:value-of select="$times_mon"/>
						</xsl:when>
						<xsl:when test="substring($group_1_times,1,21) = 'ma, di, woe, do, vrij'">
							<xsl:value-of select="'ma tot vrij '"/>
							<xsl:value-of select="$times_mon"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$group_1_times"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:variable name="group_2_times">
						<xsl:if test="$group_2 != ''">
							<xsl:value-of select="'di'"/>
							<xsl:if test="contains($group_2,2)">
								<xsl:value-of select="', woe'"/>
							</xsl:if>
							<xsl:if test="contains($group_2,3)">
								<xsl:value-of select="', do'"/>
							</xsl:if>
							<xsl:if test="contains($group_2,4)">
								<xsl:value-of select="', vrij'"/>
							</xsl:if>
							<xsl:if test="contains($group_2,5)">
								<xsl:value-of select="', za'"/>
							</xsl:if>
							<xsl:if test="contains($group_2,6)">
								<xsl:value-of select="', zo'"/>
							</xsl:if>
							<xsl:value-of select="' '"/>
							<xsl:value-of select="$times_tue"/>
						</xsl:if>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="contains(string($group_1_times),string($group_2_times))"/>
						<xsl:otherwise>
							<xsl:if test="string($group_1_times) != ''">
								<xsl:value-of select="'&#xA;'"/>
							</xsl:if>
							<xsl:choose>
								<xsl:when test="substring($group_2_times,1,25) = 'di, woe, do, vrij, za, zo'">
									<xsl:value-of select="'di tot zo '"/>
									<xsl:value-of select="$times_tue"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$group_2_times"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:variable name="group_3_times">
						<xsl:if test="$group_3 != ''">
							<xsl:value-of select="'woe'"/>
							<xsl:if test="contains($group_3,3)">
								<xsl:value-of select="', do'"/>
							</xsl:if>
							<xsl:if test="contains($group_3,4)">
								<xsl:value-of select="', vrij'"/>
							</xsl:if>
							<xsl:if test="contains($group_3,5)">
								<xsl:value-of select="', za'"/>
							</xsl:if>
							<xsl:if test="contains($group_3,6)">
								<xsl:value-of select="', zo'"/>
							</xsl:if>
							<xsl:value-of select="' '"/>
							<xsl:value-of select="$times_wed"/>
						</xsl:if>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="contains(string($group_1_times),string($group_3_times)) or contains(string($group_2_times),string($group_3_times))"/>
						<xsl:otherwise>
							<xsl:if test="string($group_1_times) != '' or string($group_2_times) != '' ">
								<xsl:value-of select="'&#xA;'"/>
							</xsl:if>
							<xsl:choose>
								<xsl:when test="substring($group_3_times,1,21) = 'woe, do, vrij, za, zo'">
									<xsl:value-of select="'woe tot zo '"/>
									<xsl:value-of select="$times_wed"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$group_3_times"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:variable name="group_4_times">
						<xsl:if test="$group_4 != ''">
							<xsl:value-of select="'do'"/>
							<xsl:if test="contains($group_4,4)">
								<xsl:value-of select="', vrij'"/>
							</xsl:if>
							<xsl:if test="contains($group_4,5)">
								<xsl:value-of select="', za'"/>
							</xsl:if>
							<xsl:if test="contains($group_4,6)">
								<xsl:value-of select="', zo'"/>
							</xsl:if>
							<xsl:value-of select="' '"/>
							<xsl:value-of select="$times_thu"/>
						</xsl:if>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="contains(string($group_1_times),string($group_4_times)) or contains(string($group_2_times),string($group_4_times)) or
								contains(string($group_3_times),string($group_4_times))"/>
						<xsl:otherwise>
							<xsl:if test="string($group_1_times) != '' or string($group_2_times) != '' or string($group_3_times) != '' ">
								<xsl:value-of select="'&#xA;'"/>
							</xsl:if>
							<xsl:choose>
								<xsl:when test="substring($group_4_times,1,16) = 'do, vrij, za, zo'">
									<xsl:value-of select="'do tot zo '"/>
									<xsl:value-of select="$times_thu"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$group_4_times"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:variable name="group_5_times">
						<xsl:if test="$group_5 != ''">
							<xsl:value-of select="'vrij'"/>
							<xsl:if test="contains($group_5,5)">
								<xsl:value-of select="', za'"/>
							</xsl:if>
							<xsl:if test="contains($group_5,6)">
								<xsl:value-of select="', zo'"/>
							</xsl:if>
							<xsl:value-of select="' '"/>
							<xsl:value-of select="$times_fri"/>
						</xsl:if>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="contains(string($group_1_times),string($group_5_times)) or contains(string($group_2_times),string($group_5_times)) or
								contains(string($group_3_times),string($group_5_times)) or contains(string($group_4_times),string($group_5_times))"/>
						<xsl:otherwise>
							<xsl:if test="string($group_1_times) != '' or string($group_2_times) != '' or string($group_3_times) != '' or string($group_4_times) != '' ">
								<xsl:value-of select="'&#xA;'"/>
							</xsl:if>
							<xsl:choose>
								<xsl:when test="substring($group_5_times,1,12) = 'vrij, za, zo'">
									<xsl:value-of select="'vrij tot zo '"/>
									<xsl:value-of select="$times_fri"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$group_5_times"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:variable name="group_6_times">
						<xsl:if test="$group_6 != ''">
							<xsl:value-of select="'za'"/>
							<xsl:if test="contains($group_6,6)">
								<xsl:value-of select="', zo'"/>
							</xsl:if>
							<xsl:value-of select="' '"/>
							<xsl:value-of select="$times_sat"/>
						</xsl:if>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="contains(string($group_1_times),string($group_6_times) )or contains(string($group_2_times),string($group_6_times)) or
								contains(string($group_3_times),string($group_6_times)) or contains(string($group_4_times),string($group_6_times)) or contains(string($group_5_times),string($group_6_times))"/>
						<xsl:otherwise>
							<xsl:if test="string($group_1_times) != '' or string($group_2_times) != '' or string($group_3_times) != '' or string($group_4_times) != '' or string($group_5_times) != ''  ">
								<xsl:value-of select="'&#xA;'"/>
							</xsl:if>
							<xsl:choose>
								<xsl:when test="substring($group_6_times,1,6) = 'za, zo'">
									<xsl:value-of select="'za en zo '"/>
									<xsl:value-of select="$times_sat"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$group_6_times"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
					<!-- and tidy up the single dates 									-->
					<!-- that is events with no groupings 								-->
					<!-- check Monday and Sunday 										-->
					<!-- and make sure we haven't included them already 	-->
					<xsl:variable name="all_group_times">
						<xsl:value-of select="$group_1_times"/>
						<xsl:value-of select="$group_2_times"/>
						<xsl:value-of select="$group_3_times"/>
						<xsl:value-of select="$group_4_times"/>
						<xsl:value-of select="$group_5_times"/>
						<xsl:value-of select="$group_6_times"/>
					</xsl:variable>
					<!--
					test data
					aaaaaaa $times_sat <xsl:value-of select="$times_sat"/>
					bbbbbbb $group_6 <xsl:value-of select="$group_6"/>
					ccccccc $all_group_times  <xsl:value-of select="$all_group_times"/>
					zzzzzzz
					-->
					<xsl:if test="string($group_1) = '' and string($times_mon) !=''">
						<xsl:value-of select="'&#xA;'"/>
						<xsl:value-of select="'ma '"/>
						<xsl:value-of select="$times_mon"/>
					</xsl:if>
					<xsl:if test="string($group_2) = '' 
												and string($times_tue) !='' and not(contains($all_group_times,'di'))">
						<xsl:value-of select="'&#xA;'"/>
						<xsl:value-of select="'di '"/>
						<xsl:value-of select="$times_tue"/>
					</xsl:if>
					<xsl:if test="string($group_3) = ''
												  and string($times_wed) !='' and not(contains($all_group_times,'woe'))">		  
						<xsl:value-of select="'&#xA;'"/>
						<xsl:value-of select="'woe '"/>
						<xsl:value-of select="$times_wed"/>
					</xsl:if>
					<xsl:if test="string($group_4) = '' 
												 and string($times_thu) !='' and not(contains($all_group_times,'do'))">
						<xsl:value-of select="'&#xA;'"/>
						<xsl:value-of select="'do '"/>
						<xsl:value-of select="$times_thu"/>
					</xsl:if>
					<xsl:if test="string($group_5) = '' 			
												and string($times_fri) !=''  and not(contains($all_group_times,'vrij'))"> 
						<xsl:value-of select="'&#xA;'"/>
						<xsl:value-of select="'vrij '"/>
						<xsl:value-of select="$times_fri"/>
					</xsl:if>
					<xsl:if test="string($group_6) = '' 
												and string($times_sat) !='' and not(contains($all_group_times,'za'))"> 
						<xsl:value-of select="'&#xA;'"/>
						<xsl:value-of select="'za '"/>
						<xsl:value-of select="$times_sat"/>
					</xsl:if>	
					<!-- This is not OK because this day may contain only one time that is included in the group times,
					<xsl:if test="string($group_6) = '' 
												and string($times_sat) !='' and not(contains($all_group_times,$times_sat))">
						<xsl:value-of select="'&#xA;'"/>
						<xsl:value-of select="'za '"/>
						<xsl:value-of select="$times_sat"/>
					</xsl:if>
					-->
					<xsl:if test="string($group_6) = '' and string($times_sun) !=''">
						<xsl:value-of select="'&#xA;'"/>
						<xsl:value-of select="'zo '"/>
						<xsl:value-of select="$times_sun"/>
					</xsl:if>
					<!-- and add the single days with no times -->
					
					<xsl:if test="string($single_1) != '' or string($single_2) != '' or string($single_3) != '' or string($single_4) != '' or string($single_5) != ''
																		or string($single_6) != '' or string($single_7) != ''">
						<xsl:value-of select="'&#xA;'"/>
						<xsl:value-of select="$single_1"/>
						<xsl:if test="string($single_1) != ''">
							<xsl:value-of select="', '"/>
						</xsl:if>
						<xsl:value-of select="$single_2"/>
						<xsl:if test="string($single_2) != ''">
							<xsl:value-of select="', '"/>
						</xsl:if>
						<xsl:value-of select="$single_3"/>
						<xsl:if test="string($single_3) != ''">
							<xsl:value-of select="', '"/>
						</xsl:if>
						<xsl:value-of select="$single_4"/>
						<xsl:if test="string($single_4) != ''">
							<xsl:value-of select="', '"/>
						</xsl:if>
						<xsl:value-of select="$single_5"/>
						<xsl:if test="string($single_5) != ''">
							<xsl:value-of select="', '"/>
						</xsl:if>
						<xsl:value-of select="$single_6"/>
						<xsl:if test="string($single_6) != ''">
							<xsl:value-of select="', '"/>
						</xsl:if>
						<xsl:value-of select="$single_7"/>
					</xsl:if> 
				</xsl:when>
				<!-- the following deals with single day opening -->
				<xsl:when test="string($times_mon) != '' or string($times_tue) != '' or string($times_wed) != '' or string($times_thu) != '' or string($times_fri) != '' or string($times_sat)  != '' or string($times_sun) != ''">
					<xsl:if test="string($times_mon) != ''">
						<!-- dont need a space as this will always be firts if present <xsl:value-of select="'&#xA;'"/> -->
						<xsl:value-of select="'ma '"/>
						<xsl:value-of select="$times_mon"/>
					</xsl:if>
					<xsl:if test="string($times_tue) != ''">
						<xsl:if test="string($times_mon) != ''">
							<xsl:value-of select="'&#xA;'"/>
						</xsl:if>
						<xsl:value-of select="'di '"/>
						<xsl:value-of select="$times_tue"/>
					</xsl:if>
					<xsl:if test="string($times_wed) != ''">
						<xsl:if test="string($times_mon) != '' or string($times_tue) != ''">
							<xsl:value-of select="'&#xA;'"/>
						</xsl:if>
						<xsl:value-of select="'woe '"/>
						<xsl:value-of select="$times_wed"/>
					</xsl:if>
					<xsl:if test="string($times_thu) != ''">
						<xsl:if test="string($times_mon) != '' or string($times_tue) != '' or string($times_wed) != ''">
							<xsl:value-of select="'&#xA;'"/>
						</xsl:if>
						<xsl:value-of select="'do '"/>
						<xsl:value-of select="$times_thu"/>
					</xsl:if>
					<xsl:if test="string($times_fri) != ''">
						<xsl:if test="string($times_mon) != '' or string($times_tue) != '' or string($times_wed) != '' or string($times_thu) != ''">
							<xsl:value-of select="'&#xA;'"/>
						</xsl:if>
						<xsl:value-of select="'vrij '"/>
						<xsl:value-of select="$times_fri"/>
					</xsl:if>
					<xsl:if test="string($times_sat) != ''">
						<xsl:if test="string($times_mon) != '' or string($times_tue) != '' or string($times_wed) != '' or string($times_thu) != '' or string($times_fri) != ''">
							<xsl:value-of select="'&#xA;'"/>
						</xsl:if>
						<xsl:value-of select="'za '"/>
						<xsl:value-of select="$times_sat"/>
					</xsl:if>
					<xsl:if test="string($times_sun) != ''">
						<xsl:if test="string($times_mon) != '' or string($times_tue) != '' or string($times_wed) != '' or string($times_thu) != '' or string($times_fri) != '' or string($times_sat) != ''">
							<xsl:value-of select="'&#xA;'"/>
						</xsl:if>
						<xsl:value-of select="'zo '"/>
						<xsl:value-of select="$times_sun"/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$times_open"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:variable name="by_appointment">
				<!-- <xsl:for-each select="ot:opening_times"> -->
				<xsl:for-each select="opening_times_instance[open_type = 'open op afspraak' and year = '1970']">
					<xsl:variable name="pos" select="position()"/>
					<xsl:if test="position() = 1">
						<xsl:value-of select="'op afspraak'"/>
					</xsl:if>
					<!-- find the previous day -->
					<xsl:variable name="previous_day">
						<xsl:for-each select="../opening_times_instance[open_type = 'open op afspraak' and year = '1970']">
							<xsl:if test="position() = $pos - 1">
								<xsl:value-of select="day_type"/>
							</xsl:if>
						</xsl:for-each>
					</xsl:variable>
					<!-- using $pos to access  opening_times_instance will find the real  position not the one we want -->
					<!-- <xsl:if test="string(day_type)  != string(../opening_times_instance[position() = $pos - 1 and open_type = 'open op afspraak' ]/day_type)"> -->
					<xsl:if test="string(day_type)  != string($previous_day)">
						<xsl:if test="position() != 1">
							<xsl:value-of select="','"/>
						</xsl:if>
						<xsl:value-of select="' '"/>
						<xsl:call-template name="shorten_day"/>
					</xsl:if>
					<!--  
					<xsl:value-of select="' '"/>
					<xsl:if test="substring(time_start,12,8) != '00:00:00' and substring(time_start,12,5) !='23:59'">
						<xsl:value-of select="' '"/>
						<xsl:value-of select="substring(time_start,12,5)"/>
					</xsl:if>
						-->
				</xsl:for-each>
			</xsl:variable>
			<xsl:if test="string($times_open) != '' and string($by_appointment) != ''">
				<xsl:value-of select="'&#xA;'"/>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="string($by_appointment) = 'op afspraak ma, di, woe, do, vrij, za, zo'">
					<xsl:value-of select="'op afspraak'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="string($by_appointment) != ''">
						<xsl:value-of select="$by_appointment"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:variable name="times_closed">
				<xsl:for-each select="opening_times_instance[open_type = 'gesloten' and year = '1970']">
					<xsl:if test="position() = 1">
						<xsl:value-of select="'gesloten op'"/>
					</xsl:if>
					<xsl:if test="position() != 1">
						<xsl:value-of select="','"/>
					</xsl:if>
					<xsl:value-of select="' '"/>
					<xsl:call-template name="shorten_day"/>
					<xsl:if test="substring(time_start,12,8) != '00:00:00' and substring(time_start,12,5) !='23:59'">
						<xsl:value-of select="' '"/>
						<xsl:value-of select="substring(time_start,12,5)"/>
					</xsl:if>
				</xsl:for-each>
			</xsl:variable>
			<xsl:if test="(string($times_open) != '' or string($by_appointment) != '' ) and string($times_closed) != ''">
				<xsl:value-of select="'&#xA;'"/>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="string($times_closed) = 'gesloten op ma, di, woe, do, vrij, za, zo'">
					<xsl:value-of select="'gesloten'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="string($times_closed) != ''">
						<xsl:value-of select="' ('"/>
						<xsl:variable name="length">
							<xsl:value-of select="string-length($times_closed)"/>
						</xsl:variable>
						<!-- <xsl:choose>
						
							<xsl:when test="$length = 18">
								<xsl:if test="contains($times_closed,'ma, di')">
									<xsl:value-of select="'ma en di'"/>
								</xsl:if>
								<xsl:if test="contains($times_closed,'di, woe')">
									<xsl:value-of select="'di en woe'"/>
								</xsl:if>
								<xsl:if test="contains($times_closed,'woe, do')">
									<xsl:value-of select="'woe en do'"/>
								</xsl:if>
								<xsl:if test="contains($times_closed,'do, vrij')">
									<xsl:value-of select="'do en vrij'"/>
								</xsl:if>
								<xsl:if test="contains($times_closed,'vrij, za')">
									<xsl:value-of select="'vrij en za'"/>
								</xsl:if>
								<xsl:if test="contains($times_closed,'za, zo')">
									<xsl:value-of select="'za en zo'"/>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise> 
								<xsl:value-of select="substring($times_closed,13,$length - 11)"/>
							</xsl:otherwise>
						</xsl:choose> -->
						<xsl:value-of select="substring($times_closed,13,$length - 11)"/>
						<xsl:value-of select="' gesloten)'"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			<!-- </xsl:for-each> -->
		</xsl:for-each>
		<!-- exceptions -->
		<xsl:variable name="shut">
			<!--
			<xsl:for-each select="ot:opening_times">
				<xsl:for-each select="opening_times_instance[open_type = 'gesloten' and year='1970']">
					<xsl:if test="position() != 1">
						<xsl:value-of select="', '"/>
					</xsl:if>
					<xsl:value-of select="day_type"/>
				</xsl:for-each>
				
			</xsl:for-each>
			-->
			<!-- to do : convert the start date and end date to their numerical represantation, check ther are no gaps and output as a range -->
			<!-- remove too many exceptions in the past -->
			<!--
			<xsl:for-each select="ot:opening_times">
				<xsl:for-each select="opening_times_instance[open_type = 'gesloten' and year != '1970' and year &gt;  2007]">
					<xsl:if test="position() = 1">
						comment out  <xsl:value-of select="' en '"/>
					</xsl:if>
					<xsl:if test="position() != 1">
						<xsl:value-of select="', '"/>
					</xsl:if>
					<xsl:value-of select="substring(time_start,9,2)"/>
					<xsl:value-of select="'/'"/>
					<xsl:value-of select="substring(time_start,6,2)"/>
					<xsl:value-of select="'/'"/>
					<xsl:value-of select="substring(time_start,1,4)"/>
				</xsl:for-each>
			</xsl:for-each> -->
		</xsl:variable>
		<xsl:if test="string($shut) != ''">
			<xsl:value-of select="'&#xA;'"/>
			<xsl:value-of select="'gesloten op '"/>
			<xsl:value-of select="$shut"/>
		</xsl:if>
	</xsl:template>
	<xsl:template name="shorten_day">
		<xsl:choose>
			<xsl:when test="string(day_type) = 'maandag'">
				<xsl:value-of select="'ma'"/>
			</xsl:when>
			<xsl:when test="string(day_type) = 'dinsdag'">
				<xsl:value-of select="'di'"/>
			</xsl:when>
			<xsl:when test="string(day_type) = 'woensdag'">
				<xsl:value-of select="'woe'"/>
			</xsl:when>
			<xsl:when test="string(day_type) = 'donderdag'">
				<xsl:value-of select="'do'"/>
			</xsl:when>
			<xsl:when test="string(day_type) = 'vrijdag'">
				<xsl:value-of select="'vrij'"/>
			</xsl:when>
			<xsl:when test="string(day_type) = 'zaterdag'">
				<xsl:value-of select="'za'"/>
			</xsl:when>
			<xsl:when test="string(day_type) = 'zondag'">
				<xsl:value-of select="'zo'"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="times_string">
		<!-- <xsl:for-each select="opening_times_instance[open_type = 'open']"> -->
		<xsl:variable name="pos" select="position()"/>
		<xsl:if test="position() = 1">
			<!-- <xsl:value-of select="'Open op '"/> -->
			<!-- <xsl:call-template name="shorten_day"/> -->
		</xsl:if>
		<!-- if there are any relevant times -->
		<xsl:if test="position() != 1">
			<xsl:value-of select="','"/>
			<xsl:value-of select="' '"/>
			<!-- 
			<xsl:if test="string(day_type)  !=string(../../ot:opening_times/opening_times_instance[position() = $pos - 1]/day_type)">
				<xsl:call-template name="shorten_day"/>
			</xsl:if> -->
		</xsl:if>
		<xsl:if test="substring(time_start,12,8) != '00:00:00' and substring(time_start,12,5) !='23:59'">
			<xsl:choose>
				<xsl:when test="substring(time_end,12,8) != '00:00:00' and substring(time_end,12,5) !='23:59' and
							substring(time_start,12,8) != substring(time_end,12,8)">
					<xsl:value-of select="'van '"/>
					<xsl:value-of select="substring(time_start,12,5)"/>
					<xsl:value-of select="' tot '"/>
					<xsl:value-of select="substring(time_end,12,5)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="' om '"/>
					<xsl:value-of select="substring(time_start,12,5)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<!--
					<xsl:if test="substring(time_start,12,8) != '00:00:00' and substring(time_start,12,5) !='23:59'">
						<xsl:value-of select="' '"/>
						<xsl:value-of select="substring(time_start,12,5)"/>
					</xsl:if> -->
	</xsl:template>
</xsl:stylesheet>
<!--

							<xsl:if test="string($group_1) = '' and string($times_mon) !=''">
								<xsl:value-of select="'&#xA;'"/>
								<xsl:value-of select="'mo '"/>
								<xsl:value-of select="$times_mon"/>
							</xsl:if>
							<xsl:if test="string($group_2) = '' and string($group_1) = '' and string($times_tue) !=''">
								<xsl:value-of select="'&#xA;'"/>
								<xsl:value-of select="'di '"/>
								<xsl:value-of select="$times_tue"/>
							</xsl:if>
							<xsl:if test="string($group_3) = '' and
												string($group_2) = '' and string($group_1) = '' and string($times_wed) !=''">
								<xsl:value-of select="'&#xA;'"/>
								<xsl:value-of select="'woe '"/>
								<xsl:value-of select="$times_wed"/>
							</xsl:if>
							<xsl:if test="string($group_4) = '' and string($group_3) = '' and
												string($group_2) = '' and string($group_1) = '' and string($times_thu) !=''">
								<xsl:value-of select="'&#xA;'"/>
								<xsl:value-of select="'do '"/>
								<xsl:value-of select="$times_thu"/>
							</xsl:if>
							<xsl:if test="string($group_5) = '' and string($group_4) = '' and string($group_3) = '' and
												string($group_2) = '' and string($group_1) = '' and string($times_fri) !=''">
								<xsl:value-of select="'&#xA;'"/>
								<xsl:value-of select="'vrij '"/>
								<xsl:value-of select="$times_fri"/>
							</xsl:if>
							<xsl:if test="string($group_6) = '' and string($group_5) = '' and string($group_4) = '' and string($group_3) = ''and
												string($group_2) = ''  and string($group_1) = '' and
											string($times_sat) !=''">
								<xsl:value-of select="'&#xA;'"/>
								<xsl:value-of select="'za '"/>
								<xsl:value-of select="$times_sat"/>
							</xsl:if>
							
							
							-->
