<?xml version="1.0" encoding="ISO-8859-1"?><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xalan="http://xml.apache.org/xalan" xmlns:md="http://www.cultuurdatabank.be/XMLSchema/metadata" exclude-result-prefixes="md xsl xalan" xmlns:exsl="http://exslt.org/common" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT" extension-element-prefixes="exsl">	<!-- xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL" -->	<xsl:output method="xml" version="1.0" encoding="ISO-8859-1" indent="no"/>	<xsl:template name="insertCategorisation">		<xsl:for-each select="category">			<!-- select admittance -->			<xsl:variable name="admittance">				<admittance>					<xsl:for-each select="categorisation_instance">						<xsl:variable name="label" select="./label/dutch"/>						<xsl:variable name="objectid" select="./md:objectid"/>						<xsl:variable name="admittance_cat" select="$Admittance/Import/Row[(CNetID=$objectid)]/Niveau_1"/>						<xsl:if test="string($admittance_cat) != ''">							<xsl:attribute name="catid"><xsl:value-of select="$objectid"/></xsl:attribute>							<!--							<xsl:if test="string(md:short_description/dutch) != ''">								<xsl:attribute name="description"><xsl:value-of select="substring(md:short_description/dutch,1,250)"/></xsl:attribute>							</xsl:if>							-->							<xsl:value-of select="$label"/>						</xsl:if>					</xsl:for-each>				</admittance>			</xsl:variable>			<xsl:choose>				<xsl:when test="string($admittance) != ''">					<xsl:copy-of select="$admittance"/>				</xsl:when>				<xsl:otherwise>											</xsl:otherwise>			</xsl:choose>			<!--Select the facilities  -->			<!-- no facilities for productions -->			<xsl:if test="string(../event_cluster_type) = 'aanbod'">				<xsl:variable name="facilities">					<facilities>						<xsl:for-each select="categorisation_instance">							<xsl:variable name="label" select="./label/dutch"/>							<xsl:variable name="objectid" select="./md:objectid"/>							<xsl:variable name="facs" select="$Facilities/Import/Row[(CNetID=$objectid)]/Niveau_1"/>							<xsl:if test="string($facs) != ''">								<facility>									<xsl:attribute name="catid"><xsl:value-of select="$objectid"/></xsl:attribute>									<xsl:if test="string(md:short_description/dutch) != ''">										<xsl:attribute name="description"><xsl:value-of select="substring(md:short_description/dutch,1,250)"/></xsl:attribute>									</xsl:if>									<xsl:value-of select="$label"/>								</facility>							</xsl:if>						</xsl:for-each>					</facilities>				</xsl:variable>				<xsl:choose>					<xsl:when test="string($facilities) != ''">						<xsl:copy-of select="$facilities"/>					</xsl:when>					<xsl:otherwise>											</xsl:otherwise>				</xsl:choose>			</xsl:if>			<!--Select the optional categories  -->			<!--				<xsl:variable name="optional">					<optional>						<xsl:for-each select="categorisation_instance">							<xsl:variable name="label" select="./label/dutch"/>							<xsl:variable name="objectid" select="./md:objectid"/>							<xsl:variable name="opt_cat" select="$Optional_Cats/Import/Row[(CNetID=$objectid)]/Niveau_1"/>							<xsl:if test="string($opt_cat) != ''">								<category>									<xsl:attribute name="catid"><xsl:value-of select="$objectid"/></xsl:attribute>									<xsl:if test="string(md:short_description/dutch) != ''">										<xsl:attribute name="description"><xsl:value-of select="substring(md:short_description/dutch,1,250)"/></xsl:attribute>									</xsl:if>									<xsl:value-of select="$label"/>								</category>							</xsl:if>						</xsl:for-each>					</optional>				</xsl:variable>				<xsl:choose>					<xsl:when test="string($optional) != ''">						<xsl:copy-of select="$optional"/>					</xsl:when>					<xsl:otherwise>											</xsl:otherwise>				</xsl:choose>			-->			<!-- Select the geographical doelgroep. There can be only one -->			<xsl:variable name="public_type">				<xsl:variable name="label" select="categorisation_instance/label/dutch"/>				<xsl:variable name="objectid" select="categorisation_instance/md:objectid"/>				<xsl:variable name="geo_level" select="$GeoDoelgroep/Import/Row[(CNetID=$objectid)]/Niveau_1"/>				<xsl:variable name="geo_id" select="$GeoDoelgroep/Import/Row[(CNetID=$objectid)]/CNetID"/>				<xsl:choose>					<xsl:when test="string($geo_level) != ''">						<publicscope>							<xsl:attribute name="catid"><xsl:value-of select="$geo_id"/></xsl:attribute>							<xsl:value-of select="$geo_level"/>						</publicscope>					</xsl:when>					<xsl:otherwise>						<!--							<publicrange>								<xsl:attribute name="catid"><xsl:value-of select="'6.5.0.0.0'"/></xsl:attribute>								<xsl:value-of select="'Geografische doelgroep onbepaald'"/>							</publicrange>						-->					</xsl:otherwise>				</xsl:choose>			</xsl:variable>			<xsl:choose>				<xsl:when test="string($public_type) != ''">					<xsl:copy-of select="$public_type"/>				</xsl:when>				<xsl:otherwise>					<!-- not needed						<publicrange>							<xsl:attribute name="catid"><xsl:value-of select="'6.5.0.0.0'"/></xsl:attribute>							<xsl:value-of select="'Geografische doelgroep onbepaald'"/>						</publicrange>-->				</xsl:otherwise>			</xsl:choose>			<!-- Next select the target audiences -->			<xsl:variable name="target">				<targetaudiences>					<xsl:for-each select="categorisation_instance">						<xsl:variable name="label" select="./label/dutch"/>						<xsl:variable name="objectid" select="./md:objectid"/>						<xsl:variable name="target_cat" select="$Age_Doelgroep/Import/Row[(CNetID=$objectid)]/Niveau_1"/>						<xsl:if test="string($target_cat) != ''">							<targetaudience>								<xsl:attribute name="catid"><xsl:value-of select="$objectid"/></xsl:attribute>								<xsl:value-of select="$label"/>							</targetaudience>						</xsl:if>					</xsl:for-each>				</targetaudiences>			</xsl:variable>			<xsl:choose>				<xsl:when test="string($target) != ''">					<xsl:copy-of select="$target"/>				</xsl:when>				<xsl:otherwise>											</xsl:otherwise>			</xsl:choose>			<!-- Next select the Themas -->			<xsl:variable name="themes">				<themes>					<xsl:for-each select="categorisation_instance">						<xsl:variable name="label" select="./label/dutch"/>						<xsl:variable name="objectid" select="./md:objectid"/>						<xsl:variable name="thema" select="$Thema/Import/Row[(CNetID=$objectid)]/Niveau_1"/>						<xsl:if test="string($thema) != ''">							<theme>								<xsl:attribute name="catid"><xsl:value-of select="$objectid"/></xsl:attribute>								<xsl:value-of select="$label"/>							</theme>						</xsl:if>					</xsl:for-each>				</themes>			</xsl:variable>			<xsl:choose>				<xsl:when test="string($themes) != ''">					<xsl:copy-of select="$themes"/>				</xsl:when>				<xsl:otherwise>					<themes>						<theme>							<xsl:attribute name="catid"><xsl:value-of select="'1.58.0.0.0'"/></xsl:attribute>							<xsl:value-of select="'Thema onbepaald'"/>						</theme>					</themes>				</xsl:otherwise>			</xsl:choose>			<!-- Next select the Types -->			<xsl:variable name="types">				<xsl:for-each select="categorisation_instance">					<xsl:variable name="label" select="./label/dutch"/>					<xsl:variable name="objectid" select="./md:objectid"/>					<xsl:variable name="type" select="$Type/Import/Row[(CNetID=$objectid)]/Niveau_1"/>					<xsl:if test="string($type) != ''">						<xsl:value-of select="$label"/>						<xsl:value-of select="'xxxx'"/>						<xsl:value-of select="$objectid"/>						<xsl:value-of select="'xxxx'"/>						<!--							<type>								<xsl:attribute name="catid"><xsl:value-of select="$objectid"/></xsl:attribute>								<xsl:value-of select="$label"/>							</type>						-->					</xsl:if>				</xsl:for-each>			</xsl:variable>			<!-- only 10 types possible -->			<!--	The node set function doesnt work if I include xmlns at the top, but I need that otherwise 	-->			<!--	we get extra unwanted xmlns attributes in each category element. Bummer. 						-->			<!-- 	<xsl:for-each select="xalan:nodeset($types)/types/type">							<xsl:for-each select="exsl:node-set($types)/types/type">										<xsl:for-each select="xalan:nodeset($types)/types/type">								<xsl:if test="position() &lt; 11">									<xsl:copy-of select="."/>								</xsl:if>							</xsl:for-each>					-->			<xsl:choose>				<xsl:when test="string($types) != ''">					<types>						<xsl:variable name="position" select="1"/>						<xsl:call-template name="add_type">							<xsl:with-param name="all_types" select="$types"/>							<xsl:with-param name="position" select="$position"/>						</xsl:call-template>					</types>				</xsl:when>				<xsl:otherwise>					<types>						<type>							<xsl:attribute name="catid"><xsl:value-of select="'0.51.0.0.0'"/></xsl:attribute>							<xsl:value-of select="'Type aanbod onbepaald'"/>						</type>					</types>				</xsl:otherwise>			</xsl:choose>		</xsl:for-each>	</xsl:template>	<xsl:template name="insertDoelgroep">		<xsl:for-each select="category">			<xsl:for-each select="categorisation_instance[md:objectid = '2.2.1.0.0' or md:objectid = '2.2.2.0.0' or md:objectid = '2.2.3.0.0' or md:objectid = '2.2.4.0.0' or md:objectid = '2.2.5.0.0'] ">				<xsl:sort select="md:objectid" order="ascending"/>				<xsl:if test="position() = 1">					<!-- if there is a numerical value in short description use that -->					<!-- if there are more than one take the lowest age group -->					<xsl:variable name="label" select="./label/dutch"/>					<xsl:variable name="objectid" select="./md:objectid"/>					<xsl:choose>						<xsl:when test="$objectid = '2.2.1.0.0'">							<xsl:choose>								<xsl:when test="string(md:short_description/dutch) != '' and string(number(md:short_description/dutch)) != 'NaN'">									<!--<xsl:attribute name="agefrom"><xsl:value-of select="md:short_description/dutch"/></xsl:attribute>-->									<agefrom>										<xsl:value-of select="md:short_description/dutch"/>									</agefrom>								</xsl:when>								<xsl:otherwise>									<!--<xsl:attribute name="agefrom"><xsl:value-of select="'3'"/></xsl:attribute>-->									<agefrom>										<xsl:value-of select="'3'"/>									</agefrom>								</xsl:otherwise>							</xsl:choose>						</xsl:when>						<xsl:when test="$objectid = '2.2.2.0.0'">							<xsl:choose>								<xsl:when test="string(md:short_description/dutch) != '' and string(number(md:short_description/dutch)) != 'NaN'">									<!--<xsl:attribute name="agefrom"><xsl:value-of select="md:short_description/dutch"/></xsl:attribute>-->									<agefrom>										<xsl:value-of select="md:short_description/dutch"/>									</agefrom>								</xsl:when>								<xsl:otherwise>									<!--<xsl:attribute name="agefrom"><xsl:value-of select="'6'"/></xsl:attribute>-->									<agefrom>										<xsl:value-of select="'6'"/>									</agefrom>								</xsl:otherwise>							</xsl:choose>						</xsl:when>						<xsl:when test="$objectid = '2.2.3.0.0'">							<xsl:choose>								<xsl:when test="string(md:short_description/dutch) != '' and string(number(md:short_description/dutch)) != 'NaN'">									<!--<xsl:attribute name="agefrom"><xsl:value-of select="md:short_description/dutch"/></xsl:attribute>-->									<agefrom>										<xsl:value-of select="md:short_description/dutch"/>									</agefrom>								</xsl:when>								<xsl:otherwise>									<!--<xsl:attribute name="agefrom"><xsl:value-of select="'12'"/></xsl:attribute>-->									<agefrom>										<xsl:value-of select="'12'"/>									</agefrom>								</xsl:otherwise>							</xsl:choose>						</xsl:when>						<xsl:when test="$objectid = '2.2.4.0.0'">							<xsl:choose>								<xsl:when test="string(md:short_description/dutch) != '' and string(number(md:short_description/dutch)) != 'NaN'">									<!--<xsl:attribute name="agefrom"><xsl:value-of select="md:short_description/dutch"/></xsl:attribute>-->									<agefrom>										<xsl:value-of select="md:short_description/dutch"/>									</agefrom>								</xsl:when>								<xsl:otherwise>									<!--<xsl:attribute name="agefrom"><xsl:value-of select="'15'"/></xsl:attribute>-->									<agefrom>										<xsl:value-of select="'15'"/>									</agefrom>								</xsl:otherwise>							</xsl:choose>						</xsl:when>						<xsl:when test="$objectid = '2.2.5.0.0'">							<xsl:choose>								<xsl:when test="string(md:short_description/dutch) != '' and string(number(md:short_description/dutch)) != 'NaN'">									<!--<xsl:attribute name="agefrom"><xsl:value-of select="md:short_description/dutch"/></xsl:attribute>-->									<agefrom>										<xsl:value-of select="md:short_description/dutch"/>									</agefrom>								</xsl:when>								<xsl:otherwise>									<!--<xsl:attribute name="agefrom"><xsl:value-of select="'18'"/></xsl:attribute>-->									<agefrom>										<xsl:value-of select="'18'"/>									</agefrom>								</xsl:otherwise>							</xsl:choose>						</xsl:when>					</xsl:choose>				</xsl:if>			</xsl:for-each>		</xsl:for-each>	</xsl:template>	<xsl:template name="add_type">		<xsl:param name="all_types"/>		<xsl:param name="position"/>		<xsl:if test="$position &lt; 11 and string($all_types) != ''">			<xsl:variable name="label" select="substring-before($all_types,'xxxx')"/>			<xsl:variable name="temp_types_1" select="substring-after($all_types,'xxxx')"/>			<xsl:variable name="objectid" select="substring-before($temp_types_1,'xxxx')"/>			<xsl:variable name="temp_types_2" select="substring-after($temp_types_1,'xxxx')"/>			<type>				<xsl:attribute name="catid"><xsl:value-of select="$objectid"/></xsl:attribute>				<xsl:value-of select="$label"/>			</type>			<xsl:call-template name="add_type">				<xsl:with-param name="all_types" select="$temp_types_2"/>				<xsl:with-param name="position" select="$position +1"/>			</xsl:call-template>		</xsl:if>	</xsl:template></xsl:stylesheet>