package com.github.funthomas424242.language.generator

import com.github.funthomas424242.language.rezept.RezeptbuchProjekt

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class POMGenerator{
	
	
	def static getPOMFileName(RezeptbuchProjekt project) {
		return project.groupId+"."+project.artifactId+"/pom.xml";
	}
	
	
	
	def static createPOMContent(RezeptbuchProjekt project) '''
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">

	<modelVersion>4.0.0</modelVersion>


	<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
	<!-- INFORMATIONS -->
	<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
	<groupId>«project.groupId»</groupId>
	<artifactId>«project.artifactId»</artifactId>
	<version>«project.version»</version>
	<name>«project.buch.titel»</name>
	<packaging>pom</packaging>

	<profiles>
		<profile>
			<id>github</id>
			<properties>
				<github.global.userName>${env.gituser}</github.global.userName>
				<github.global.password>${env.gitpassword}</github.global.password>
				<github.site.repositoryName>rezeptbuch</github.site.repositoryName>
				<github.site.repositoryOwner>${env.gituser}</github.site.repositoryOwner>
				<site.img.path>http://funthomas424242.github.io/rezeptbuch/kochbuch/media/</site.img.path>
			</properties>
			<build>
				<plugins>
					<plugin>
						<groupId>com.github.github</groupId>
						<artifactId>site-maven-plugin</artifactId>
						<version>${github.maventools.version}</version>
						<dependencies>
							<dependency>
								<groupId>org.apache.maven.plugins</groupId>
								<artifactId>maven-site-plugin</artifactId>
								<version>${mvn.siteplugin.version}</version>
							</dependency>
						</dependencies>
						<configuration>
							<message>Building site for ${project.version}</message>
							<dryRun>${testonly}</dryRun>
							<noJekyll>true</noJekyll>
							<merge>true</merge>
							<repositoryName>${github.site.repositoryName}</repositoryName>
							<repositoryOwner>${github.site.repositoryOwner}</repositoryOwner>
							<userName>${github.global.userName}</userName>
							<password>${github.global.password}</password>
						</configuration>
						<executions>
							<execution>
								<goals>
									<goal>site</goal>
								</goals>
								<phase>site</phase>
							</execution>
						</executions>
					</plugin>
				</plugins>
			</build>
		</profile>
	</profiles>


	<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
	<!-- PROPERTIES -->
	<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
	<properties>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
		<media.parent>${basedir}/../../src/_fotos</media.parent>
		<draft.mode>no</draft.mode>
		<testonly>false</testonly>
		<github.maventools.version>0.12</github.maventools.version>
		<mvn.siteplugin.version>3.3</mvn.siteplugin.version>
	    <site.img.path>${project.build.directory}/site/${project.artifactId}/media/</site.img.path>
	</properties>


	<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
	<!-- BUILD -->
	<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
	<build>
        <defaultGoal>site</defaultGoal>
		<plugins>			
			<plugin>
				<groupId>com.agilejava.docbkx</groupId>
				<artifactId>docbkx-maven-plugin</artifactId>
				<version>2.0.14</version>
				<executions>
					<execution>
						<id>generate-output</id>
						<phase>pre-site</phase>
						<goals>
							<goal>generate-webhelp</goal>
							<goal>generate-epub</goal>
							<!--goal>generate-html</goal>
							<goal>generate-pdf</goal>
							<goal>generate-javahelp</goal>
							<goal>generate-rtf</goal>
							<goal>generate-html</goal>
							<goal>generate-xhtml</goal>
							<goal>generate-manpages</goal>
							<goal>generate-eclipse</goal-->
						</goals>
						<configuration>
							<draftMode>${draft.mode}</draftMode>
							<draftWatermarkImage>../../media/draft.png</draftWatermarkImage>
						</configuration>
					</execution>
				</executions>
				<configuration>
					<sourceDirectory>${basedir}/src/main/docbkx</sourceDirectory>
					<!-- <targetDirectory>${project.build.directory}/site/${project.artifactId}</targetDirectory> -->
					<generatedSourceDirectory>${project.build.directory}/docbkx/generated</generatedSourceDirectory>
					<imgSrcPath>${site.img.path}</imgSrcPath>
					<keepRelativeImageUris>true</keepRelativeImageUris>
					<includes>book.dbk</includes>
					<xincludeSupported>true</xincludeSupported>
					<highlightSource>1</highlightSource>
					<paperType>A4</paperType>
					<doubleSided>true</doubleSided>
					<fop1Extensions>1</fop1Extensions>
					<foCustomization>src/main/resources/stylesheets/fo/docbook.xsl</foCustomization>
					<partAutolabel>0</partAutolabel>
					<chapterAutolabel>0</chapterAutolabel>
					<sectionAutolabel>true</sectionAutolabel>
					<sectionAutolabelMaxDepth>3</sectionAutolabelMaxDepth>
					<sectionLabelIncludesComponentLabel>2</sectionLabelIncludesComponentLabel>
					<authorOthernameInMiddle>true</authorOthernameInMiddle>
					<epubAutolabel>1</epubAutolabel>
				</configuration>
				<dependencies>
					<!--dependency>
						<groupId>org.docbook</groupId>
						<artifactId>docbook-xml</artifactId>
						<version>5.0</version>
						<type>pom</type>
						<scope>runtime</scope>
					</dependency-->
					<dependency>
						<groupId>net.sf.docbook</groupId>
						<artifactId>docbook-xml</artifactId>
						<version>5.0-all</version>
						<type>pom</type>
						<scope>runtime</scope>
					</dependency>
				</dependencies>
			</plugin>
			<plugin>
				<artifactId>maven-resources-plugin</artifactId>
				<version>2.5</version>
				<executions>
					<execution>
						<id>mediacopy-common</id>
						<phase>pre-site</phase>
						<goals>
							<goal>copy-resources</goal>
						</goals>
						<configuration>
							<outputDirectory>${project.build.directory}/site/${project.artifactId}/media</outputDirectory>
							<resources>
								<resource>
									<directory>${media.parent}</directory>
									<filtering>false</filtering>
								</resource>
							</resources>
						</configuration>
					</execution>
                    <execution>
                        <id>webhelpcopy-common</id>
                        <phase>pre-site</phase>
                        <goals>
                            <goal>copy-resources</goal>
                        </goals>
                        <configuration>
                            <outputDirectory>${project.build.directory}/site/${project.artifactId}</outputDirectory>
                            <resources>
                                <resource>
                                    <directory>${project.build.directory}/docbkx/webhelp</directory>
                                    <filtering>false</filtering>
                                </resource>
                            </resources>
                        </configuration>
                    </execution>					
				</executions>
			</plugin>			
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-site-plugin</artifactId>
				<version>${mvn.siteplugin.version}</version>
			</plugin>
		</plugins>
	</build>

</project>
	'''
	}
