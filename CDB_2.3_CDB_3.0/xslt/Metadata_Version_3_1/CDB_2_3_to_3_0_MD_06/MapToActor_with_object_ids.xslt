<?xml version="1.0" encoding="ISO-8859-1"?><xsl:stylesheet version="1.0" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cc="http://www.cultuurdatabank.be/XMLSchema/Culture_CS" xmlns:sc="http://www.cultuurdatabank.be/XMLSchema/SA_comp" xmlns:ad="http://www.cultuurdatabank.be/XMLSchema/address" xmlns:ca="http://www.cultuurdatabank.be/XMLSchema/categorisation" xmlns:ci="http://www.cultuurdatabank.be/XMLSchema/city_area" xmlns:ct="http://www.cultuurdatabank.be/XMLSchema/city_comp" xmlns:co="http://www.cultuurdatabank.be/XMLSchema/country" xmlns:ec="http://www.cultuurdatabank.be/XMLSchema/event_cluster" xmlns:ed="http://www.cultuurdatabank.be/XMLSchema/event_date" xmlns:gc="http://www.cultuurdatabank.be/XMLSchema/gis_comp" xmlns:lc="http://www.cultuurdatabank.be/XMLSchema/language_comp" xmlns:mc="http://www.cultuurdatabank.be/XMLSchema/mail_comp" xmlns:me="http://www.cultuurdatabank.be/XMLSchema/media" xmlns:md="http://www.cultuurdatabank.be/XMLSchema/metadata" xmlns:na="http://www.cultuurdatabank.be/XMLSchema/name_comp" xmlns:no="http://www.cultuurdatabank.be/XMLSchema/note_comp" xmlns:ot="http://www.cultuurdatabank.be/XMLSchema/opening_times" xmlns:or="http://www.cultuurdatabank.be/XMLSchema/organisation" xmlns:pe="http://www.cultuurdatabank.be/XMLSchema/person" xmlns:ph="http://www.cultuurdatabank.be/XMLSchema/phone" xmlns:pr="http://www.cultuurdatabank.be/XMLSchema/price" xmlns:ref="http://www.cultuurdatabank.be/XMLSchema/reference_item" xmlns:rn="http://www.cultuurdatabank.be/XMLSchema/region_nat" xmlns:rel="http://www.cultuurdatabank.be/XMLSchema/relation_item" xmlns:sp="http://www.cultuurdatabank.be/XMLSchema/street_part" xmlns:uc="http://www.cultuurdatabank.be/XMLSchema/url_comp" xmlns:zc="http://www.cultuurdatabank.be/XMLSchema/zip_codes" xmlns:extfun="external_functions" xmlns:xalan="http://xml.apache.org/xalan" exclude-result-prefixes="cc sc ad ca ci ct co ec ed gc lc mc me md na no ot or pe ph pr ref rn rel sp uc zc extfun xalan">	<xsl:output method="xml" version="1.0" encoding="ISO-8859-1" indent="yes"/>	<xsl:template name="insertActor_ref">		<label>			<!-- left in for this version for testing 3.0 -> 2.3 ; -->			<xsl:attribute name="cdbid"><xsl:value-of select="md:objectid"/></xsl:attribute>			<xsl:if test="md:external_identifier != '' and md:external_identifier != 'onbepaald'">				<xsl:attribute name="externalid"><xsl:value-of select="md:external_identifier"/></xsl:attribute>			</xsl:if>			<xsl:value-of select="md:label/dutch"/>		</label>	</xsl:template>	<xsl:template name="insertActor">		<actor>					<xsl:for-each select="md:availablefrom">				<xsl:attribute name="availablefrom"><xsl:value-of select="."/></xsl:attribute>			</xsl:for-each>			<xsl:for-each select="md:availableto">				<xsl:if test="substring(.,1,4) &lt; 2020">					<xsl:attribute name="availableto"><xsl:value-of select="."/></xsl:attribute>				</xsl:if>			</xsl:for-each>			<xsl:for-each select="md:objectid">				<xsl:attribute name="cdbid"><xsl:value-of select="."/></xsl:attribute>			</xsl:for-each>						<xsl:choose>				<xsl:when test="md:external_identifier != '' and md:external_identifier != 'onbepaald'">					<xsl:attribute name="externalid"><xsl:value-of select="md:external_identifier"/></xsl:attribute>				</xsl:when>				<xsl:otherwise>					<xsl:attribute name="externalid">					<xsl:value-of select="concat('CDB:',md:objectid)"/></xsl:attribute>				</xsl:otherwise>			</xsl:choose>												<actorcategories>				<xsl:call-template name="insertCategorisation"/>			</actorcategories>			<actordetails>				<actordetail>					<xsl:variable name="lang">						<xsl:choose>							<xsl:when test="string(lc:language_comp/language_comp_instance/iso_code) != ''">								<xsl:value-of select="lc:language_comp/language_comp_instance/iso_code"/>							</xsl:when>							<xsl:otherwise>								<xsl:value-of select="'nl'"/>							</xsl:otherwise>						</xsl:choose>					</xsl:variable>					<xsl:attribute name="lang"><xsl:value-of select="$lang"/></xsl:attribute>					<!-- calendersummary -->					<xsl:if test="string(ot:opening_times) != ''">						<calendarsummary>							<xsl:call-template name="permanent_summary"/>						</calendarsummary>					</xsl:if>					<!-- edited -->					<xsl:variable name="media_exists">						<xsl:if test="me:media/media_instance/file !=''">							<xsl:value-of select="true()"/>						</xsl:if>					</xsl:variable>					<xsl:if test="string($media_exists) = 'true'">						<media>							<xsl:for-each select="me:media">								<xsl:for-each select="media_instance">									<xsl:if test="string(file) !=''">										<file>											<xsl:for-each select="md:objectid">												<xsl:attribute name="cdbid"><xsl:value-of select="."/></xsl:attribute>											</xsl:for-each>											<copyright>												<xsl:choose>													<xsl:when test="string(copyright) != ''">														<xsl:value-of select="copyright"/>													</xsl:when>													<xsl:otherwise>														<xsl:value-of select="'NB'"/>													</xsl:otherwise>												</xsl:choose>											</copyright>											<filename>												<xsl:value-of select="file"/>											</filename>											<xsl:for-each select="media_type">												<filetype>													<xsl:value-of select="."/>												</filetype>											</xsl:for-each>											<hlink>												<xsl:value-of select="file"/>											</hlink>											<xsl:for-each select="md:label">												<xsl:for-each select="dutch">													<title>														<xsl:value-of select="."/>													</title>												</xsl:for-each>											</xsl:for-each>										</file>									</xsl:if>								</xsl:for-each>							</xsl:for-each>						</media>					</xsl:if>					<!-- end edited -->					<xsl:for-each select="md:short_description">						<xsl:for-each select="dutch">							<shortdescription>								<xsl:value-of select="."/>							</shortdescription>						</xsl:for-each>					</xsl:for-each>					<xsl:for-each select="md:label">						<xsl:for-each select="dutch">							<title>								<xsl:value-of select="."/>							</title>						</xsl:for-each>					</xsl:for-each>				</actordetail>			</actordetails>			<!--  <xsl:if test="string(address/ad:address/address_instance) != ''">  -->			<xsl:call-template name="insertContactinfo">				<xsl:with-param name="contact" select="'false'"/>			</xsl:call-template>			<!--				<contactinfo>					<xsl:for-each select="address">						<xsl:for-each select="ad:address">							<xsl:if test="string(address_instance/zip_codes) != 'NB' and string(address_instance/city_free_text) != 'NB' and string(address_instance/city_free_text) != '' and string(address_instance/zip_codes) != '' and string(address_instance/zip_codes) != '0000'">								<address>									<xsl:for-each select="ref:reference_item">										<xsl:for-each select="main">											<xsl:attribute name="main"><xsl:value-of select="."/></xsl:attribute>										</xsl:for-each>									</xsl:for-each>									<physical>										<city>											<xsl:value-of select="address_instance/city_free_text"/>										</city>										<xsl:for-each select="address_instance">																					<xsl:variable name="VEXISTS">												<xsl:variable name="ExistsResult">													<xsl:for-each select="country_free_text">														<xsl:value-of select="true()"/>													</xsl:for-each>												</xsl:variable>												<xsl:choose>																										<xsl:when test="string($ExistsResult) = 'true'">																											<xsl:value-of select="'true'"/>													</xsl:when>													<xsl:otherwise>														<xsl:value-of select="'false'"/>													</xsl:otherwise>												</xsl:choose>											</xsl:variable>											<country>												<xsl:variable name="ConditionResult">													<xsl:choose>														<xsl:when test="string($VEXISTS)='true'">															<xsl:for-each select="country_free_text">																<xsl:variable name="country_free_text" select="."/>																															<xsl:variable name="country" select="$Countries/ISO_3166-1_List_en/ISO_3166-1_Entry[(Country_Name=$country_free_text)]/ISO_3166-1_Alpha-2_Code_element"/>																<xsl:copy-of select="$country"/>															</xsl:for-each>														</xsl:when>														<xsl:otherwise>															<xsl:value-of select="'BE'"/>														</xsl:otherwise>													</xsl:choose>												</xsl:variable>												<xsl:value-of select="$ConditionResult"/>											</country>																				</xsl:for-each>										<xsl:for-each select="address_instance">											<xsl:if test="string(house_number) != ''">												<housenr>													<xsl:value-of select="house_number"/>												</housenr>											</xsl:if>										</xsl:for-each>										<xsl:for-each select="address_instance">											<xsl:for-each select="street_free_text">												<street>													<xsl:value-of select="."/>												</street>											</xsl:for-each>										</xsl:for-each>										<xsl:for-each select="address_instance">											<xsl:for-each select="zip_codes">												<zipcode>													<xsl:value-of select="."/>												</zipcode>											</xsl:for-each>										</xsl:for-each>									</physical>								</address>							</xsl:if>						</xsl:for-each>					</xsl:for-each>					<xsl:for-each select="mail_comp">						<xsl:for-each select="mc:mail_comp">							<xsl:variable name="mail_comp1" select="."/>							<xsl:for-each select="mail_comp_instance">								<xsl:variable name="mail_comp_instance1" select="."/>								<xsl:for-each select="username">									<xsl:variable name="username1" select="."/>									<xsl:for-each select="$mail_comp_instance1/domain">										<xsl:variable name="domain1" select="."/>										<xsl:variable name="concatResult6" select="concat($username1, '@')"/>										<xsl:variable name="concatResult7" select="concat($concatResult6, $domain1)"/>																				<xsl:if test="string(concatResult2) != '' and string(concatResult3) != ''">											<xsl:if test="contains($concatResult7,',') = false()">												<mail>													<xsl:value-of select="translate($concatResult7,' ','')"/>													<xsl:for-each select="$mail_comp1/ref:reference_item">														<xsl:for-each select="main">															<xsl:attribute name="main"><xsl:value-of select="."/></xsl:attribute>														</xsl:for-each>													</xsl:for-each>												</mail>											</xsl:if>										</xsl:if>									</xsl:for-each>								</xsl:for-each>							</xsl:for-each>						</xsl:for-each>					</xsl:for-each>					<xsl:for-each select="phone">						<xsl:for-each select="ph:phone">							<xsl:variable name="phone1" select="."/>							<xsl:for-each select="phone_instance">								<xsl:for-each select="number">									<phone>										<xsl:for-each select="$phone1/ref:reference_item">											<xsl:for-each select="main">												<xsl:attribute name="main"><xsl:value-of select="."/></xsl:attribute>											</xsl:for-each>										</xsl:for-each>										<xsl:value-of select="."/>									</phone>								</xsl:for-each>							</xsl:for-each>						</xsl:for-each>					</xsl:for-each>					<xsl:for-each select="url_comp">						<xsl:for-each select="uc:url_comp">							<xsl:variable name="url_comp1" select="."/>							<xsl:for-each select="url_comp_instance">								<xsl:for-each select="url_value">									<url>										<xsl:for-each select="$url_comp1/ref:reference_item">											<xsl:for-each select="main">												<xsl:attribute name="main"><xsl:value-of select="."/></xsl:attribute>											</xsl:for-each>										</xsl:for-each>										<xsl:value-of select="."/>									</url>								</xsl:for-each>							</xsl:for-each>						</xsl:for-each>					</xsl:for-each>				</contactinfo>			</xsl:if>  -->			<xsl:for-each select="md:keywords">				<keywords>					<xsl:value-of select="."/>				</keywords>			</xsl:for-each>		</actor>	</xsl:template>	<xsl:template name="insertActor_address">		<xsl:if test="string(address/ad:address/address_instance) != ''">			<xsl:for-each select="address">				<xsl:for-each select="ad:address">					<xsl:if test="string(address_instance/zip_codes) != 'NB' and string(address_instance/city_free_text) != 'NB' and string(address_instance/city_free_text) != '' and string(address_instance/zip_codes) != '' and string(address_instance/zip_codes) != '0000'">						<address>							<xsl:for-each select="ref:reference_item">								<xsl:for-each select="main">									<xsl:attribute name="main"><xsl:value-of select="."/></xsl:attribute>								</xsl:for-each>							</xsl:for-each>							<xsl:if test="string(address_instance/category/categorisation_instance/label/dutch) = 'reservatie'">								<xsl:attribute name="reservation"><xsl:value-of select="true()"/></xsl:attribute>							</xsl:if>							<physical>								<city>									<xsl:value-of select="address_instance/city_free_text"/>								</city>								<xsl:for-each select="address_instance">									<!-- added -->																		<country>										<xsl:choose>											<xsl:when test="string(country_free_text) !=''">												<xsl:variable name="country_free_text" select="country_free_text"/>												<!--<xsl:variable name="country" select="$Countries/ISO_3166-1_List_en/ISO_3166-1_Entry[(Country_Name=$country_free_text)]/ISO_3166-1_Alpha-2_Code_element"/>   -->												<xsl:variable name="country">												<xsl:value-of select="$Countries/ISO_3166-1_List_en/ISO_3166-1_Entry[(Country_Name=$country_free_text)]/ISO_3166-1_Alpha-2_Code_element"/>												</xsl:variable>													<xsl:choose>														<xsl:when test="string($country) !=''">															<xsl:value-of select="$country"></xsl:value-of>														</xsl:when>														<xsl:otherwise><xsl:value-of select="'BE'"/></xsl:otherwise>													</xsl:choose>											</xsl:when>											<xsl:otherwise>												<xsl:value-of select="'BE'"/>											</xsl:otherwise>										</xsl:choose>									</country>									<!--add GIS here  -->								</xsl:for-each>								<xsl:for-each select="address_instance">									<xsl:if test="string(house_number) != ''">										<housenr>											<xsl:value-of select="house_number"/>										</housenr>									</xsl:if>								</xsl:for-each>								<xsl:for-each select="address_instance">									<xsl:for-each select="street_free_text">										<street>											<xsl:value-of select="."/>										</street>									</xsl:for-each>								</xsl:for-each>								<xsl:for-each select="address_instance">									<xsl:for-each select="zip_codes">										<zipcode>											<xsl:choose>												<xsl:when test="string-length(.) &lt; 4 or string-length(.) &gt; 15">0000</xsl:when>												<xsl:otherwise>													<xsl:value-of select="."/>												</xsl:otherwise>											</xsl:choose>										</zipcode>									</xsl:for-each>								</xsl:for-each>							</physical>						</address>					</xsl:if>				</xsl:for-each>			</xsl:for-each>		</xsl:if>	</xsl:template>	<!-- only one address for a location reference -->	<xsl:template name="insertActor_address_ref">		<xsl:if test="string(address/ad:address/address_instance) != ''">			<xsl:for-each select="address">				<xsl:for-each select="ad:address">					<xsl:if test="position() = 1">						<xsl:if test="string(address_instance/zip_codes) != 'NB' and string(address_instance/city_free_text) != 'NB' and string(address_instance/city_free_text) != '' and string(address_instance/zip_codes) != '' and string(address_instance/zip_codes) != '0000'">							<address>								<xsl:for-each select="ref:reference_item">									<xsl:for-each select="main">										<xsl:attribute name="main"><xsl:value-of select="."/></xsl:attribute>									</xsl:for-each>								</xsl:for-each>								<xsl:if test="string(address_instance/category/categorisation_instance/label/dutch) = 'reservatie'">									<xsl:attribute name="reservation"><xsl:value-of select="true()"/></xsl:attribute>								</xsl:if>								<physical>									<city>										<xsl:value-of select="address_instance/city_free_text"/>									</city>									<xsl:for-each select="address_instance">										<!-- added -->																				<country>										<xsl:choose>											<xsl:when test="string(country_free_text) !=''">												<xsl:variable name="country_free_text" select="country_free_text"/>												<!--<xsl:variable name="country" select="$Countries/ISO_3166-1_List_en/ISO_3166-1_Entry[(Country_Name=$country_free_text)]/ISO_3166-1_Alpha-2_Code_element"/>   -->												<xsl:variable name="country">												<xsl:value-of select="$Countries/ISO_3166-1_List_en/ISO_3166-1_Entry[(Country_Name=$country_free_text)]/ISO_3166-1_Alpha-2_Code_element"/>												</xsl:variable>													<xsl:choose>														<xsl:when test="string($country) !=''">															<xsl:value-of select="$country"></xsl:value-of>														</xsl:when>														<xsl:otherwise><xsl:value-of select="'BE'"/></xsl:otherwise>													</xsl:choose>											</xsl:when>											<xsl:otherwise>												<xsl:value-of select="'BE'"/>											</xsl:otherwise>										</xsl:choose>									</country>																				<!-- end added -->									</xsl:for-each>									<xsl:for-each select="address_instance">										<xsl:if test="string(house_number) != ''">											<housenr>												<xsl:value-of select="house_number"/>											</housenr>										</xsl:if>									</xsl:for-each>									<xsl:for-each select="address_instance">										<xsl:for-each select="street_free_text">											<street>												<xsl:value-of select="."/>											</street>										</xsl:for-each>									</xsl:for-each>									<xsl:for-each select="address_instance">										<xsl:for-each select="zip_codes">											<zipcode>											<xsl:choose>												<xsl:when test="string-length(.) &lt; 4 or string-length(.) &gt; 15">0000</xsl:when>												<xsl:otherwise>													<xsl:value-of select="."/>												</xsl:otherwise>											</xsl:choose>										</zipcode>										</xsl:for-each>									</xsl:for-each>								</physical>							</address>						</xsl:if>					</xsl:if>				</xsl:for-each>			</xsl:for-each>		</xsl:if>	</xsl:template>	<xsl:template name="insertContactinfo">		<xsl:param name="contact"/>		<contactinfo>			<!-- only add the address if that is all there is and it a contact			<xsl:if test="(string(mail_comp) = '' and string(phone) = '' and string(url_comp) = '') or (string($contact) = 'false')">-->			<xsl:for-each select="address">				<xsl:for-each select="ad:address">					<xsl:if test="string(address_instance/zip_codes) != 'NB' and string(address_instance/city_free_text) != 'NB' and string(address_instance/city_free_text) != '' and string(address_instance/zip_codes) != '' and string(address_instance/zip_codes) != '0000'">						<address>							<xsl:for-each select="ref:reference_item">								<xsl:for-each select="main">									<xsl:attribute name="main"><xsl:value-of select="."/></xsl:attribute>								</xsl:for-each>							</xsl:for-each>							<xsl:if test="string(address_instance/category/categorisation_instance/label/dutch) = 'reservatie'">								<xsl:attribute name="reservation"><xsl:value-of select="true()"/></xsl:attribute>							</xsl:if>							<physical>								<city>									<xsl:value-of select="address_instance/city_free_text"/>								</city>								<xsl:for-each select="address_instance">									<country>										<xsl:choose>											<xsl:when test="string(country_free_text) !=''">												<xsl:variable name="country_free_text" select="country_free_text"/>												<!--<xsl:variable name="country" select="$Countries/ISO_3166-1_List_en/ISO_3166-1_Entry[(Country_Name=$country_free_text)]/ISO_3166-1_Alpha-2_Code_element"/>   -->												<xsl:variable name="country">												<xsl:value-of select="$Countries/ISO_3166-1_List_en/ISO_3166-1_Entry[(Country_Name=$country_free_text)]/ISO_3166-1_Alpha-2_Code_element"/>												</xsl:variable>													<xsl:choose>														<xsl:when test="string($country) !=''">															<xsl:value-of select="$country"></xsl:value-of>														</xsl:when>														<xsl:otherwise><xsl:value-of select="'BE'"/></xsl:otherwise>													</xsl:choose>											</xsl:when>											<xsl:otherwise>												<xsl:value-of select="'BE'"/>											</xsl:otherwise>										</xsl:choose>									</country>									<!-- end added -->								</xsl:for-each>								<xsl:for-each select="address_instance">									<xsl:if test="string(house_number) != ''">										<housenr>											<xsl:value-of select="house_number"/>										</housenr>									</xsl:if>								</xsl:for-each>								<xsl:for-each select="address_instance">									<xsl:for-each select="street_free_text">										<street>											<xsl:value-of select="."/>										</street>									</xsl:for-each>								</xsl:for-each>								<xsl:for-each select="address_instance">									<xsl:for-each select="zip_codes">										<zipcode>											<xsl:choose>												<xsl:when test="string-length(.) &lt; 4 or string-length(.) &gt; 15">0000</xsl:when>												<xsl:otherwise>													<xsl:value-of select="."/>												</xsl:otherwise>											</xsl:choose>										</zipcode>									</xsl:for-each>								</xsl:for-each>							</physical>						</address>					</xsl:if>				</xsl:for-each>			</xsl:for-each>			<!--  </xsl:if>  -->			<xsl:for-each select="mail_comp">				<xsl:for-each select="mc:mail_comp">					<xsl:variable name="position">						<xsl:value-of select="position()"/>					</xsl:variable>					<xsl:variable name="mail_comp1" select="."/>					<xsl:for-each select="mail_comp_instance">						<xsl:if test="string(username) != string(../../mc:mail_comp[position()=$position+1]/mail_comp_instance/username)									or string(domain) != string(../../mc:mail_comp[position()=$position+1]/mail_comp_instance/domain)">							<xsl:variable name="mail_comp_instance1" select="."/>							<xsl:for-each select="username">								<xsl:variable name="username1" select="normalize-space(.)"/>								<xsl:for-each select="$mail_comp_instance1/domain">									<xsl:variable name="domain1" select="."/>									<xsl:variable name="concatResult6" select="concat($username1, '@')"/>									<xsl:variable name="concatResult7" select="concat($concatResult6, $domain1)"/>									<!-- BAD test -->									<!-- make sure there are no bad characters in the email address -->									<!--									<xsl:if test="string($concatResult6) != '' and string($concatResult7) != ''">										<xsl:if test="contains($domain1,'@') = false()">											<xsl:if test="contains($username1,'@') = false()">												<xsl:if test="contains($concatResult7,',') = false()">													<xsl:if test="contains($concatResult7,':') = false()">														<xsl:if test="contains($concatResult7,'&amp;') = false()">															<xsl:if test="substring($concatResult7,string-length($concatResult7),1) != '.'">																<xsl:if test="contains($concatResult7,'�') = false()">																	<xsl:if test="contains($concatResult7,';') = false()">																		<xsl:if test="contains($concatResult7,'&gt;') = false()">																			<xsl:if test="contains($concatResult7,'�') = false()"> -->									<!-- call the script to check the email address -->									<!--aaa<xsl:value-of select="extfun:emailCheck(string($concatResult7))"></xsl:value-of>bbb-->									<xsl:if test="contains($concatResult7,'&gt;') = false()">										<!-- get rid of trailingspaces or a lot of emails are excluded -->										<xsl:if test="extfun:emailCheck(string(translate($concatResult7,' ','')))">											<mail>												<xsl:for-each select="$mail_comp1/ref:reference_item">													<xsl:for-each select="main">														<xsl:attribute name="main"><xsl:value-of select="."/></xsl:attribute>													</xsl:for-each>												</xsl:for-each>												<xsl:if test="string($mail_comp_instance1/category/categorisation_instance/label/dutch) = 'reservatie'">													<xsl:attribute name="reservation"><xsl:value-of select="true()"/></xsl:attribute>												</xsl:if>												<xsl:value-of select="translate($concatResult7,' ','')"/>											</mail>											<!-- </xsl:if>																			</xsl:if>																		</xsl:if>																	</xsl:if>																</xsl:if>															</xsl:if>														</xsl:if>													</xsl:if>												</xsl:if>											</xsl:if>										</xsl:if> -->										</xsl:if>									</xsl:if>								</xsl:for-each>							</xsl:for-each>						</xsl:if>					</xsl:for-each>				</xsl:for-each>			</xsl:for-each>			<!-- check that there are not 2 phone numbers that are the same -->			<!-- try this 			<xsl:for-each select="phone_instance[number != number(next)]">-->			<xsl:for-each select="phone">				<xsl:for-each select="ph:phone">					<xsl:variable name="position">						<xsl:value-of select="position()"/>					</xsl:variable>					<xsl:variable name="phone1" select="."/>					<xsl:for-each select="phone_instance">						<!--						zzz<xsl:value-of select="number"/>						xxx <xsl:value-of select="../../ph:phone[position()=$position+1]/phone_instance/number"></xsl:value-of> -->						<xsl:if test="string(number) != string(../../ph:phone[position()=$position+1]/phone_instance/number)">							<phone>								<xsl:for-each select="$phone1/ref:reference_item">									<xsl:for-each select="main">										<xsl:attribute name="main"><xsl:value-of select="."/></xsl:attribute>									</xsl:for-each>								</xsl:for-each>								<xsl:if test="string(../category/categorisation_instance/label/dutch) = 'reservatie'">									<xsl:attribute name="reservation"><xsl:value-of select="true()"/></xsl:attribute>								</xsl:if>								<xsl:if test="string(phone_type) = 'fax'">									<xsl:attribute name="type"><xsl:value-of select="'fax'"/></xsl:attribute>								</xsl:if>								<xsl:value-of select="number"/>							</phone>						</xsl:if>					</xsl:for-each>				</xsl:for-each>			</xsl:for-each>			<xsl:for-each select="url_comp">				<xsl:for-each select="uc:url_comp">					<xsl:variable name="position">						<xsl:value-of select="position()"/>					</xsl:variable>					<xsl:variable name="url_comp1" select="."/>					<xsl:for-each select="url_comp_instance">						<xsl:if test="string(url_value) != string(../../uc:url_comp[position()=$position+1]/url_comp_instance/url_value)">							<xsl:if test="string(url_value) !=''">														<!-- check that the url is valid -->							<xsl:variable name="valid_url">								<xsl:value-of select="extfun:isValidURL(string(url_value))"/>							</xsl:variable>							<!--							<xsl:value-of select="$valid_url"></xsl:value-of>							-->														<xsl:if test="$valid_url = 'true'">								<xsl:for-each select="url_value">									<url>										<xsl:for-each select="$url_comp1/ref:reference_item">											<xsl:for-each select="main">												<xsl:attribute name="main"><xsl:value-of select="."/></xsl:attribute>											</xsl:for-each>										</xsl:for-each>										<xsl:if test="string(../category/categorisation_instance/label/dutch) = 'reservatie'">											<xsl:attribute name="reservation"><xsl:value-of select="true()"/></xsl:attribute>										</xsl:if>										<xsl:choose>											<xsl:when test="substring(.,1,7) = 'http//:'">												<xsl:value-of select="concat('http://',substring(.,8))"/>											</xsl:when>											<xsl:when test="substring(.,1,4) = 'http'">												<xsl:value-of select="."/>											</xsl:when>											<xsl:otherwise>												<xsl:value-of select="concat('http://',.)"/>											</xsl:otherwise>										</xsl:choose>									</url>								</xsl:for-each>								</xsl:if>							</xsl:if>						</xsl:if>					</xsl:for-each>				</xsl:for-each>			</xsl:for-each>		</contactinfo>	</xsl:template></xsl:stylesheet>