set gwt_home=C:\java\gwt-1.3.3
set m2_repo=C:\docume~1\enielsen\.m2\repository
java -cp "%~dp0\src\main\java;%m2_repo%\org\apache\jackrabbit\jackrabbit-text-extractors\1.3\jackrabbit-text-extractors-1.3.jar;%m2_repo%\jboss\javassist\3.4.ga\javassist-3.4.ga.jar;%m2_repo%\janino\janino\2.5.7\janino-2.5.7.jar;%m2_repo%\javax\jcr\jcr\1.0\jcr-1.0.jar;%m2_repo%\asm\asm\1.5.3\asm-1.5.3.jar;%m2_repo%\xml-apis\xml-apis\1.0.b2\xml-apis-1.0.b2.jar;%m2_repo%\org\tmatesoft\svnkit\1.1.2\svnkit-1.1.2.jar;%m2_repo%\jexcelapi\jxl\2.4.2\jxl-2.4.2.jar;%m2_repo%\org\apache\jackrabbit\jackrabbit-jcr-commons\1.3\jackrabbit-jcr-commons-1.3.jar;C:\projetos\drools\drools-repository\src\main\java;%m2_repo%\jboss\seam\profiles\seam-nopersistence\1.2.0.GA\seam-nopersistence-1.2.0.GA.jar;%m2_repo%\dom4j\dom4j\1.6.1\dom4j-1.6.1.jar;%m2_repo%\xpp3\xpp3_min\1.1.3.4.O\xpp3_min-1.1.3.4.O.jar;%m2_repo%\javax\jms\jms\1.1\jms-1.1.jar;%m2_repo%\javax\transaction\jta\1.0.1B\jta-1.0.1B.jar;%m2_repo%\commons-collections\commons-collections\3.1\commons-collections-3.1.jar;%m2_repo%\org\antlr\antlr-runtime\3.0\antlr-runtime-3.0.jar;%m2_repo%\org\slf4j\slf4j-api\1.3.0\slf4j-api-1.3.0.jar;C:\projetos\drools\drools-decisiontables\src\main\java;%m2_repo%\commons-logging\commons-logging\1.0.4\commons-logging-1.0.4.jar;%m2_repo%\concurrent\concurrent\1.3.4\concurrent-1.3.4.jar;%m2_repo%\xerces\xercesImpl\2.4.0\xercesImpl-2.4.0.jar;%m2_repo%\javax\el\el-ri\1.2\el-ri-1.2.jar;%m2_repo%\net\sf\ehcache\ehcache\1.2.3\ehcache-1.2.3.jar;%m2_repo%\junit\junit\3.8.1\junit-3.8.1.jar;C:\projetos\drools\drools-compiler\src\main\java;%m2_repo%\commons-io\commons-io\1.1\commons-io-1.1.jar;%m2_repo%\org\apache\jackrabbit\jackrabbit-api\1.3\jackrabbit-api-1.3.jar;%m2_repo%\asm\asm-attrs\1.5.3\asm-attrs-1.5.3.jar;%m2_repo%\javax\el\el-api\1.2\el-api-1.2.jar;%m2_repo%\com\thoughtworks\xstream\xstream\1.2.2\xstream-1.2.2.jar;%m2_repo%\jboss\seam\jboss-seam\1.2.0.GA\jboss-seam-1.2.0.GA.jar;%m2_repo%\org\hibernate\hibernate-annotations\3.2.1.ga\hibernate-annotations-3.2.1.ga.jar;%m2_repo%\cglib\cglib\2.1_3\cglib-2.1_3.jar;%m2_repo%\org\slf4j\slf4j-log4j12\1.3.0\slf4j-log4j12-1.3.0.jar;%m2_repo%\ch\ethz\ganymed\ganymed-ssh2\build210\ganymed-ssh2-build210.jar;C:\projetos\drools\drools-core\src\main\java;%m2_repo%\org\apache\jackrabbit\jackrabbit-core\1.3\jackrabbit-core-1.3.jar;%m2_repo%\org\mvel\mvel14\1.2rc4rv908\mvel14-1.2rc4rv908.jar;%m2_repo%\commons-fileupload\commons-fileupload\1.1.1\commons-fileupload-1.1.1.jar;%m2_repo%\org\hibernate\hibernate\3.2.1.ga\hibernate-3.2.1.ga.jar;%m2_repo%\javax\persistence\persistence-api\1.0\persistence-api-1.0.jar;%m2_repo%\javax\servlet\servlet-api\2.3\servlet-api-2.3.jar;%m2_repo%\org\apache\derby\derby\10.2.1.6\derby-10.2.1.6.jar;%m2_repo%\org\apache\lucene\lucene-core\2.0.0\lucene-core-2.0.0.jar;%m2_repo%\log4j\log4j\1.2.13\log4j-1.2.13.jar;%m2_repo%\antlr\antlr\2.7.6\antlr-2.7.6.jar;%gwt_home%\gwt-user.jar;%gwt_home%\gwt-servlet.jar;%gwt_home%\gwt-dev-windows.jar" com.google.gwt.dev.GWTCompiler -out "%~dp0\src\main\webapp" %* org.drools.brms.JBRMS
