<?xml version="1.0" encoding="UTF-8"?>
<!--
Transform CDB XSD 3.1 Final to CDB XSD 3.2 Final
LAst updated on 10/03/29017 to check javascript functions on laptop : OK
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:n1="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL" xmlns:ns3="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="n1 xs ns3 xalan  extfun" xmlns:xalan="http://xml.apache.org/xalan" xmlns:extfun="external_functions">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
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
// java.lang.System.out.println(emailSt);
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
// java.lang.System.out.println("1");
return false;
}
var user=matchArray[1];
var domain=matchArray[2];

// Start by checking that only basic ASCII characters are in the strings (0-127).

for (i=0; i<user.length; i++) {
if (user.charCodeAt(i)>127) {
// xx alert("Ths username contains invalid characters.");
// java.lang.System.out.println("2");
return false;
 }
 }
for (i=0; i<domain.length; i++) {
if (domain.charCodeAt(i)>127) {
// xx alert("Ths domain name contains invalid characters.");
// java.lang.System.out.println("3");
return false;
 }
}

// See if "user" is valid 

if (user.match(userPat)==null) {

// user is not valid

// xx alert("The username doesn't seem to be valid.");
// java.lang.System.out.println("4");
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
// java.lang.System.out.println("5");
return false;
   }
}
// java.lang.System.out.println("true1");
 return true;
 }

// Domain is symbolic name.  Check if it's valid.

var atomPat=new RegExp("^" + atom + "$");

var domArr=domain.split(".");
var len=domArr.length;

for (i=0;i<len;i++) {

if (domArr[i].search(atomPat)==-1) {
// xx alert("The domain name does not seem to be valid.");
// java.lang.System.out.println("6");
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
// java.lang.System.out.println("7");
return false;
 }

// Make sure there's a host name preceding the domain.

if (len<2) {
// xx alert("This address is missing a hostname!");
// java.lang.System.out.println("8");
return false;
}

// If we've gotten this far, everything's valid!
// java.lang.System.out.println("true2");
return true;
}
	]]></xalan:script>
	</xalan:component>
	<xsl:param name="categories" select="'Category_Mapping_02.xml'"/>
	<xsl:param name="backwardmapping" select="'backwardmapping_01.xml'"/>
	<xsl:template match="n1:cdbxml">
		<cdbxml>
			<xsl:for-each select="n1:events">
				<!-- <xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL C:/XML/XSD/CDB_XSD_3_2/CDB_XSD_3_2.xsd</xsl:attribute> -->
				<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.2/FINAL/CdbXSD.xsd</xsl:attribute>
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="node()"/>
			</xsl:for-each>
			<!-- removed as deletes from IIS3 have no cdbid 
			<xsl:for-each select="n1:deletes">
				<xsl:copy-of select="."/>
			</xsl:for-each>
			-->
		</cdbxml>
	</xsl:template>
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
	<xsl:template match="n1:metadata"/>
	<xsl:template match="n1:reservations"/>
	<xsl:template match="n1:mediatype">
		<xsl:choose>
			<xsl:when test=". = 'other'"/>
			<xsl:when test=". = 'poster'"/>
			<xsl:when test=". = 'logo'"/>
			<xsl:otherwise>
				<xsl:copy-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="n1:longdescription">
		<!-- use this so we don't copy unwanted xsi:type and namespace from the xml from old xml-->
		<longdescription>
			<xsl:value-of select="."/>
		</longdescription>
	</xsl:template>
	<xsl:template match="n1:plaintext">
		<!-- use this so we don't copy unwanted xsi:type and namespace from the xml from old xml-->
		<plaintext>
			<xsl:value-of select="."/>
		</plaintext>
	</xsl:template>
	<xsl:template match="n1:categories">
		<xsl:choose>
			<!-- only adapt the categories for the 2.3 and 3.0 imports -->
			<xsl:when test="string(../@createdby) = 'faro' or string(../@createdby) = '2mpactimport' or string(../@createdby) = 'end2endimport' or string(../@createdby) = 'anaxisimport'
			or string(../@createdby) = 'importbrugge' or string(../@createdby) = 'cipalimport' or string(../@createdby) = 'formaatimport' or string(../@createdby) = 'lithiumimport' or string(../@createdby) = 'ampleximport'
			or string(../@createdby) = 'mverdoodt' or string(../@createdby) = 'desingelimportatoren' or string(../@createdby) = '' or 
			(string(../@createdby) = 'lcpimport' and (substring(../@externalid,1,6) ='Aalter')) or
			(string(../@createdby) = 'lcpimport' and (substring(../@externalid,1,5) ='Balen')) or
			(string(../@createdby) = 'lcpimport' and (substring(../@externalid,1,7) ='Beersel')) or
			(string(../@createdby) = 'lcpimport' and (substring(../@externalid,1,9) ='Diksmuide')) or
			(string(../@createdby) = 'lcpimport' and (substring(../@externalid,1,6) ='Edegem')) or
			(string(../@createdby) = 'lcpimport' and (substring(../@externalid,1,7) ='Evergem')) or
			(string(../@createdby) = 'lcpimport' and (substring(../@externalid,1,4) ='Geel')) or
			(string(../@createdby) = 'lcpimport' and (substring(../@externalid,1,8) ='Hoeilart')) or
			(string(../@createdby) = 'lcpimport' and (substring(../@externalid,1,7) ='Kontich')) or
			(string(../@createdby) = 'lcpimport' and (substring(../@externalid,1,8) ='Oostende')) or
			(string(../@createdby) = 'lcpimport' and (substring(../@externalid,1,8) ='Oostkamp')) or
			(string(../@createdby) = 'lcpimport' and (substring(../@externalid,1,5) ='Reite')) or
			(string(../@createdby) = 'lcpimport' and (substring(../@externalid,1,5) ='Tielt')) or
			(string(../@createdby) = 'lcpimport' and (substring(../@externalid,1,9) ='Vosselaar')) or
			(string(../@createdby) = 'lcpimport' and (substring(../@externalid,1,6) ='Wervik')) or
			(string(../@createdby) = 'lcpimport' and (substring(../@externalid,1,9) ='Vosselaar')) or
			(string(../@createdby) = 'encimaimport' and (substring(../@externalid,1,9) ='CC Beringen')) or
			(string(../@createdby) = 'encimaimport' and (substring(../@externalid,1,9) ='CC Brugge')) or
			(string(../@createdby) = 'encimaimport'  and (substring(../@externalid,1,9) ='CC Despil')) or
			(string(../@createdby) = 'encimaimport'  and (substring(../@externalid,1,7) ='CC Nova')) or
			(string(../@createdby) = 'encimaimport' and (substring(../@externalid,1,7) ='De Oude')) or
			(string(../@createdby) = 'encimaimport'  and (substring(../@externalid,1,10) ='Toneelhuis')) or
			(string(../@createdby) = 'syximport'  and (substring(../@externalid,1,10) ='cckoksijde')) or
			(string(../@createdby) = 'syximport'  and (substring(../@externalid,1,6) ='Gildhof')) or
			(string(../@createdby) = 'syximport'  and (substring(../@externalid,1,9) ='Meulebeke'))">
				<categories>
					<xsl:for-each select="n1:category">
						<category>
							<xsl:variable name="old_id">
								<xsl:value-of select="@catid"/>
							</xsl:variable>
							<xsl:variable name="old_cat">
								<xsl:value-of select="."/>
							</xsl:variable>
							<xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
							<!--
							<xsl:attribute name="catid"><xsl:value-of select="document($categories)/Import/Row[@Oud_Id=$old_id]/@Nieuw_Id"/></xsl:attribute>
							<xsl:value-of select="document($categories)/Import/Row[@Oud_Id=$old_id]/@Nieuw_cat"/>  -->
							<xsl:choose>
								<xsl:when test="string(document($backwardmapping)/Import/Row[Oude_CatID=$old_id]/Nieuwe_CatID) !=''">
									<xsl:attribute name="catid"><xsl:value-of select="document($backwardmapping)/Import/Row[Oude_CatID=$old_id]/Nieuwe_CatID"/></xsl:attribute>
									<xsl:value-of select="document($backwardmapping)/Import/Row[Oude_CatID=$old_id]/Nieuwe_Categorie"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="catid"><xsl:value-of select="$old_id"/></xsl:attribute>
									<xsl:value-of select="$old_cat"/>
								</xsl:otherwise>
							</xsl:choose>
						</category>
					</xsl:for-each>
				</categories>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="n1:location">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
		<!-- an empty organiser sometimes has length 2 -->
		<xsl:if test="string(../n1:organiser) = '' or string-length(../n1:organiser) = 2">
			<organiser>
				<label>
					<xsl:choose>
						<xsl:when test="string(n1:label) != ''">
							<xsl:value-of select="n1:label"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="n1:actor/n1:actordetails/n1:actordetail/n1:title"/>
						</xsl:otherwise>
					</xsl:choose>
				</label>
			</organiser>
		</xsl:if>
	</xsl:template>
	<xsl:template match="n1:organiser">
		<xsl:if test="string(.) != '' and string-length(.) != 2">
			<xsl:copy>
				<xsl:apply-templates select="@* | node()"/>
			</xsl:copy>
		</xsl:if>
	</xsl:template>
	<xsl:template match="n1:filetype">
		<xsl:choose>
			<!-- only adapt the filetype for the 2.3 and 3.0 imports -->
			<xsl:when test="string(../@createdby) = 'lcpimport'">
				<filetype>
					<xsl:value-of select="'jpeg'"/>
				</filetype>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="n1:actordetail">
		<actordetail>
			<xsl:choose>
				<xsl:when test="string(@lang)= ''">
					<xsl:attribute name="lang">nl</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="lang"><xsl:value-of select="@lang"/></xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:copy-of select="n1:calendarsummary"/>
			<!--
					<xsl:copy-of select="n1:longdescription"/> dont use this. It copies unwanted xsi:type and namespace from the xml from UiV-->
			<xsl:if test="string(n1:longdescription) != ''">
				<longdescription>
					<xsl:value-of select="n1:longdescription"/>
				</longdescription>
			</xsl:if>
			<!--<xsl:copy-of select="n1:media"></xsl:copy-of>-->
			<xsl:apply-templates select="n1:media"/>
			<xsl:choose>
				<xsl:when test="string(n1:shortdescription) = ''">
					<shortdescription>NB</shortdescription>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="n1:shortdescription"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:copy-of select="n1:title"/>
		</actordetail>
	</xsl:template>
	<xsl:template match="n1:housenr">
		<xsl:choose>
			<xsl:when test="string(.) = ''">
				
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@* | node()"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="n1:url">
		<xsl:if test="string(.) != ''">
			<xsl:if test="extfun:isValidURL(string(.))">
				<xsl:choose>
					<xsl:when test="substring(.,1,7) = 'http//:'">
						<xsl:copy-of select="concat('http://',substring(.,8))"/>
					</xsl:when>
					<xsl:when test="substring(.,1,4) = 'http'">
						<xsl:copy-of select="."/>
					</xsl:when>
					<xsl:otherwise>
						<url>
							<xsl:copy-of select="concat('http://',.)"/>
						</url>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="n1:mail">
		<xsl:if test="extfun:emailCheck(string(.))">
			<xsl:copy-of select="."/>
		</xsl:if>
	</xsl:template>
	<!-- street is sometimes empty which is invalid -->
	<xsl:template match="n1:street">
		<xsl:if test="string(.) != ''">
			<xsl:copy-of select="."/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="n1:city">
		<xsl:choose>
			<xsl:when test="string(.) != ''">
				<xsl:copy-of select="."/>
			</xsl:when>
			<xsl:otherwise>
				<city>
					<xsl:value-of select="'n.v.t'"/>
				</city>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="n1:zipcode">
		<xsl:choose>
			<xsl:when test="string(.) != ''">
				<xsl:copy-of select="."/>
			</xsl:when>
			<xsl:otherwise>
				<zipcode>
					<xsl:value-of select="'n.v.t'"/>
				</zipcode>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="@cdbid">
		<xsl:choose>
			<xsl:when test="substring(../@externalid,1,4) = 'CDB:'">
				<xsl:copy>
					<xsl:apply-templates select="@* | node()"/>
				</xsl:copy>
			</xsl:when>
			<xsl:otherwise>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="n1:calendar">
		<!-- we need to check that targetaudience and agefrom are consistent				-->
		<!-- agefrom appears before calendar, that's why we are doing this here			-->
		<xsl:if test="string(../n1:agefrom)  = ''">
			<xsl:variable name="agefrom">
				<xsl:for-each select="../n1:eventcategories/n1:targetaudiences/n1:targetaudience">
					<!-- only use the lowest targetaudience age -->
					<xsl:choose>
						<xsl:when test="string(@catid) = '2.2.1.0.0'">3</xsl:when>
						<xsl:when test="string(@catid) = '2.2.2.0.0'">6</xsl:when>
						<xsl:when test="string(@catid) = '2.2.3.0.0'">12</xsl:when>
						<xsl:when test="string(@catid) = '2.2.4.0.0'">15</xsl:when>
						<xsl:when test="string(@catid) = '2.2.5.0.0'">18</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</xsl:variable>
			<xsl:if test="string($agefrom) != ''">
				<agefrom>
					<xsl:choose>
						<xsl:when test="contains($agefrom,'3')">3</xsl:when>
						<xsl:when test="contains($agefrom,'6')">6</xsl:when>
						<xsl:when test="contains($agefrom,'12')">12</xsl:when>
						<xsl:when test="contains($agefrom,'15')">15</xsl:when>
						<xsl:when test="contains($agefrom,'18')">18</xsl:when>
					</xsl:choose>
				</agefrom>
			</xsl:if>
		</xsl:if>
		<!-- and now add the calendar -->
		<!-- 28/03/2011 : as a temp fix add a dummy weekscheme to a periodic event if one deoesn't  exist -->
		<xsl:choose>
			<xsl:when test="n1:periods != ''">
				<xsl:choose>
					<xsl:when test="n1:periods/n1:period/n1:weekscheme !=''">
						<xsl:copy-of select="."/>
					</xsl:when>
					<xsl:otherwise>
						<calendar>
							<periods>
								<period>
									<datefrom>
										<xsl:value-of select="n1:periods/n1:period/n1:datefrom"/>
									</datefrom>
									<dateto>
										<xsl:value-of select="n1:periods/n1:period/n1:dateto"/>
									</dateto>
									<weekscheme>
										<monday opentype="open"/>
										<tuesday opentype="open"/>
										<wednesday opentype="open"/>
										<thursday opentype="open"/>
										<friday opentype="open"/>
										<saturday opentype="open"/>
										<sunday opentype="open"/>
									</weekscheme>
								</period>
							</periods>
						</calendar>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="n1:media">
		<xsl:variable name="valid_media_exists">
			<xsl:for-each select="n1:file">
				<xsl:if test="string(n1:hlink) != ''">
					<xsl:value-of select="'OK'"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:if test="string($valid_media_exists) != ''">
			<media>
				<xsl:for-each select="n1:file[n1:filetype='jpeg']">
					<xsl:choose>
						<xsl:when test="string(n1:hlink) = ''">
						</xsl:when>
						<xsl:otherwise>
							<file>
								<xsl:if test="string(@main) != ''">
									<xsl:attribute name="main"><xsl:value-of select="@main"/></xsl:attribute>
								</xsl:if>
								<xsl:choose>
									<xsl:when test="string(n1:copyright) = ''">
										<copyright>
											<xsl:value-of select="'Beschrijving niet beschikbaar'"/>
										</copyright>
									</xsl:when>
									<xsl:when test="string-length(n1:copyright) = 1">
										<copyright>
											<xsl:value-of select="n1:copyright"/>
											<xsl:value-of select="' '"/>
										</copyright>
									</xsl:when>
									<xsl:otherwise>
										<xsl:copy-of select="n1:copyright"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(n1:filename) != ''">
										<xsl:copy-of select="n1:filename"/>
									</xsl:when>
									<xsl:otherwise>
										<filename>
											<xsl:value-of select="n1:hlink"/>
										</filename>
									</xsl:otherwise>
								</xsl:choose>
								<filetype>
									<xsl:choose>
										<xsl:when test="string(n1:filetype) != ''">
											<xsl:value-of select="n1:filetype"/>
										</xsl:when>
										<xsl:when test="string(n1:mediatype) = 'reservations'">
											<xsl:value-of select="'onbepaald'"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="'jpeg'"/>
										</xsl:otherwise>
									</xsl:choose>
								</filetype>
								<!--
								<xsl:choose>
									<xsl:when test="string(n1:filetype) != ''">
										<xsl:apply-templates select="n1:filetype"/>
									</xsl:when>
									<xsl:otherwise>
										<filetype>
											<xsl:value-of select="'jpeg'"/>
										</filetype>
									</xsl:otherwise>
								</xsl:choose>
								-->
								<hlink>
									<xsl:choose>
										<xsl:when test="substring(n1:hlink,1,4) = 'http'">
											<xsl:value-of select="n1:hlink"/>
										</xsl:when>
										<xsl:otherwise>
											<!-- added during the import -->
											<!-- <xsl:value-of select="'ftp://media:cnET2008Udb@media.cultuurnet.be/partnermedia/'"/> -->
											<xsl:value-of select="n1:hlink"/>
										</xsl:otherwise>
									</xsl:choose>
								</hlink>
								<xsl:choose>
									<!-- only include the non 3.2 ones -->
									<!--	<xsl:when test="string(n1:mediatype) = 'audio'  or string(n1:mediatype) = 'Word document' "> -->
									<xsl:when test="string(n1:mediatype) = 'Reservaties'">
										<mediatype>
											<xsl:value-of select="'reservations'"/>
										</mediatype>
									</xsl:when>
									<xsl:when test="string(n1:mediatype) = 'audio'  or string(n1:mediatype) = 'Word document' or string(n1:mediatype) = 'other'"/>
									<xsl:otherwise>
										<xsl:copy-of select="n1:mediatype"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(n1:mediatype) = 'reservations' or string(n1:mediatype) = 'Reservaties'">
										<title>
											<xsl:value-of select="'Reservation'"/>
											<xsl:if test="string(n1:title) != ''">
												<xsl:value-of select="' '"/>
												<xsl:value-of select="n1:title"/>
											</xsl:if>
										</title>
									</xsl:when>
									<xsl:when test="string(n1:title) != ''">
										<xsl:copy-of select="n1:title"/>
									</xsl:when>
									<xsl:otherwise>
										<!-- not needed -->
									</xsl:otherwise>
								</xsl:choose>
							</file>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				<xsl:for-each select="n1:file[n1:filetype != 'jpeg' or n1:filetype = '' or string-length(n1:filetype) = 0]">
					<xsl:choose>
						<xsl:when test="string(n1:hlink) = ''">
						</xsl:when>
						<xsl:otherwise>
							<file>
								<xsl:if test="string(@main) != ''">
									<xsl:attribute name="main"><xsl:value-of select="@main"/></xsl:attribute>
								</xsl:if>
								<xsl:choose>
									<xsl:when test="string(n1:copyright) = ''">
										<copyright>
											<xsl:value-of select="'Beschrijving niet beschikbaar'"/>
										</copyright>
									</xsl:when>
									<xsl:when test="string-length(n1:copyright) = 1">
										<copyright>
											<xsl:value-of select="n1:copyright"/>
											<xsl:value-of select="' '"/>
										</copyright>
									</xsl:when>
									<xsl:otherwise>
										<xsl:copy-of select="n1:copyright"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(n1:filename) != ''">
										<xsl:copy-of select="n1:filename"/>
									</xsl:when>
									<xsl:otherwise>
										<filename>
											<xsl:value-of select="n1:hlink"/>
										</filename>
									</xsl:otherwise>
								</xsl:choose>
								<filetype>
									<xsl:choose>
										<xsl:when test="string(n1:filetype) != ''">
											<xsl:value-of select="n1:filetype"/>
										</xsl:when>
										<xsl:when test="string(n1:mediatype) = 'reservations'">
											<xsl:value-of select="'onbepaald'"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="'jpeg'"/>
										</xsl:otherwise>
									</xsl:choose>
								</filetype>
								<!--
								<xsl:choose>
									<xsl:when test="string(n1:filetype) != ''">
										<xsl:apply-templates select="n1:filetype"/>
									</xsl:when>
									<xsl:otherwise>
										<filetype>
											<xsl:value-of select="'jpeg'"/>
										</filetype>
									</xsl:otherwise>
								</xsl:choose>
								-->
								<hlink>
									<xsl:choose>
										<xsl:when test="substring(n1:hlink,1,4) = 'http'">
											<xsl:value-of select="n1:hlink"/>
										</xsl:when>
										<xsl:otherwise>
											<!-- added during the import -->
											<!-- <xsl:value-of select="'ftp://media:cnET2008Udb@media.cultuurnet.be/partnermedia/'"/> -->
											<xsl:value-of select="n1:hlink"/>
										</xsl:otherwise>
									</xsl:choose>
								</hlink>
								<xsl:choose>
									<!-- only include the non 3.2 ones -->
									<!--	<xsl:when test="string(n1:mediatype) = 'audio'  or string(n1:mediatype) = 'Word document' "> -->
									<xsl:when test="string(n1:mediatype) = 'Reservaties'">
										<mediatype>
											<xsl:value-of select="'reservations'"/>
										</mediatype>
									</xsl:when>
									<xsl:when test="string(n1:mediatype) = 'audio'  or string(n1:mediatype) = 'Word document' or string(n1:mediatype) = 'other'"/>
									<xsl:otherwise>
										<xsl:copy-of select="n1:mediatype"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string(n1:mediatype) = 'reservations' or string(n1:mediatype) = 'Reservaties'">
										<title>
											<xsl:value-of select="'Reservation'"/>
											<xsl:if test="string(n1:title) != ''">
												<xsl:value-of select="' '"/>
												<xsl:value-of select="n1:title"/>
											</xsl:if>
										</title>
									</xsl:when>
									<xsl:when test="string(n1:title) != ''">
										<xsl:copy-of select="n1:title"/>
									</xsl:when>
									<xsl:otherwise>
										<!-- not needed -->
									</xsl:otherwise>
								</xsl:choose>
							</file>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</media>
		</xsl:if>
	</xsl:template>
	<xsl:template match="n1:languages">
		<languages>
			<xsl:for-each select="n1:language">
				<language>
					<xsl:if test="string(@type) != ''">
						<xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="string(.)='Nederlands'">nl</xsl:when>
						<xsl:when test="string(.)='Frans'">fr</xsl:when>
						<xsl:when test="string(.)='Engels'">en</xsl:when>
						<xsl:when test="string(.)='Duits'">de</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="string(.)"/>
						</xsl:otherwise>
					</xsl:choose>
				</language>
			</xsl:for-each>
		</languages>
	</xsl:template>
	<xsl:template match="n1:location/n1:actor/@lastupdated">
		<xsl:attribute name="lastupdated"><xsl:value-of select="../../../@lastupdated"/></xsl:attribute>
	</xsl:template>
	<xsl:template match="n1:organiser/n1:actor/@lastupdated">
		<xsl:attribute name="lastupdated"><xsl:value-of select="../../../@lastupdated"/></xsl:attribute>
	</xsl:template>
	<xsl:template match="n1:performer/n1:actor/@lastupdated">
		<xsl:attribute name="lastupdated"><xsl:value-of select="../../../../../../@lastupdated"/></xsl:attribute>
	</xsl:template>
	<xsl:template match="n1:event/@lastupdated">
		<xsl:choose>
			<xsl:when test="string(../@externalid) != ''">
				<xsl:attribute name="externalid"><xsl:value-of select="../@externalid"/></xsl:attribute>
			</xsl:when>
			<xsl:when test="string(../@createdby) = 'cultuurnet001'">
				<xsl:attribute name="externalid"><xsl:value-of select="'TA Import:aanbod_'"/><xsl:value-of select="../@cdbid"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="externalid"><xsl:value-of select="'CDB:'"/><xsl:value-of select="../@cdbid"/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:attribute name="lastupdated"><xsl:value-of select="."/></xsl:attribute>
	</xsl:template>
	<!-- remove these attributes -->
	<xsl:template match="@validator"/>
	<xsl:template match="@method"/>
	<xsl:template match="@asset"/>
	<xsl:template match="n1:event">
		<xsl:if test="string(./n1:location) != '' and string(./n1:contactinfo) != '' and string(./n1:contactinfo/n1:address/n1:physical/n1:zipcode) != '-' and string(./n1:calendar) != '' and string(./n1:eventdetails) != ''">
			<event>
				<!-- <xsl:copy-of select="@* | node()"/> -->
				<xsl:apply-templates select="@* | node()"/>
			</event>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
