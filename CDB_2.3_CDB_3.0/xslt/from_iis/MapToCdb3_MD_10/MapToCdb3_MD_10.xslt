<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
Maps CDB 2.3 to CDB 3.0
-->
<xsl:stylesheet version="1.0" xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:cc="http://www.cultuurdatabank.be/XMLSchema/Culture_CS" xmlns:sc="http://www.cultuurdatabank.be/XMLSchema/SA_comp" xmlns:ad="http://www.cultuurdatabank.be/XMLSchema/address" xmlns:ca="http://www.cultuurdatabank.be/XMLSchema/categorisation" xmlns:ci="http://www.cultuurdatabank.be/XMLSchema/city_area" xmlns:ct="http://www.cultuurdatabank.be/XMLSchema/city_comp" xmlns:co="http://www.cultuurdatabank.be/XMLSchema/country" xmlns:ec="http://www.cultuurdatabank.be/XMLSchema/event_cluster" xmlns:ed="http://www.cultuurdatabank.be/XMLSchema/event_date" xmlns:gc="http://www.cultuurdatabank.be/XMLSchema/gis_comp" xmlns:lc="http://www.cultuurdatabank.be/XMLSchema/language_comp" xmlns:mc="http://www.cultuurdatabank.be/XMLSchema/mail_comp" xmlns:me="http://www.cultuurdatabank.be/XMLSchema/media" xmlns:md="http://www.cultuurdatabank.be/XMLSchema/metadata" xmlns:na="http://www.cultuurdatabank.be/XMLSchema/name_comp" xmlns:no="http://www.cultuurdatabank.be/XMLSchema/note_comp" xmlns:ot="http://www.cultuurdatabank.be/XMLSchema/opening_times" xmlns:or="http://www.cultuurdatabank.be/XMLSchema/organisation" xmlns:pe="http://www.cultuurdatabank.be/XMLSchema/person" xmlns:ph="http://www.cultuurdatabank.be/XMLSchema/phone" xmlns:pr="http://www.cultuurdatabank.be/XMLSchema/price" xmlns:ref="http://www.cultuurdatabank.be/XMLSchema/reference_item" xmlns:rn="http://www.cultuurdatabank.be/XMLSchema/region_nat" xmlns:rel="http://www.cultuurdatabank.be/XMLSchema/relation_item" xmlns:sp="http://www.cultuurdatabank.be/XMLSchema/street_part" xmlns:uc="http://www.cultuurdatabank.be/XMLSchema/url_comp" xmlns:zc="http://www.cultuurdatabank.be/XMLSchema/zip_codes" xmlns:java="http://xml.apache.org/xalan/java" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:extfun="external_functions" xmlns:file="java.io.File" xmlns:xalan="http://xml.apache.org/xalan" exclude-result-prefixes="cc sc ad ca ci ct co ec ed gc lc mc me md na no ot or pe ph pr ref rn rel sp uc zc xs xalan java extfun file">
	<!--   xmlns="http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL"  -->
	<xsl:output method="xml" version="1.0" encoding="ISO-8859-1" indent="yes"/>
	<xalan:component prefix="extfun">
		<xalan:script lang="javascript"><![CDATA[ 
		
		
		function testURL(url_in)
		 {
		 	
		var url_1 = new java.net.URL(url_in)
		
		//make sure the url can be accessed 
		try 	{
				var open_stream = java.io.InputStream(url_1.openStream())
				}
				catch(err)
				{
				return false
				}
		return true
		}
		
		
			function writeLoop(url_in)
		 {
		 	
		var url_1 = new java.net.URL(url_in)
		
		
		//make sure the url can be accessed (again)
		try 	{
				var open_stream = java.io.InputStream(url_1.openStream())
				}
				catch(err)
				{
				return false
				}
		
		var chars = 0
		var str = "";
		var all_text = new java.lang.String
		var read = new java.lang.String  
		
		while ((read = open_stream.read()) != -1)
		{
		chars = chars + 1
		str += ';' + read + ';'
		all_text +=  ';' +  read + ';'
		}
		
		// return  str
		
		var close_2 = open_stream.close()
		
		// use ; before and after each hexpair to revent 33 replacing part of 233
		//  _ represents unused chatacters
		
		if (chars > 0)
		
		{
		
		all_text_1 = all_text.replace(/;32;/g,' ')
		all_text_2 = all_text_1.replace(/;33;/g,'!')
		all_text_3 = all_text_2.replace(/;34;/g,'"')
		all_text_4 = all_text_3.replace(/;35;/g,'#')
		all_text_5 = all_text_4.replace(/;36;/g,'$')
		all_text_6 = all_text_5.replace(/;37;/g,'%')
		all_text_7 = all_text_6.replace(/;38;/g,'&')
		
		// use double quites round the single quote 
		all_text_8 = all_text_7.replace(/;39;/g,"'")
		all_text_9 = all_text_8.replace(/;40;/g,'(')
		all_text_10 = all_text_9.replace(/;41;/g,')')
		
		all_text_11 = all_text_10.replace(/;42;/g,'*')
		all_text_12 = all_text_11.replace(/;43;/g,'+')
		all_text_13 = all_text_12.replace(/;44;/g,',')
		all_text_14 = all_text_13.replace(/;45;/g,'-')
		all_text_15 = all_text_14.replace(/;46;/g,'.')
		all_text_16 = all_text_15.replace(/;47;/g,'/')
		all_text_17 = all_text_16.replace(/;48;/g,'0')
		all_text_18 = all_text_17.replace(/;49;/g,'1')
		all_text_19 = all_text_18.replace(/;50;/g,'2')
		all_text_20 = all_text_19.replace(/;51;/g,'3')
		
		all_text_21 = all_text_20.replace(/;52;/g,'4')
		all_text_22 = all_text_21.replace(/;53;/g,'5')
		all_text_23 = all_text_22.replace(/;54;/g,'6')
		all_text_24 = all_text_23.replace(/;55;/g,'7')
		all_text_25 = all_text_24.replace(/;56;/g,'8')
		all_text_26 = all_text_25.replace(/;57;/g,'9')
		all_text_27 = all_text_26.replace(/;58;/g,':')
		all_text_28 = all_text_27.replace(/;59;/g,';')
		all_text_29 = all_text_28.replace(/;60;/g,'&lt;')
		all_text_30 = all_text_29.replace(/;61;/g,'=')
		
		all_text_31 = all_text_30.replace(/;62;/g,'&gt;')
		all_text_32 = all_text_31.replace(/;63;/g,'?')
		all_text_33 = all_text_32.replace(/;64;/g,'@')
		all_text_34 = all_text_33.replace(/;65;/g,'A')
		all_text_35 = all_text_34.replace(/;66;/g,'B')
		all_text_36 = all_text_35.replace(/;67;/g,'C')
		all_text_37 = all_text_36.replace(/;68;/g,'D')
		all_text_38 = all_text_37.replace(/;69;/g,'E')
		all_text_39 = all_text_38.replace(/;70;/g,'F')
		all_text_40 = all_text_39.replace(/;71;/g,'G')
		
		all_text_41 = all_text_40.replace(/;72;/g,'H')
		all_text_42 = all_text_41.replace(/;73;/g,'I')
		all_text_43 = all_text_42.replace(/;74;/g,'J')
		all_text_44 = all_text_43.replace(/;75;/g,'K')
		all_text_45 = all_text_44.replace(/;76;/g,'L')
		all_text_46 = all_text_45.replace(/;77;/g,'M')
		all_text_47 = all_text_46.replace(/;78;/g,'N')
		all_text_48 = all_text_47.replace(/;79;/g,'O')
		all_text_49 = all_text_48.replace(/;80;/g,'P')
		all_text_50 = all_text_49.replace(/;81;/g,'Q')
		
		all_text_51 = all_text_50.replace(/;82;/g,'R')
		all_text_52 = all_text_51.replace(/;83;/g,'S')
		all_text_53 = all_text_52.replace(/;84;/g,'T')
		all_text_54 = all_text_53.replace(/;85;/g,'U')
		all_text_55 = all_text_54.replace(/;86;/g,'V')
		all_text_56 = all_text_55.replace(/;87;/g,'W')
		all_text_57 = all_text_56.replace(/;88;/g,'X')
		all_text_58 = all_text_57.replace(/;89;/g,'Y')
		all_text_59 = all_text_58.replace(/;90;/g,'Z')
		all_text_60 = all_text_59.replace(/;91;/g,'[')
		
		// all_text_61 = all_text_60.replace(/;92;/g,'\')
		all_text_62 = all_text_60.replace(/;93;/g,']')
		all_text_63 = all_text_62.replace(/;94;/g,'^')
		all_text_64 = all_text_62.replace(/;95;/g,'_')
		all_text_65 = all_text_64.replace(/;96;/g,'`')
		all_text_66 = all_text_65.replace(/;97;/g,'a')
		all_text_67 = all_text_66.replace(/;98;/g,'b')
		all_text_68 = all_text_67.replace(/;99;/g,'c')
		all_text_69 = all_text_68.replace(/;100;/g,'d')
		all_text_70 = all_text_69.replace(/;101;/g,'e')

		all_text_71 = all_text_70.replace(/;102;/g,'f')
		all_text_72 = all_text_71.replace(/;103;/g,'g')
		all_text_73 = all_text_72.replace(/;104;/g,'h')
		all_text_74 = all_text_73.replace(/;105;/g,'i')
		all_text_75 = all_text_74.replace(/;106;/g,'j')
		all_text_76 = all_text_75.replace(/;107;/g,'k')
		all_text_77 = all_text_76.replace(/;108;/g,'l')
		all_text_78 = all_text_77.replace(/;109;/g,'m')
		all_text_79 = all_text_78.replace(/;110;/g,'n')
		all_text_80 = all_text_79.replace(/;111;/g,'o')
		
		all_text_81 = all_text_80.replace(/;112;/g,'p')
		all_text_82 = all_text_81.replace(/;113;/g,'q')
		all_text_83 = all_text_82.replace(/;114;/g,'r')
		all_text_84 = all_text_83.replace(/;115;/g,'s')
		all_text_85 = all_text_84.replace(/;116;/g,'t')
		all_text_86 = all_text_85.replace(/;117;/g,'u')
		all_text_87 = all_text_86.replace(/;118;/g,'v')
		all_text_88 = all_text_87.replace(/;119;/g,'w')
		all_text_89 = all_text_88.replace(/;120;/g,'x')
		all_text_90 = all_text_89.replace(/;121;/g,'y')

		all_text_91 = all_text_90.replace(/;122;/g,'z')
		all_text_92 = all_text_91.replace(/;123;/g,'{')
		all_text_93 = all_text_92.replace(/;124;/g,'|')
		all_text_94 = all_text_93.replace(/;125;/g,'}')
		all_text_95 = all_text_94.replace(/;126;/g,'~')
		all_text_96 = all_text_95.replace(/;127;/g,'')  // square
		all_text_97 = all_text_96.replace(/;128;/g,'euro') // euro
		all_text_98 = all_text_97.replace(/;129;/g,'') // square
		all_text_99 = all_text_98.replace(/;130;/g,',')
		all_text_100 = all_text_99.replace(/;131;/g,'_') 
		
		all_text_101 = all_text_100.replace(/;132;/g,'_')
		all_text_102 = all_text_101.replace(/;133;/g,'...')
		all_text_103 = all_text_102.replace(/;134;/g,'_')
		all_text_104 = all_text_103.replace(/;135;/g,'_')
		all_text_105 = all_text_104.replace(/;136;/g,'_')
		all_text_106 = all_text_105.replace(/;137;/g,' _') 
		all_text_107 = all_text_106.replace(/;138;/g,'_')
		all_text_108 = all_text_107.replace(/;139;/g,'_') 
		all_text_109 = all_text_108.replace(/;140;/g,'_')
		all_text_110 = all_text_109.replace(/;141;/g,'') // square
		
		all_text_111 = all_text_110.replace(/;142;/g,'_')
		all_text_112 = all_text_111.replace(/;143;/g,'') // square
		all_text_113 = all_text_112.replace(/;144;/g,'') // square
		// substitute the special quotes for normal ones
		all_text_114 = all_text_113.replace(/;145;/g,"'")
		all_text_115 = all_text_114.replace(/;146;/g,"'")
		all_text_116 = all_text_115.replace(/;147;/g,'"') 
		all_text_117 = all_text_116.replace(/;148;/g,'"')
		// use a hyphen and spaces instead of the bullet mark
		all_text_118 = all_text_117.replace(/;149;/g,'-   ') 
		all_text_119 = all_text_118.replace(/;150;/g,'-')
		all_text_120 = all_text_119.replace(/;151;/g,'_') 
		
		all_text_121 = all_text_120.replace(/;152;/g,'_')
		all_text_122 = all_text_121.replace(/;153;/g,'_')
		// this should be an s with a v on top of it, but it's not recognised by xslt.
		all_text_123 = all_text_122.replace(/;154;/g,'s')
		all_text_124 = all_text_123.replace(/;155;/g,'_')
		all_text_125 = all_text_124.replace(/;156;/g,'_')
		all_text_126 = all_text_125.replace(/;157;/g,'') // square
		all_text_127 = all_text_126.replace(/;158;/g,'_')
		all_text_128 = all_text_127.replace(/;159;/g,'_') 
		all_text_129 = all_text_128.replace(/;160;/g,'&nbsp;')
		all_text_130 = all_text_129.replace(/;161;/g,'¡') 
		
		all_text_131 = all_text_130.replace(/;162;/g,'¢')
		all_text_132 = all_text_131.replace(/;163;/g,'£')
		all_text_133 = all_text_132.replace(/;164;/g,'¤')
		all_text_134 = all_text_133.replace(/;165;/g,'¥')
		all_text_135 = all_text_134.replace(/;166;/g,'¦')
		all_text_136 = all_text_135.replace(/;167;/g,'§') 
		all_text_137 = all_text_136.replace(/;168;/g,'¨')
		all_text_138 = all_text_137.replace(/;169;/g,'©') 
		all_text_139 = all_text_138.replace(/;170;/g,'ª')
		all_text_140 = all_text_139.replace(/;171;/g,'«') 
		
		
		all_text_141 = all_text_140.replace(/;172;/g,'Euro') // euro
		all_text_142 = all_text_141.replace(/;173;/g,'') // nothing
		all_text_143 = all_text_142.replace(/;174;/g,'®')
		all_text_144 = all_text_143.replace(/;175;/g,'¯')
		all_text_145 = all_text_144.replace(/;176;/g,'°')
		all_text_146 = all_text_145.replace(/;177;/g,'±') 
		all_text_147 = all_text_146.replace(/;178;/g,'²')
		all_text_148 = all_text_147.replace(/;179;/g,'³') 
		all_text_149 = all_text_148.replace(/;180;/g,'´')
		all_text_150 = all_text_149.replace(/;181;/g,'µ') 
		
		all_text_151 = all_text_150.replace(/;182;/g,'¶')
		all_text_152 = all_text_151.replace(/;183;/g,'·')
		all_text_153 = all_text_152.replace(/;184;/g,'¸')
		all_text_154 = all_text_153.replace(/;185;/g,'¹')
		all_text_155 = all_text_154.replace(/;186;/g,'º')
		all_text_156 = all_text_155.replace(/;187;/g,'»') 
		all_text_157 = all_text_156.replace(/;188;/g,'¼')
		all_text_158 = all_text_157.replace(/;189;/g,'½') 
		all_text_159 = all_text_158.replace(/;190;/g,'¾')
		all_text_160 = all_text_159.replace(/;191;/g,'¿') 
		
		all_text_161 = all_text_160.replace(/;192;/g,'À')
		all_text_162 = all_text_161.replace(/;193;/g,'Á')
		all_text_163 = all_text_162.replace(/;194;/g,'Â')
		all_text_164 = all_text_163.replace(/;195;/g,'Ã')
		all_text_165 = all_text_164.replace(/;196;/g,'Ä')
		all_text_166 = all_text_165.replace(/;197;/g,'Å') 
		all_text_167 = all_text_166.replace(/;198;/g,'Æ')
		all_text_168 = all_text_167.replace(/;199;/g,'Ç') 
		all_text_169 = all_text_168.replace(/;200;/g,'È')
		all_text_170 = all_text_169.replace(/;201;/g,'É') 
		
		all_text_171 = all_text_170.replace(/;202;/g,'Ê')
		all_text_172 = all_text_171.replace(/;203;/g,'Ë')
		all_text_173 = all_text_172.replace(/;204;/g,'Ì')
		all_text_174 = all_text_173.replace(/;205;/g,'Í')
		all_text_175 = all_text_174.replace(/;206;/g,'Î')
		all_text_176 = all_text_175.replace(/;207;/g,'Ï') 
		all_text_177 = all_text_176.replace(/;208;/g,'Ð')
		all_text_178 = all_text_177.replace(/;209;/g,'Ñ') 
		all_text_179 = all_text_178.replace(/;210;/g,'Ò')
		all_text_180 = all_text_179.replace(/;211;/g,'Ó') 
		
		all_text_181 = all_text_180.replace(/;212;/g,'Ô')
		all_text_182 = all_text_181.replace(/;213;/g,'Õ')
		all_text_183 = all_text_182.replace(/;214;/g,'Ö')
		all_text_184 = all_text_183.replace(/;215;/g,'×')
		all_text_185 = all_text_184.replace(/;216;/g,'Ø')
		all_text_186 = all_text_185.replace(/;217;/g,'Ù') 
		all_text_187 = all_text_186.replace(/;218;/g,'Ú')
		all_text_188 = all_text_187.replace(/;219;/g,'Û') 
		all_text_189 = all_text_188.replace(/;220;/g,'Ü')
		all_text_190 = all_text_189.replace(/;221;/g,'Ý') 
		
		all_text_191 = all_text_190.replace(/;222;/g,'Þ')
		all_text_192 = all_text_191.replace(/;223;/g,'ß')
		all_text_193 = all_text_192.replace(/;224;/g,'à')
		all_text_194 = all_text_193.replace(/;225;/g,'á')
		all_text_195 = all_text_194.replace(/;226;/g,'â')
		all_text_196 = all_text_195.replace(/;227;/g,'ã') 
		all_text_197 = all_text_196.replace(/;228;/g,'ä')
		all_text_198 = all_text_197.replace(/;229;/g,'å') 
		all_text_199 = all_text_198.replace(/;230;/g,'æ')
		all_text_200 = all_text_199.replace(/;231;/g,'ç') 
		
		all_text_201 = all_text_200.replace(/;232;/g,'è')
		all_text_202 = all_text_201.replace(/;233;/g,'é')
		all_text_203 = all_text_202.replace(/;234;/g,'ê')
		all_text_204 = all_text_203.replace(/;235;/g,'ë')
		all_text_205 = all_text_204.replace(/;236;/g,'ì')
		all_text_206 = all_text_205.replace(/;237;/g,'í') 
		all_text_207 = all_text_206.replace(/;238;/g,'î')
		all_text_208 = all_text_207.replace(/;239;/g,'ï') 
		all_text_209 = all_text_208.replace(/;240;/g,'ð')
		all_text_210 = all_text_209.replace(/;241;/g,'ñ') 
		
		all_text_211 = all_text_210.replace(/;242;/g,'ð')
		all_text_212 = all_text_211.replace(/;243;/g,'ó')
		all_text_213 = all_text_212.replace(/;244;/g,'ô')
		all_text_214 = all_text_213.replace(/;245;/g,'õ')
		all_text_215 = all_text_214.replace(/;246;/g,'ö')
		all_text_216 = all_text_215.replace(/;247;/g,'÷') 
		all_text_217 = all_text_216.replace(/;248;/g,'ø')
		all_text_218 = all_text_217.replace(/;249;/g,'ù') 
		all_text_219 = all_text_218.replace(/;250;/g,'ú')
		all_text_220 = all_text_219.replace(/;251;/g,'û') 
		
		all_text_221 = all_text_220.replace(/;252;/g,'ü')
		all_text_222 = all_text_221.replace(/;253;/g,'ý')
		all_text_223 = all_text_222.replace(/;254;/g,'þ')
		all_text_224 = all_text_223.replace(/;255;/g,'ÿ')
		
		// CR LF :
		// Use an unused character and replace it in the xslt
		all_text_225 = all_text_224.replace(/;10;/g,'þ')
		// Not needed
		all_text_226= all_text_225.replace(/;13;/g,'')
		
		// replace the remaining seperators with nothing :
		all_text_227 = all_text_226.replace(/;;;/g,'')
		
		// replace the tab with 5 spaces 
		all_text_all = all_text_227.replace(/;9;/g,'     ')
		
		 return  all_text_all
		 
		 }
		 
		return ""
		 
		 }
		
		
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
	<xsl:template match="/CDB">
		<cdbxml>
			<!-- <xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL
\\172.16.1.51\xml\XSD\CDB_3_0\CDBXML~1.0-F\CdbXSD.xsd</xsl:attribute>-->
			<!-- <xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.0/FINAL //172.16.1.51/xml/XSD/CDB_3_0/CdbXSD_3.0/CdbXSD_3.0/CdbXSD.xsd</xsl:attribute> -->
			<xsl:attribute name="xsi:schemaLocation">http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT
		http://www.cultuurdatabank.com/XMLSchema/CdbXSD/3.1/DRAFT/CdbXSD.xsd</xsl:attribute>
			<!-- Metadata -->
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
										<xsl:value-of select="'true'"/>
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
								<xsl:choose>
									<xsl:when test="string(event_base_type) = 'tijdelijk'">
										<xsl:choose>
											<xsl:when test="string(availableto) = ''"><xsl:attribute name="availableto"><xsl:value-of select="date_to"/></xsl:attribute></xsl:when>
											<xsl:otherwise><xsl:attribute name="availableto"><xsl:value-of select="md:availableto"/></xsl:attribute></xsl:otherwise>
										</xsl:choose>
									
									</xsl:when>
									<xsl:otherwise>
										<xsl:if test="substring(md:availableto,1,4) &lt; 2020">
											<xsl:attribute name="availableto"><xsl:value-of select="md:availableto"/></xsl:attribute>
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:for-each select="md:availableto">
									<xsl:if test="substring(.,1,4) &lt; 2020">
										<xsl:attribute name="availableto"><xsl:value-of select="."/></xsl:attribute>
									</xsl:if>
								</xsl:for-each>
								<xsl:for-each select="md:objectid">
									<xsl:attribute name="cdbid"><xsl:value-of select="."/></xsl:attribute>
								</xsl:for-each>
								<!-- add the extra metadata -->
								<xsl:if test="string(md:createdby) != ''">
									<xsl:attribute name="createdby"><xsl:value-of select="md:createdby"/></xsl:attribute>
								</xsl:if>
								<xsl:if test="string(md:datetimecreated) != ''">
									<xsl:attribute name="creationdate"><xsl:value-of select="md:datetimecreated"/></xsl:attribute>
								</xsl:if>
								<xsl:choose>
									<xsl:when test="string(md:external_identifier) != ''">
										<xsl:attribute name="externalid"><xsl:value-of select="md:external_identifier"/></xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="externalid"><xsl:value-of select="concat('CDB:',md:objectid)"/></xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
								<!-- external id mandatory 2/09/08 
								<xsl:if test="string(md:external_identifier) != ''">
									<xsl:attribute name="externalid"><xsl:value-of select="md:external_identifier"/></xsl:attribute>
								</xsl:if>
								-->
								<xsl:if test="string(md:datetimelastupdated) != ''">
									<xsl:attribute name="lastupdated"><xsl:value-of select="md:datetimelastupdated"/></xsl:attribute>
								</xsl:if>
								<xsl:if test="string(md:lastupdatedby) != ''">
									<xsl:attribute name="lastupdatedby"><xsl:value-of select="md:lastupdatedby"/></xsl:attribute>
								</xsl:if>
								<xsl:if test="string(md:method) != ''">
									<xsl:attribute name="method"><xsl:choose><xsl:when test="string(md:method) = 'gewijzigd'"><xsl:value-of select="'update'"/></xsl:when><xsl:otherwise><xsl:value-of select="'create'"/></xsl:otherwise></xsl:choose></xsl:attribute>
								</xsl:if>
								<xsl:if test="string(md:userpool) != ''">
									<xsl:attribute name="owner"><xsl:value-of select="md:userpool"/></xsl:attribute>
								</xsl:if>
								<!-- add private -->
								<xsl:variable name="scholen">
									<xsl:for-each select="category">
										<xsl:for-each select="categorisation_instance">
											<xsl:if test="string(label/dutch) = 'Scholen'">
												<xsl:value-of select="'true'"/>
											</xsl:if>
										</xsl:for-each>
									</xsl:for-each>
								</xsl:variable>
								<xsl:variable name="private">
								<xsl:if test="substring($scholen,1,4) = 'true'">
								
									<xsl:for-each select="category">
										<xsl:for-each select="categorisation_instance">
											<xsl:if test="string(label/dutch) = 'Jeugdboekenweek' or 
																string(label/dutch) = 'De Week van de Smaak' or 
																string(label/dutch) = 'Artistieke activiteiten' or
																string(label/dutch) = 'Culinair erfgoed, tentoonstellingen' or 
																string(label/dutch) = 'Diversiteit in smaken' or 
																string(label/dutch) = 'Educatieve activiteiten, lezingen, studiedagen' or
																string(label/dutch) = 'Land van de Smaak' or 
																string(label/dutch) = 'Literaire activiteiten' or 
																string(label/dutch) = 'Opendeur, rondleidingen' or
																string(label/dutch) = 'Proeven, kooklessen' or 
																string(label/dutch) = 'Product in de kijker' or 
																string(label/dutch) = 'Smaak op school (activiteiten onderwijs)' or
																string(label/dutch) = 'Stad van de Smaak' or 
																string(label/dutch) = 'Uit eten' or 
																string(label/dutch) = 'Varia, andere activiteiten'">
												<xsl:value-of select="'true'"/>
											</xsl:if>
										</xsl:for-each>
									</xsl:for-each>
									</xsl:if>
								</xsl:variable>
								<xsl:if test="substring($private,1,4) = 'true'">
									<xsl:attribute name="private"><xsl:value-of select="false()"/></xsl:attribute>
								</xsl:if>
								<xsl:if test="string(md:validatedby) != ''">
									<xsl:attribute name="validator"><xsl:value-of select="md:validatedby"/></xsl:attribute>
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
																		<xsl:when test="string($actor_type) = 'reference' or string($thema_onbepaald) = 'true' or string(md:short_description/dutch) = 'NB'">
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
																	<xsl:when test="string($actor_type) = 'reference' or string($thema_onbepaald) = 'true' or string(md:short_description/dutch) = 'NB'">
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
										<!-- <xsl:for-each select="me:media/media_instance"> -->
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
															<!-- test with a bad file name 
																<xsl:variable name="text_file" select="'86E2D87-9296-C958-6B25D28520CD7161longdescription.txt'"/> -->
															<!-- test with local file
																<xsl:variable name="full_text_file" select="concat('T:\XML\Erfgoed\exportBEXML_20070417_152358_part_1_of_7\',$text_file)"></xsl:variable>
															-->
															<!-- for iis NOTE :  Bad for fulls in parts
																<xsl:variable name="full_text_file" select="concat($iis.ext.files,'/',$text_file)"></xsl:variable>
															-->
															<!-- construct the complete url -->
															<xsl:variable name="url" select="concat('http://www.cultuurweb.be/CNETPortal/media/',$text_file)"/>
															<!-- check the url exists -->
															<xsl:variable name="test_URL">
																<xsl:value-of select="extfun:testURL(string($url))"/>
															</xsl:variable>
															<xsl:variable name="file" select="java:java.io.File.new($url)"/>
															<xsl:if test="position() = 1">
																<xsl:choose>
																	<xsl:when test="$test_URL = 'true'">
																		<xsl:variable name="text_string">
																			<xsl:value-of select="extfun:writeLoop(string($url))"/>
																		</xsl:variable>
																		<xsl:variable name="adjust_1">
																			<xsl:value-of select="translate($text_string,'þ','&#xA;')"/>
																		</xsl:variable>
																		<longdescription>
																			<xsl:choose>
																				<xsl:when test="string($adjust_1) != ''">
																					<xsl:value-of select="$adjust_1"/>
																				</xsl:when>
																				<xsl:otherwise>
																					<xsl:if test="string(./value_plain_text) != ''">
																						<xsl:if test="string(./value_plain_text/dutch) != 'kinderen toegelaten'">
																							<xsl:if test="string(./categorisation_instance/label/dutch) != 'prijsomschrijvingen en kortingen'">
																								<xsl:value-of select="./value_plain_text/dutch"/>
																							</xsl:if>
																						</xsl:if>
																					</xsl:if>
																				</xsl:otherwise>
																			</xsl:choose>
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
																	<xsl:value-of select="'http://media.cultuurnet.be/media/'"/>
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
								<!-- addded for MD_03 -->
								<xsl:if test="string(productieid) != '' or string(koepelid) != ''">
									<eventrelations>
										<xsl:if test="string(productieid) != ''">
											<relatedproduction>
												<xsl:attribute name="cdbid"><xsl:value-of select="productieid"/></xsl:attribute>
												<xsl:value-of select="md:label/dutch"/>
											</relatedproduction>
										</xsl:if>
										<xsl:if test="string(koepelid) != ''">
											<parentevent>
												<xsl:attribute name="cdbid"><xsl:value-of select="koepelid"/></xsl:attribute>
												<xsl:value-of select="md:label/dutch"/>
											</parentevent>
										</xsl:if>
									</eventrelations>
								</xsl:if>
								<!-- old 
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
																<xsl:when test="string($actor_type) = 'reference' or string($thema_onbepaald) = 'true' or string(md:short_description/dutch) = 'NB'">
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
																<xsl:when test="string($actor_type) = 'reference' or string($thema_onbepaald) = 'true' or string(md:short_description/dutch) = 'NB'">
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
									</xsl:otherwise>
								</xsl:choose>
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
														<xsl:when test="string($actor_type) = 'reference' or string($thema_onbepaald) = 'true' or string(md:short_description/dutch) = 'NB'">
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
			<!-- not needed. The production id and title are in the event -->
			<!-- <xsl:call-template name="insertProductions"/> -->
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
