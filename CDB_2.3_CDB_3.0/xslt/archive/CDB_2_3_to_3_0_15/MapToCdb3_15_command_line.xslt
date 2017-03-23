<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
Maps CDB 2.3 to CDB 3.0
-->
<xsl:stylesheet version="1.0" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:cc="http://www.cultuurdatabank.be/XMLSchema/Culture_CS" xmlns:sc="http://www.cultuurdatabank.be/XMLSchema/SA_comp" xmlns:ad="http://www.cultuurdatabank.be/XMLSchema/address" xmlns:ca="http://www.cultuurdatabank.be/XMLSchema/categorisation" xmlns:ci="http://www.cultuurdatabank.be/XMLSchema/city_area" xmlns:ct="http://www.cultuurdatabank.be/XMLSchema/city_comp" xmlns:co="http://www.cultuurdatabank.be/XMLSchema/country" xmlns:ec="http://www.cultuurdatabank.be/XMLSchema/event_cluster" xmlns:ed="http://www.cultuurdatabank.be/XMLSchema/event_date" xmlns:gc="http://www.cultuurdatabank.be/XMLSchema/gis_comp" xmlns:lc="http://www.cultuurdatabank.be/XMLSchema/language_comp" xmlns:mc="http://www.cultuurdatabank.be/XMLSchema/mail_comp" xmlns:me="http://www.cultuurdatabank.be/XMLSchema/media" xmlns:md="http://www.cultuurdatabank.be/XMLSchema/metadata" xmlns:na="http://www.cultuurdatabank.be/XMLSchema/name_comp" xmlns:no="http://www.cultuurdatabank.be/XMLSchema/note_comp" xmlns:ot="http://www.cultuurdatabank.be/XMLSchema/opening_times" xmlns:or="http://www.cultuurdatabank.be/XMLSchema/organisation" xmlns:pe="http://www.cultuurdatabank.be/XMLSchema/person" xmlns:ph="http://www.cultuurdatabank.be/XMLSchema/phone" xmlns:pr="http://www.cultuurdatabank.be/XMLSchema/price" xmlns:ref="http://www.cultuurdatabank.be/XMLSchema/reference_item" xmlns:rn="http://www.cultuurdatabank.be/XMLSchema/region_nat" xmlns:rel="http://www.cultuurdatabank.be/XMLSchema/relation_item" xmlns:sp="http://www.cultuurdatabank.be/XMLSchema/street_part" xmlns:uc="http://www.cultuurdatabank.be/XMLSchema/url_comp" xmlns:zc="http://www.cultuurdatabank.be/XMLSchema/zip_codes" xmlns:java="http://xml.apache.org/xalan/java" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:extfun="external_functions" xmlns:file="java.io.File" xmlns:xalan="http://xml.apache.org/xalan" exclude-result-prefixes="cc sc ad ca ci ct co ec ed gc lc mc me md na no ot or pe ph pr ref rn rel sp uc zc xs xalan java extfun file">
	<!--   xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL"  -->
	<xsl:output method="xml" version="1.0" encoding="ISO-8859-1" indent="yes" omit-xml-declaration="no"/>
	<xalan:component prefix="extfun">
		<xalan:script lang="javascript"><![CDATA[ 
		
		function isValidURL(url){ 
    var RegExp = /^(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$/; 
    
   //  java.lang.System.out.println('-----  ');
   //  java.lang.System.out.println(url);
   //  java.lang.System.out.println('  -----');
    if(RegExp.test(url)){ 
        return true; 
    }else{ 
        return false; 
    } 
} 

		function get_text_file(infilename)
		 {
		// ISO-8859-1  
		// Need to use a FileInputStream so ISO-8859-1 can be specified.
		
		var file = new java.io.FileInputStream(infilename)
		var file_in = new java.io.InputStreamReader(file,'ISO-8859-1')
		var input = new java.io.BufferedReader(file_in)
		// var file_in = new java.io.InputStreamReader(file,'UTF-16')
		
		var all_text = new java.lang.StringBuffer  
		
		// reads characters :
		// while ((str = file_in.read()) != -1) {
		
		while ((str = input.readLine()) != null) {
			
			all_text.append(str).toString()
			// note that read line dos not copy line termination characters so add a cr/lf at the end of every line
			all_text.append('\n').toString()
			
		}
		input.close();
		file.close()
		file_in.close()

		 return all_text
		 
		
		 }
		
    	 
		
		 
		 
		function emailCheck(emailSt) {

/* The following variable tells the rest of the function whether or not
to verify that the address ends in a two-letter country or well-known
TLD.  1 means check it, 0 means don't. */

var checkTLD=1;

/* The following is the list of known TLDs that an e-mail address must end with. */

var knownDomsPat=/^(com|net|org|edu|int|mil|gov|arpa|biz|aero|name|coop|info|pro|museum)$/;

/* The following pattern is used to check if the entered e-mail address
fits the user@domain format.  It also is used to separate the username
from the domain. */

var emailPat=/^(.+)@(.+)$/;

/* The following string represents the pattern for matching all special
characters.  We don't want to allow special characters in the address. 
These characters include ( ) < > @ , ; : \ " . [ ] */

var specialChars="\\(\\)><@,;:\\\\\\\"\\.\\[\\]";

/* The following string represents the range of characters allowed in a 
username or domainname.  It really states which chars aren't allowed.*/

var validChars="\[^\\s" + specialChars + "\]";

/* The following pattern applies if the "user" is a quoted string (in
which case, there are no rules about which characters are allowed
and which aren't; anything goes).  E.g. "jiminy cricket"@disney.com
is a legal e-mail address. */

var quotedUser="(\"[^\"]*\")";

/* The following pattern applies for domains that are IP addresses,
rather than symbolic names.  E.g. joe@[123.124.233.4] is a legal
e-mail address. NOTE: The square brackets are required. */

var ipDomainPat=/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/;

/* The following string represents an atom (basically a series of non-special characters.) */

var atom=validChars + '+';

/* The following string represents one word in the typical username.
For example, in john.doe@somewhere.com, john and doe are words.
Basically, a word is either an atom or quoted string. */

var word="(" + atom + "|" + quotedUser + ")";

// The following pattern describes the structure of the user

var userPat=new RegExp("^" + word + "(\\." + word + ")*$");

/* The following pattern describes the structure of a normal symbolic
domain, as opposed to ipDomainPat, shown above. */

var domainPat=new RegExp("^" + atom + "(\\." + atom +")*$");

/* Finally, let's start trying to figure out if the supplied address is valid. */

/* Begin with the coarse pattern to simply break up user@domain into
different pieces that are easy to analyze. */




var matchArray=emailSt.match(emailPat);


if (matchArray==null) {

/* Too many/few @'s or something; basically, this address doesn't
even fit the general mould of a valid e-mail address. */

// xx alert("Email address seems incorrect (check @ and .'s)");
return false;
}
var user=matchArray[1];
var domain=matchArray[2];

// Start by checking that only basic ASCII characters are in the strings (0-127).

for (i=0; i<user.length; i++) {
if (user.charCodeAt(i)>127) {
// xx alert("Ths username contains invalid characters.");
return false;
 }
 }
for (i=0; i<domain.length; i++) {
if (domain.charCodeAt(i)>127) {
// xx alert("Ths domain name contains invalid characters.");
return false;
 }
}

// See if "user" is valid 

if (user.match(userPat)==null) {

// user is not valid

// xx alert("The username doesn't seem to be valid.");
return false;
}

/* if the e-mail address is at an IP address (as opposed to a symbolic
host name) make sure the IP address is valid. */

var IPArray=domain.match(ipDomainPat);
if (IPArray!=null) {

// this is an IP address

for (var i=1;i<=4;i++) {
if (IPArray[i]>255) {
// xx alert("Destination IP address is invalid!");
return false;
   }
}
 return true;
 }

// Domain is symbolic name.  Check if it's valid.
 
var atomPat=new RegExp("^" + atom + "$");
var domArr=domain.split(".");
var len=domArr.length;
for (i=0;i<len;i++) {
if (domArr[i].search(atomPat)==-1) {
// xx alert("The domain name does not seem to be valid.");
return false;
 }
 }

/* domain name seems valid, but now make sure that it ends in a
known top-level domain (like com, edu, gov) or a two-letter word,
representing country (uk, nl), and that there's a hostname preceding 
the domain or country. */

if (checkTLD && domArr[domArr.length-1].length!=2 && 
domArr[domArr.length-1].search(knownDomsPat)==-1) {
// xx alert("The address must end in a well-known domain or two letter " + "country.");
return false;
 }

// Make sure there's a host name preceding the domain.

if (len<2) {
// xx alert("This address is missing a hostname!");
return false;
}

// If we've gotten this far, everything's valid!
return true;
}

	
		]]></xalan:script>
	</xalan:component>
	<xsl:param name="iis.ext.files"/>
	<xsl:include href="MapToCategorisation.xslt"/>
	<!-- <xsl:include href="MapToActor.xslt"/>  -->
	<xsl:include href="MapToActor_with_object_ids.xslt"/>
	<xsl:include href="MapToCalendar.xslt"/>
	<xsl:include href="MapToProductions.xslt"/>
	<xsl:variable name="GeoDoelgroep" select="document('read_only\GeoDoelgroep.xml')"/>
	<xsl:variable name="Age_Doelgroep" select="document('read_only\doelgroep.xml')"/>
	<xsl:variable name="Admittance" select="document('read_only\toegank.xml')"/>
	<xsl:variable name="Facilities" select="document('read_only\facilities.xml')"/>
	<xsl:variable name="Thema" select="document('read_only\Thema.xml')"/>
	<xsl:variable name="Type" select="document('read_only\Type.xml')"/>
	<xsl:variable name="Countries" select="document('read_only\iso_3166-1_list_en.xml')"/>
	<xsl:variable name="Optional_Cats" select="document('read_only\optional.xml')"/>
	<!-- <xsl:variable name="actor_type" select="'reference'"/> -->
	<!-- <xsl:variable name="actor_type" select="'full'"/>  -->
	<xsl:variable name="actor_type" select="'full'"/>
	<!-- <xsl:param name="media_files" select="iis.ext.files"></xsl:param> -->
	<!-- <xsl:param name="media_files" select="'media_files'"></xsl:param> -->
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
	<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'"/>
	<xsl:param name="iis.ext.files"/>
	<xsl:template match="/CDB">
		<cdbxml>
			<!-- <xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL
\\172.16.1.51\xml\XSD\CDB_3_0\CDBXML~1.0-F\CdbXSD.xsd</xsl:attribute>-->
			<!-- <xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL //172.16.1.51/xml/XSD/CDB_3_0/CdbXSD_3.0/CdbXSD_3.0/CdbXSD.xsd</xsl:attribute> -->
			<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL
		http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL/CdbXSD.xsd</xsl:attribute>
			<!-- Metadata -->
			<metadata>
				<versions>
					<categorisation>
						<!-- <xsl:attribute name="url"><xsl:value-of select="'http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL/categories/1.8/categories.xml'"/></xsl:attribute> -->
						<xsl:attribute name="url"><xsl:value-of select="'http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL/categories/1.12/categorisation.xml'"/></xsl:attribute>
					</categorisation>
					<regions>
						<xsl:attribute name="url"><xsl:value-of select="'http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL/regions/1.0/regions.xml'"/></xsl:attribute>
					</regions>
				</versions>
			</metadata>
			<!-- add the events -->
			<xsl:if test="count(//event_cluster_instance) != 0">
				<events>
					<!--<xsl:for-each select="ec:event_cluster"-->
					<xsl:for-each select="//event_cluster_instance[event_cluster_type='aanbod']">
						<xsl:variable name="organisator_exists">
							<xsl:for-each select="organisation">
								<xsl:for-each select="or:organisation">
									<xsl:if test="rel:relation_item/relation_item_instance/categorisation_label = 'organisator'">
										<xsl:value-of select="'true'"/>
									</xsl:if>
								</xsl:for-each>
							</xsl:for-each>
							<xsl:for-each select="person">
								<xsl:for-each select="pe:person">
									<xsl:if test="rel:relation_item/relation_item_instance/categorisation_label = 'organisator'">
										<xsl:value-of select="true()"/>
									</xsl:if>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:variable>
						<xsl:variable name="location_address">
							<xsl:for-each select="organisation">
								<xsl:for-each select="or:organisation">
									<xsl:if test="rel:relation_item/relation_item_instance/categorisation_label = 'lokatie'">
										<xsl:if test="string(organisation_instance/address) != '' and string(organisation_instance/address/ad:address/address_instance/city_free_text) != '' and string(organisation_instance/address/ad:address/address_instance/zip_codes) != '0000'">
											<xsl:value-of select="'true'"/>
										</xsl:if>
									</xsl:if>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:variable>
						<!-- There is a fault with some opening times 																					-->
						<!-- Sometimes when an event is period and we are expecting an weekschema all the opening	-->
						<!--	times instances with upen_type = open have the same date in time_start and time end and 	-->
						<!-- year is not 1970 as it should be																									-->
						<xsl:variable name="bad_opening_times">
							<xsl:if test="string(event_type) = 'periode'">
								<xsl:for-each select="ot:opening_times/opening_times_instance">
									<xsl:if test="string(open_type) = 'open' and string(year) != '1970' and string(week_number) = '0'">
										<xsl:value-of select="'true'"/>
									</xsl:if>
								</xsl:for-each>
							</xsl:if>
						</xsl:variable>
						<!-- There is a fault with some opening times 																					-->
						<!-- Sometimes when an event is period and we are expecting an weekschema there is not an	-->
						<!-- opening times instance for each day																							-->
						<xsl:variable name="check_opening_times_1">
							<xsl:choose>
								<xsl:when test="string(event_type) = 'periode'">
									<xsl:for-each select="ot:opening_times/opening_times_instance">
										<xsl:if test="string(day_type) = 'maandag' and string(year) = '1970' and string(week_number) = '0'">
											<xsl:value-of select="'1'"/>
										</xsl:if>
										<xsl:if test="string(day_type) = 'dinsdag' and string(year) = '1970' and string(week_number) = '0'">
											<xsl:value-of select="'2'"/>
										</xsl:if>
										<xsl:if test="string(day_type) = 'woensdag' and string(year) = '1970' and string(week_number) = '0'">
											<xsl:value-of select="'3'"/>
										</xsl:if>
										<xsl:if test="string(day_type) = 'donderdag' and string(year) = '1970' and string(week_number) = '0'">
											<xsl:value-of select="'4'"/>
										</xsl:if>
										<xsl:if test="string(day_type) = 'vrijdag' and string(year) = '1970' and string(week_number) = '0'">
											<xsl:value-of select="'5'"/>
										</xsl:if>
										<xsl:if test="string(day_type) = 'zaterdag' and string(year) = '1970' and string(week_number) = '0'">
											<xsl:value-of select="'6'"/>
										</xsl:if>
										<xsl:if test="string(day_type) = 'zondag' and string(year) = '1970' and string(week_number) = '0'">
											<xsl:value-of select="'7'"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'1234567'"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="bad_opening_times_1">
							<xsl:if test="contains($check_opening_times_1,1) and
						contains($check_opening_times_1,2) and
						contains($check_opening_times_1,3) and
						contains($check_opening_times_1,4) and
						contains($check_opening_times_1,5) and
						contains($check_opening_times_1,6) and
						contains($check_opening_times_1,7)">
								<xsl:value-of select="'true'"/>
							</xsl:if>
						</xsl:variable>
						<!-- 	dont send events that have verplaatst (locatie gewijzigd) or verplaatst (tijdstip gewijzigd) in
							ed:event_date/event_date_instance/availability_type  -->
						<xsl:variable name="moved_event">
							<xsl:for-each select="ed:event_date/event_date_instance/availability_type">
								<xsl:if test="string(.) = 'verplaatst (locatie gewijzigd)' or string(.) = 'verplaatst (tijdstip gewijzigd'">
									<xsl:value-of select="'true'"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:variable>
						<!-- 	check that there is at least one organisation that is a location or an organisation. Plus opening Times. 
							Also check if the location has an address -->
						<xsl:if test="string(organisation) != '' and string(ot:opening_times) != '' and string($organisator_exists) = 'true' and
										string($location_address) = 'true' and string($bad_opening_times) = '' and string($bad_opening_times_1) = 'true' and string($moved_event) = ''">
							<event>
								<xsl:for-each select="md:availablefrom">
									<xsl:attribute name="availablefrom"><xsl:value-of select="."/></xsl:attribute>
								</xsl:for-each>
								<xsl:for-each select="md:availableto">
									<xsl:if test="substring(.,1,4) &lt; 2020">
										<xsl:attribute name="availableto"><xsl:value-of select="."/></xsl:attribute>
									</xsl:if>
								</xsl:for-each>
								<xsl:for-each select="md:objectid">
									<xsl:attribute name="cdbid"><xsl:value-of select="."/></xsl:attribute>
								</xsl:for-each>
								<xsl:if test="string(md:external_identifier) != ''">
									<xsl:attribute name="externalid"><xsl:value-of select="md:external_identifier"/></xsl:attribute>
								</xsl:if>
								<!-- add agefrom -->
								<xsl:call-template name="insertDoelgroep"/>
								<!-- it is in MapToCategorisartion -->
								<!-- check if we need de Vlieg hyperlink in media -->
								<xsl:variable name="vlieg">
									<xsl:for-each select="category">
										<xsl:for-each select="categorisation_instance[md:objectid = '2.2.1.0.0' or md:objectid = '2.2.2.0.0']">
											<xsl:value-of select="'true'"/>
										</xsl:for-each>
									</xsl:for-each>
								</xsl:variable>
								<!-- added-->
								<xsl:call-template name="insertCalendar"/>
								<!-- end added -->
								<xsl:variable name="contactinfo">
									<xsl:call-template name="insertContactinfo">
										<xsl:with-param name="contact" select="'true'"/>
									</xsl:call-template>
								</xsl:variable>
								<xsl:choose>
									<xsl:when test="string($contactinfo) != ''">
										<xsl:copy-of select="$contactinfo"/>
									</xsl:when>
									<xsl:otherwise>
										<!-- copy the information from the organisator or person. There can be only one.-->
										<xsl:for-each select="organisation">
											<xsl:for-each select="or:organisation">
												<xsl:if test="rel:relation_item/relation_item_instance/categorisation_label = 'organisator'">
													<xsl:for-each select="organisation_instance">
														<xsl:call-template name="insertContactinfo">
															<xsl:with-param name="contact" select="'true'"/>
														</xsl:call-template>
													</xsl:for-each>
												</xsl:if>
											</xsl:for-each>
										</xsl:for-each>
										<xsl:for-each select="person">
											<xsl:for-each select="pe:person">
												<xsl:if test="rel:relation_item/relation_item_instance/categorisation_label = 'organisator'">
													<xsl:for-each select="person_instance">
														<xsl:call-template name="insertContactinfo">
															<xsl:with-param name="contact" select="'true'"/>
														</xsl:call-template>
													</xsl:for-each>
												</xsl:if>
											</xsl:for-each>
										</xsl:for-each>
									</xsl:otherwise>
								</xsl:choose>
								<!-- added-->
								<eventcategories>
									<xsl:call-template name="insertCategorisation"/>
								</eventcategories>
								<!-- end added -->
								<eventdetails>
									<eventdetail>
										<!-- the first instance of eventdetail will always be nl as the label is always in Dutch -->
										<xsl:attribute name="lang"><xsl:value-of select="'nl'"/></xsl:attribute>
										<!-- calendersummary -->
										<xsl:call-template name="insertSummary"/>
										<xsl:for-each select="estimated_time">
											<estimatedtime>
												<xsl:value-of select="."/>
											</estimatedtime>
										</xsl:for-each>
										<!-- executors. These are persons or organisations that perform -->
										<!-- first check that at least one exists -->
										<xsl:variable name="executor_exists">
											<xsl:for-each select="organisation">
												<xsl:for-each select="or:organisation">
													<xsl:if test="rel:relation_item/relation_item_instance/categorisation_label != 'lokatie' and rel:relation_item/relation_item_instance/categorisation_label != 'organisator' and rel:relation_item/relation_item_instance/categorisation_label != 'reservator'">
														<xsl:value-of select="1"/>
													</xsl:if>
												</xsl:for-each>
											</xsl:for-each>
											<xsl:if test="string(person) != ''">
												<xsl:value-of select="1"/>
											</xsl:if>
										</xsl:variable>
										<xsl:if test="$executor_exists &gt;= 1">
											<performers>
												<xsl:for-each select="organisation">
													<xsl:for-each select="or:organisation">
														<xsl:if test="rel:relation_item/relation_item_instance/categorisation_label != 'lokatie' and rel:relation_item/relation_item_instance/categorisation_label != 'organisator' and rel:relation_item/relation_item_instance/categorisation_label != 'reservator'">
															<performer>
																<xsl:if test="string(rel:relation_item/relation_item_instance/relationdesc) != 'Uitvoerder' and string(rel:relation_item/relation_item_instance/relationdesc) != ''">
																	<role>
																		<xsl:value-of select="concat(translate(substring(rel:relation_item/relation_item_instance/relationdesc, 1, 1), $lowercase,
$uppercase), substring(rel:relation_item/relation_item_instance/relationdesc,2))"/>
																	</role>
																</xsl:if>
																<xsl:for-each select="organisation_instance">
																	<xsl:variable name="thema_onbepaald">
																		<xsl:for-each select="category/categorisation_instance">
																			<xsl:if test="string(label/dutch) = 'Thema onbepaald'">
																				<xsl:value-of select="'true'"/>
																			</xsl:if>
																		</xsl:for-each>
																	</xsl:variable>
																	<xsl:choose>
																		<!--<xsl:when test="string($actor_type) = 'reference' or string($thema_onbepaald) = 'true' or string(md:short_description/dutch) = 'NB'">-->
																		<xsl:when test="string($actor_type) = 'reference'">
																			<xsl:call-template name="insertActor_ref"/>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:call-template name="insertActor"/>
																		</xsl:otherwise>
																	</xsl:choose>
																</xsl:for-each>
															</performer>
														</xsl:if>
													</xsl:for-each>
												</xsl:for-each>
												<xsl:for-each select="person">
													<xsl:for-each select="pe:person">
														<performer>
															<xsl:if test="string(rel:relation_item/relation_item_instance/relationdesc) != 'Uitvoerder' and string(rel:relation_item/relation_item_instance/relationdesc) != ''">
																<role>
																	<xsl:value-of select="concat(translate(substring(rel:relation_item/relation_item_instance/relationdesc, 1, 1), $lowercase,
$uppercase), substring(rel:relation_item/relation_item_instance/relationdesc,2))"/>
																</role>
															</xsl:if>
															<!-- use the references as a default. Also if the person has category Thema onbepaald -->
															<xsl:for-each select="person_instance">
																<xsl:variable name="thema_onbepaald">
																	<xsl:for-each select="category/categorisation_instance">
																		<xsl:if test="string(label/dutch) = 'Thema onbepaald'">
																			<xsl:value-of select="'true'"/>
																		</xsl:if>
																	</xsl:for-each>
																</xsl:variable>
																<xsl:choose>
																	<!--<xsl:when test="string($actor_type) = 'reference' or string($thema_onbepaald) = 'true' or string(md:short_description/dutch) = 'NB'">-->
																	<xsl:when test="string($actor_type) = 'reference'">
																		<xsl:call-template name="insertActor_ref"/>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:call-template name="insertActor"/>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:for-each>
														</performer>
													</xsl:for-each>
												</xsl:for-each>
											</performers>
										</xsl:if>
										<!-- long description -->
										<!-- check what to do if a long description and a .txt file exists : is the following OK ?-->
										<!-- if .txt file is in media_instance and it exists in the file then use it -->
										<!-- if not and a value_plain_text exists then use that -->
										<!-- otherwise do nothing -->
										<!-- the media files are available in the iis system in  iis.ext.files -->
										<!-- <xsl:value-of select="xalan:nodeset($media_files)/0A8AF4EA-B7D0-2E48-0A6AE1B70C38B43A.txt"></xsl:value-of> 
									<xsl:value-of select="xalan:nodeset($media_files/0A8AF4EA-B7D0-2E48-0A6AE1B70C38B43A.txt)"></xsl:value-of>
									<xsl:value-of select="$media_files"></xsl:value-of>
									<xsl:value-of select="xalan:nodeset($media_files)/me:media/media_instance/file"></xsl:value-of>
-->
										<xsl:for-each select="me:media/media_instance[category/categorisation_instance/label/dutch='lange omschrijving']">
											<xsl:variable name="media_length" select="string-length(./file)"/>
											<xsl:choose>
												<xsl:when test="substring(./file,($media_length)-3,4) = '.txt'">
													<!-- there is a .txt file -->
													<xsl:if test="string(./value_plain_text/dutch) != 'kinderen toegelaten'">
														<!-- make sure we don't put price description here -->
														<xsl:if test="string(./category/categorisation_instance/label/dutch) != 'prijsomschrijvingen en kortingen'">
															<!-- xxxxx -->
															<!-- get the .txt file -->
															<xsl:variable name="text_file" select="./file"/>
															<!-- for test
														<xsl:variable name="full_text_file" select="concat('T:\XML\Erfgoed\exportBEXML_20070417_152358_part_1_of_7\',$text_file)"></xsl:variable>
														-->
															<!-- for iis 
														<xsl:variable name="full_text_file" select="concat($iis.ext.files,'/',$text_file)"></xsl:variable>
														-->
															<xsl:variable name="full_text_file" select="concat('T:\XML\hourly\exportBEXML_20080506_132745_part_0_of_1\',$text_file)"/>
															<!--
													<xsl:value-of select="$full_text_file"></xsl:value-of>
													<xsl:variable name="file" select="java:java.io.BufferedReader.new(java:java.io.FileReader.new($full_text_file))"/>
													<xsl:variable name="str" select="String"></xsl:variable>
													<xsl:if test="extfun:get_text_file($full_text_file)"/>-->
															<!-- check if the file exists first -->
															<xsl:variable name="file" select="java:java.io.File.new($full_text_file)"/>
															<xsl:if test="position() = 1">
																<xsl:choose>
																	<xsl:when test="(file:exists($file))">
																		<longdescription>
																			<xsl:value-of select="extfun:get_text_file($full_text_file)"/>
																		</longdescription>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:if test="string(./value_plain_text) != ''">
																			<xsl:if test="string(./value_plain_text/dutch) != 'kinderen toegelaten'">
																				<xsl:if test="string(./categorisation_instance/label/dutch) != 'prijsomschrijvingen en kortingen'">
																					<longdescription>
																						<xsl:value-of select="./value_plain_text/dutch"/>
																					</longdescription>
																				</xsl:if>
																			</xsl:if>
																		</xsl:if>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:if>
														</xsl:if>
													</xsl:if>
												</xsl:when>
												<xsl:otherwise>
													<!-- do nothing -->
												</xsl:otherwise>
											</xsl:choose>
										</xsl:for-each>
										<!-- media -->
										<!-- don't include text files -->
										<xsl:variable name="media_exists">
											<xsl:for-each select="me:media">
												<xsl:for-each select="media_instance">
													<!-- <xsl:if test="string(file) !='' and string(media_type) != 'txt' and string(me:media/media_instance/copyright) != 'NB'"> -->
													<xsl:if test="string(file) !='' and string(media_type) != 'txt'">
														<xsl:value-of select="'true'"/>
													</xsl:if>
												</xsl:for-each>
											</xsl:for-each>
										</xsl:variable>
										<!-- check if we need to include the Vlieg hyperlink -->
										<xsl:if test="substring($media_exists,1,4) = 'true' or substring($vlieg,1,4) = 'true'">
											<media>
												<xsl:if test="substring($vlieg,1,4) = 'true'">
													<file>
														<copyright>CultuurNet Vlaanderen</copyright>
														<filename>vlieg.jpg</filename>
														<filetype>jpeg</filetype>
														<hlink>http://www.cultuurdatabank.com/Vlieg/vlieg+website.jpg</hlink>
														<title>Met het pictogram Vlieg wordt het culturele aanbod dat geschikt is voor kinderen tot 12 jaar gemarkeerd.</title>
													</file>
												</xsl:if>
												<xsl:for-each select="me:media">
													<xsl:for-each select="media_instance">
														<!-- <xsl:if test="string(file) !='' and string(media_type) != 'txt' and string(me:media/media_instance/copyright) != 'NB'"> -->
														<xsl:if test="string(file) !='' and string(media_type) != 'txt'">
															<file>
																<!-- not needed 
															<xsl:for-each select="md:objectid">
																<xsl:attribute name="cdbid"><xsl:value-of select="."/></xsl:attribute>
															</xsl:for-each>
-->
																<copyright>
																	<xsl:choose>
																		<xsl:when test="string-length(copyright) = 1">
																			<xsl:value-of select="'Beschrijving niet beschikbaar'"/>
																		</xsl:when>
																		<xsl:when test="string(copyright) != ''">
																			<xsl:value-of select="copyright"/>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:value-of select="'Beschrijving niet beschikbaar'"/>
																		</xsl:otherwise>
																	</xsl:choose>
																</copyright>
																<filename>
																	<xsl:value-of select="file"/>
																</filename>
																<xsl:for-each select="media_type">
																	<filetype>
																		<xsl:value-of select="."/>
																	</filetype>
																</xsl:for-each>
																<hlink>
																	<xsl:value-of select="file"/>
																</hlink>
																<xsl:variable name="mediatype">
																	<xsl:value-of select="category/categorisation_instance/label/dutch"/>
																</xsl:variable>
																<mediatype>
																	<xsl:choose>
																		<xsl:when test="$mediatype='foto'">
																			<xsl:value-of select="'photo'"/>
																		</xsl:when>
																		<xsl:when test="$mediatype='affiche'">
																			<xsl:value-of select="'poster'"/>
																		</xsl:when>
																		<xsl:when test="$mediatype='andere'">
																			<xsl:value-of select="'other'"/>
																		</xsl:when>
																		<xsl:when test="$mediatype='audio'">
																			<xsl:value-of select="'audio'"/>
																		</xsl:when>
																		<xsl:when test="$mediatype='brochure'">
																			<xsl:value-of select="'brochure'"/>
																		</xsl:when>
																		<xsl:when test="$mediatype='logo'">
																			<xsl:value-of select="'logo'"/>
																		</xsl:when>
																		<xsl:when test="$mediatype='video'">
																			<xsl:value-of select="'video'"/>
																		</xsl:when>
																		<xsl:when test="$mediatype='toegangsvoorwaarden'">
																			<xsl:value-of select="'roadmap'"/>
																		</xsl:when>
																		<xsl:when test="$mediatype='tekst'">
																			<xsl:value-of select="'text'"/>
																		</xsl:when>
																		<xsl:when test="$mediatype='lange omschrijving'">
																			<xsl:value-of select="'text'"/>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:value-of select="'other'"/>
																		</xsl:otherwise>
																	</xsl:choose>
																</mediatype>
																<xsl:for-each select="md:label">
																	<xsl:for-each select="dutch">
																		<title>
																			<xsl:value-of select="."/>
																		</title>
																	</xsl:for-each>
																</xsl:for-each>
															</file>
														</xsl:if>
													</xsl:for-each>
												</xsl:for-each>
											</media>
										</xsl:if>
										<xsl:for-each select="price_standard">
											<xsl:for-each select="price_instance">
												<!-- BAD test -->
												<xsl:if test="string(price_value) != 'EUR'">
													<!-- added-->
													<xsl:if test="string(price_value) != '' or string(free_of_charge_type) = 'gratis'">
														<!-- end added-->
														<xsl:variable name="free">
															<xsl:if test="string(free_of_charge_type) = 'gratis' or contains(price_value,'grat') or contains(price_value,'GRAT')">
																<xsl:value-of select="'true'"/>
															</xsl:if>
														</xsl:variable>
														<price>
															<xsl:choose>
																<xsl:when test="$free = 'true'">
																	<pricevalue>
																		<xsl:value-of select="'0'"/>
																	</pricevalue>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:for-each select="price_value">
																		<pricevalue>
																			<xsl:variable name="price">
																				<xsl:choose>
																					<xsl:when test="contains(.,'?')">
																						<xsl:value-of select="substring-before(.,'?')"/>
																					</xsl:when>
																					<xsl:when test="contains(.,'-')">
																						<xsl:value-of select="substring-before(.,'-')"/>
																					</xsl:when>
																					<xsl:when test="contains(.,'&#8211;')">
																						<xsl:value-of select="substring-before(.,'&#8211;')"/>
																					</xsl:when>
																					<xsl:when test="contains(.,'.')">
																						<xsl:value-of select="substring-after(.,'.')"/>
																					</xsl:when>
																					<xsl:otherwise>
																						<xsl:value-of select="."/>
																					</xsl:otherwise>
																				</xsl:choose>
																			</xsl:variable>
																			<!-- remove spurious characters and check there is something left-->
																			<xsl:variable name="price_number">
																				<xsl:value-of select="translate(translate($price,',','.'),'EUROeuro&#226;&#128;&#147;&#8211;_# ','')"/>
																			</xsl:variable>
																			<xsl:choose>
																				<xsl:when test="string($price_number) != '' and string(number($price_number)) != 'NaN'">
																					<xsl:value-of select="$price_number"/>
																				</xsl:when>
																				<xsl:otherwise>
																					<xsl:value-of select="'0'"/>
																				</xsl:otherwise>
																			</xsl:choose>
																		</pricevalue>
																	</xsl:for-each>
																</xsl:otherwise>
															</xsl:choose>
															<!-- the price description can be in a media item at the level of the price or  event		-->
															<!-- with category prijsomschrijvingen en kortingen														-->
															<!-- we can only have one so check each in turn 															-->
															<xsl:choose>
																<xsl:when test="string(me:media/media_instance/value_plain_text/dutch) != 'NB' and
															string(me:media/media_instance/value_plain_text/dutch) != ''">
																	<pricedescription>
																		<xsl:value-of select="me:media/media_instance/value_plain_text/dutch"/>
																	</pricedescription>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:for-each select="../../me:media/media_instance">
																		<xsl:if test="string(category/categorisation_instance/label/dutch) = 'prijsomschrijvingen en kortingen'">
																			<pricedescription>
																				<xsl:value-of select="value_plain_text/dutch"/>
																			</pricedescription>
																		</xsl:if>
																	</xsl:for-each>
																</xsl:otherwise>
															</xsl:choose>
														</price>
													</xsl:if>
												</xsl:if>
											</xsl:for-each>
										</xsl:for-each>
										<xsl:for-each select="md:short_description">
											<xsl:for-each select="dutch">
												<shortdescription>
													<xsl:value-of select="."/>
												</shortdescription>
											</xsl:for-each>
										</xsl:for-each>
										<xsl:for-each select="md:label">
											<xsl:for-each select="dutch">
												<title>
													<xsl:value-of select="."/>
												</title>
											</xsl:for-each>
										</xsl:for-each>
									</eventdetail>
									<!-- a second eventdetails is needed if there are multilanguage fields 				-->
									<!-- there can be more than 1 																			-->
									<!-- first take all multilanguage labels and also check if a multilanguage short 	-->
									<!-- description exists with the same language													-->
									<xsl:variable name="dutch_label" select="md:label/dutch"/>
									<xsl:variable name="label_multilanguage">
										<xsl:for-each select="md:label">
											<xsl:for-each select="multilanguage">
												<xsl:variable name="cdb_language" select="language"/>
												<xsl:variable name="lab_language">
													<xsl:if test="string(language) = 'Frans' or string(language) = 'fr'">
														<xsl:value-of select="'fr'"/>
													</xsl:if>
													<xsl:if test="string(language) = 'Nederlands'">
														<xsl:value-of select="'nl'"/>
													</xsl:if>
													<xsl:if test="string(language) = 'Engels'">
														<xsl:value-of select="'en'"/>
													</xsl:if>
													<xsl:if test="string(language) = 'Duits'">
														<xsl:value-of select="'de'"/>
													</xsl:if>
												</xsl:variable>
												<xsl:if test="string($lab_language) != ''">
													<eventdetail>
														<xsl:attribute name="lang"><xsl:value-of select="$lab_language"/></xsl:attribute>
														<xsl:choose>
															<xsl:when test="string(../../md:short_description/multilanguage[language=$cdb_language]) != ''">
																<shortdescription>
																	<xsl:choose>
																		<xsl:when test="string(../../md:short_description/multilanguage[language=$cdb_language]/description) = ''">
																			<xsl:value-of select="'NB'"/>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:value-of select="../../md:short_description/multilanguage[language=$cdb_language]/description"/>
																		</xsl:otherwise>
																	</xsl:choose>
																</shortdescription>
															</xsl:when>
															<xsl:otherwise>
																<shortdescription>
																	<xsl:value-of select="'NB'"/>
																</shortdescription>
															</xsl:otherwise>
														</xsl:choose>
														<title>
															<xsl:value-of select="name"/>
														</title>
													</eventdetail>
												</xsl:if>
											</xsl:for-each>
										</xsl:for-each>
									</xsl:variable>
									<!-- if $label_multilanguage is empty then there were no multilanguage labels so take all the multilanguage 	-->
									<!--short descriptions 																																	-->
									<xsl:variable name="sd_multilanguage">
										<xsl:if test="string($label_multilanguage) = ''">
											<xsl:for-each select="md:short_description/multilanguage">
												<xsl:variable name="sd_language">
													<xsl:if test="string(language) = 'Frans' or string(language) = 'fr'">
														<xsl:value-of select="'fr'"/>
													</xsl:if>
													<xsl:if test="string(language) = 'Nederlands'">
														<xsl:value-of select="'nl'"/>
													</xsl:if>
													<xsl:if test="string(language) = 'Engels'">
														<xsl:value-of select="'en'"/>
													</xsl:if>
													<xsl:if test="string(language) = 'Duits'">
														<xsl:value-of select="'de'"/>
													</xsl:if>
												</xsl:variable>
												<xsl:if test="string($sd_language) != ''">
													<eventdetail>
														<xsl:attribute name="lang"><xsl:value-of select="$sd_language"/></xsl:attribute>
														<shortdescription>
															<xsl:value-of select="description"/>
														</shortdescription>
														<title>
															<xsl:value-of select="$dutch_label"/>
														</title>
													</eventdetail>
												</xsl:if>
											</xsl:for-each>
										</xsl:if>
									</xsl:variable>
									<!-- and finally the case where a short description exists in a language that is not present in a label 			-->
									<!-- this will only be needed if label_multilanguage contains some info, otherwise all the short_descriptions 	-->
									<!-- will have been put in sd_multilanguage																										-->
									<xsl:variable name="new_multilanguage">
										<xsl:if test="string($label_multilanguage) != ''">
											<xsl:for-each select="md:short_description/multilanguage">
												<xsl:variable name="sd_language">
													<xsl:if test="string(language) = 'Frans' or string(language) = 'fr'">
														<xsl:value-of select="'fr'"/>
													</xsl:if>
													<xsl:if test="string(language) = 'Nederlands'">
														<xsl:value-of select="'nl'"/>
													</xsl:if>
													<xsl:if test="string(language) = 'Engels'">
														<xsl:value-of select="'en'"/>
													</xsl:if>
													<xsl:if test="string(language) = 'Duits'">
														<xsl:value-of select="'de'"/>
													</xsl:if>
												</xsl:variable>
												<xsl:variable name="match">
													<xsl:for-each select="../../md:label/multilanguage">
														<xsl:variable name="lab_language">
															<xsl:if test="string(language) = 'Frans' or string(language) = 'fr'">
																<xsl:value-of select="'fr'"/>
															</xsl:if>
															<xsl:if test="string(language) = 'Nederlands'">
																<xsl:value-of select="'nl'"/>
															</xsl:if>
															<xsl:if test="string(language) = 'Engels'">
																<xsl:value-of select="'en'"/>
															</xsl:if>
															<xsl:if test="string(language) = 'Duits'">
																<xsl:value-of select="'de'"/>
															</xsl:if>
														</xsl:variable>
														<xsl:choose>
															<xsl:when test="$lab_language = $sd_language">
																<xsl:value-of select="'true'"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="'false'"/>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:for-each>
												</xsl:variable>
												<xsl:choose>
													<xsl:when test="contains($match,'true')">
														<!-- do nothing -->
													</xsl:when>
													<xsl:otherwise>
														<xsl:if test="string($sd_language) != ''">
															<eventdetail>
																<xsl:attribute name="lang"><xsl:value-of select="$sd_language"/></xsl:attribute>
																<shortdescription>
																	<xsl:value-of select="description"/>
																</shortdescription>
																<title>
																	<xsl:value-of select="$dutch_label"/>
																</title>
															</eventdetail>
														</xsl:if>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:for-each>
										</xsl:if>
									</xsl:variable>
									<xsl:copy-of select="$label_multilanguage"/>
									<xsl:copy-of select="$sd_multilanguage"/>
									<xsl:copy-of select="$new_multilanguage"/>
								</eventdetails>
								<!-- event relations. this is where references to a production or koepelevent go -->
								<!-- old method. No productions or koepelevents are exported from the CDB

							<xsl:if test="../../../event_cluster_type='productie' or string(is_koepel) = '1'">
								<eventrelations>
									<xsl:if test="../../../event_cluster_type='productie'">
										<relatedproduction>
											<xsl:attribute name="cdbid"><xsl:value-of select="../../../md:objectid"/></xsl:attribute>
											<xsl:if test="../../../md:external_identifier != '' and ../../../md:external_identifier != 'onbepaald'">
												<xsl:attribute name="externalid"><xsl:value-of select="../../../md:external_identifier"/></xsl:attribute>
											</xsl:if>
											<xsl:value-of select="md:label/dutch"/>
										</relatedproduction>
									</xsl:if>
									<xsl:if test="string(is_koepel) = '1'">
										<parentevent>
											<xsl:attribute name="cdbid"><xsl:value-of select="md:objectid"/></xsl:attribute>
											<xsl:if test="md:external_identifier != '' and md:external_identifier != 'onbepaald'">
												<xsl:attribute name="externalid"><xsl:value-of select="md:external_identifier"/></xsl:attribute>
											</xsl:if>
											<xsl:value-of select="md:label/dutch"/>
										</parentevent>
									</xsl:if>
								</eventrelations>
							</xsl:if>
							-->
								<!-- new method :not used yet.-->
								<xsl:if test="string(koepelid) !='' or string(productieid) != ''">
									<eventrelations>
										<xsl:if test="string(productieid) != ''">
											<relatedproduction>
												<!--
											<xsl:attribute name="cdbid"><xsl:value-of select="../../../md:objectid"/></xsl:attribute>
											<xsl:if test="../../../md:external_identifier != '' and ../../../md:external_identifier != 'onbepaald'">
												<xsl:attribute name="externalid"><xsl:value-of select="../../../md:external_identifier"/></xsl:attribute>
											</xsl:if>
											-->
												<xsl:value-of select="productieid"/>
											</relatedproduction>
										</xsl:if>
										<xsl:if test="string(koepelid) !=''">
											<parentevent>
												<!--
											<xsl:attribute name="cdbid"><xsl:value-of select="md:objectid"/></xsl:attribute>
											<xsl:if test="md:external_identifier != '' and md:external_identifier != 'onbepaald'">
												<xsl:attribute name="externalid"><xsl:value-of select="md:external_identifier"/></xsl:attribute>
											</xsl:if>
											-->
												<xsl:value-of select="koepelid"/>
											</parentevent>
										</xsl:if>
									</eventrelations>
								</xsl:if>
								<xsl:if test="string(md:keywords) != ''">
									<keywords>
										<xsl:value-of select="md:keywords"/>
									</keywords>
								</xsl:if>
								<!-- added -->
								<languages>
									<xsl:for-each select="lc:language_comp">
										<xsl:for-each select="language_comp_instance">
											<xsl:for-each select="iso_code">
												<language>
													<xsl:value-of select="."/>
												</language>
											</xsl:for-each>
										</xsl:for-each>
									</xsl:for-each>
								</languages>
								<!--end added -->
								<xsl:variable name="lokatie_exists">
									<xsl:for-each select="organisation">
										<xsl:for-each select="or:organisation">
											<xsl:if test="rel:relation_item/relation_item_instance/categorisation_label = 'lokatie'">
												<xsl:value-of select="true()"/>
											</xsl:if>
										</xsl:for-each>
									</xsl:for-each>
								</xsl:variable>
								<xsl:choose>
									<xsl:when test="substring($lokatie_exists,1,4) = 'true'">
										<xsl:for-each select="organisation">
											<xsl:for-each select="or:organisation[rel:relation_item/relation_item_instance/categorisation_label = 'lokatie']">
												<!-- <xsl:if test="rel:relation_item/relation_item_instance/categorisation_label = 'lokatie' and position() = 1">-->
												<xsl:if test="position() = 1">
													<location>
														<xsl:for-each select="organisation_instance">
															<xsl:variable name="thema_onbepaald">
																<xsl:for-each select="category/categorisation_instance">
																	<xsl:if test="string(label/dutch) = 'Thema onbepaald'">
																		<xsl:value-of select="'true'"/>
																	</xsl:if>
																</xsl:for-each>
															</xsl:variable>
															<xsl:choose>
																<!--<xsl:when test="string($actor_type) = 'reference' or string($thema_onbepaald) = 'true' or string(md:short_description/dutch) = 'NB'">-->
																<xsl:when test="string($actor_type) = 'reference'">
																	<!-- <locationpart> -->
																	<xsl:call-template name="insertActor_address_ref"/>
																	<xsl:call-template name="insertActor_ref"/>
																	<!-- </locationpart> -->
																</xsl:when>
																<xsl:otherwise>
																	<xsl:call-template name="insertActor_address_ref"/>
																	<xsl:call-template name="insertActor"/>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:for-each>
													</location>
												</xsl:if>
											</xsl:for-each>
										</xsl:for-each>
									</xsl:when>
									<xsl:otherwise>
										<xsl:for-each select="organisation">
											<xsl:for-each select="or:organisation">
												<xsl:if test="rel:relation_item/relation_item_instance/categorisation_label = 'organisator'">
													<location>
														<xsl:for-each select="organisation_instance">
															<xsl:variable name="thema_onbepaald">
																<xsl:for-each select="category/categorisation_instance">
																	<xsl:if test="string(label/dutch) = 'Thema onbepaald'">
																		<xsl:value-of select="'true'"/>
																	</xsl:if>
																</xsl:for-each>
															</xsl:variable>
															<xsl:choose>
																<!--<xsl:when test="string($actor_type) = 'reference' or string($thema_onbepaald) = 'true' or string(md:short_description/dutch) = 'NB'">-->
																<xsl:when test="string($actor_type) = 'reference'">
																	<xsl:call-template name="insertActor_ref"/>
																	<!-- <xsl:call-template name="insertActor"/> -->
																</xsl:when>
																<xsl:otherwise>
																	<xsl:call-template name="insertActor"/>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:for-each>
													</location>
												</xsl:if>
											</xsl:for-each>
										</xsl:for-each>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:variable name="organisator_exists">
									<xsl:for-each select="organisation">
										<xsl:for-each select="or:organisation">
											<xsl:if test="rel:relation_item/relation_item_instance/categorisation_label = 'organisator'">
												<xsl:value-of select="true()"/>
											</xsl:if>
										</xsl:for-each>
									</xsl:for-each>
									<xsl:for-each select="person">
										<xsl:for-each select="pe:person">
											<xsl:if test="rel:relation_item/relation_item_instance/categorisation_label = 'organisator'">
												<xsl:value-of select="true()"/>
											</xsl:if>
										</xsl:for-each>
									</xsl:for-each>
								</xsl:variable>
								<xsl:choose>
									<xsl:when test="string($organisator_exists) = 'true'">
										<xsl:for-each select="organisation">
											<xsl:for-each select="or:organisation">
												<xsl:if test="rel:relation_item/relation_item_instance/categorisation_label = 'organisator'">
													<organiser>
														<xsl:for-each select="organisation_instance">
															<xsl:variable name="thema_onbepaald">
																<xsl:for-each select="category/categorisation_instance">
																	<xsl:if test="string(label/dutch) = 'Thema onbepaald'">
																		<xsl:value-of select="'true'"/>
																	</xsl:if>
																</xsl:for-each>
															</xsl:variable>
															<xsl:choose>
																<!--<xsl:when test="string($actor_type) = 'reference' or string($thema_onbepaald) = 'true' or string(md:short_description/dutch) = 'NB'">-->
																<xsl:when test="string($actor_type) = 'reference'">
																	<xsl:call-template name="insertActor_ref"/>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:call-template name="insertActor"/>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:for-each>
													</organiser>
												</xsl:if>
											</xsl:for-each>
										</xsl:for-each>
										<xsl:for-each select="person">
											<xsl:for-each select="pe:person">
												<xsl:if test="rel:relation_item/relation_item_instance/categorisation_label = 'organisator'">
													<organiser>
														<xsl:for-each select="person_instance">
															<xsl:variable name="thema_onbepaald">
																<xsl:for-each select="category/categorisation_instance">
																	<xsl:if test="string(label/dutch) = 'Thema onbepaald'">
																		<xsl:value-of select="'true'"/>
																	</xsl:if>
																</xsl:for-each>
															</xsl:variable>
															<xsl:choose>
																<xsl:when test="string($actor_type) = 'reference' or string($thema_onbepaald) = 'true' or string(md:short_description/dutch) = 'NB'">
																	<xsl:call-template name="insertActor_ref"/>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:call-template name="insertActor"/>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:for-each>
													</organiser>
												</xsl:if>
											</xsl:for-each>
										</xsl:for-each>
									</xsl:when>
									<xsl:otherwise>
										<xsl:for-each select="organisation">
											<xsl:for-each select="or:organisation">
												<xsl:if test="rel:relation_item/relation_item_instance/categorisation_label = 'lokatie'">
													<organiser>
														<xsl:for-each select="organisation_instance">
															<xsl:variable name="thema_onbepaald">
																<xsl:for-each select="category/categorisation_instance">
																	<xsl:if test="string(label/dutch) = 'Thema onbepaald'">
																		<xsl:value-of select="'true'"/>
																	</xsl:if>
																</xsl:for-each>
															</xsl:variable>
															<xsl:choose>
																<!--<xsl:when test="string($actor_type) = 'reference' or string($thema_onbepaald) = 'true' or string(md:short_description/dutch) = 'NB'">-->
																<xsl:when test="string($actor_type) = 'reference'">
																	<xsl:call-template name="insertActor_ref"/>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:call-template name="insertActor"/>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:for-each>
													</organiser>
												</xsl:if>
											</xsl:for-each>
										</xsl:for-each>
									</xsl:otherwise>
								</xsl:choose>
								<!-- only one reservations per event -->
								<xsl:for-each select="organisation">
									<xsl:for-each select="or:organisation[rel:relation_item/relation_item_instance/categorisation_label = 'reservator']">
										<xsl:if test="position() = 1">
											<reservations>
												<xsl:for-each select="organisation_instance">
													<xsl:variable name="thema_onbepaald">
														<xsl:for-each select="category/categorisation_instance">
															<xsl:if test="string(label/dutch) = 'Thema onbepaald'">
																<xsl:value-of select="'true'"/>
															</xsl:if>
														</xsl:for-each>
													</xsl:variable>
													<xsl:choose>
														<!--<xsl:when test="string($actor_type) = 'reference' or string($thema_onbepaald) = 'true' or string(md:short_description/dutch) = 'NB'">-->
														<xsl:when test="string($actor_type) = 'reference'">
															<xsl:call-template name="insertActor_ref"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:call-template name="insertActor"/>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:for-each>
											</reservations>
										</xsl:if>
									</xsl:for-each>
								</xsl:for-each>
							</event>
						</xsl:if>
					</xsl:for-each>
					<!--</xsl:for-each>-->
				</events>
			</xsl:if>
			<!-- add the producuions -->
			<xsl:call-template name="insertProductions"/>
			<!-- deletes -->
			<xsl:if test="string(delete) != ''">
				<deletes>
					<xsl:for-each select="delete">
						<xsl:for-each select="delete_event_cluster">
							<delete>
								<xsl:attribute name="objecttype"><xsl:value-of select="'event'"/></xsl:attribute>
								<xsl:attribute name="cdbid"><xsl:value-of select="objectid"/></xsl:attribute>
							</delete>
						</xsl:for-each>
						<xsl:for-each select="delete_person">
							<delete>
								<xsl:attribute name="objecttype"><xsl:value-of select="'actor'"/></xsl:attribute>
								<xsl:attribute name="cdbid"><xsl:value-of select="objectid"/></xsl:attribute>
							</delete>
						</xsl:for-each>
						<xsl:for-each select="delete_organisation">
							<delete>
								<xsl:attribute name="objecttype"><xsl:value-of select="'actor'"/></xsl:attribute>
								<xsl:attribute name="cdbid"><xsl:value-of select="objectid"/></xsl:attribute>
							</delete>
						</xsl:for-each>
						<xsl:for-each select="delete_link">
							<delete>
								<xsl:attribute name="objecttype"><xsl:value-of select="'link'"/></xsl:attribute>
								<xsl:attribute name="cdbid"><xsl:value-of select="objectid"/></xsl:attribute>
							</delete>
						</xsl:for-each>
					</xsl:for-each>
				</deletes>
			</xsl:if>
		</cdbxml>
	</xsl:template>
</xsl:stylesheet>
