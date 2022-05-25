#IGNORE_TEST_RUN
@jboss-eap-8-tech-preview
Feature: OIDC tests

   Scenario: Check oidc subsystem configuration.
     Given XML namespaces
       | prefix | url                          |
       | ns     | urn:wildfly:elytron-oidc-client:1.0 |
     Given s2i build https://github.com/jboss-container-images/jboss-eap-8-openshift-image from test/test-app-elytron-oidc-client with env and True using eap8-beta-dev
       | variable               | value                                            |
       | OIDC_PROVIDER_NAME | keycloak |
       | OIDC_PROVIDER_URL           | http://localhost:8080/auth/realms/demo    |
       | OIDC_SECURE_DEPLOYMENT_ENABLE_CORS        | true                          |
       | OIDC_SECURE_DEPLOYMENT_BEARER_ONLY        | true                          |
       ### PLACEHOLDER FOR CLOUD CUSTOM TESTING ###
    Then container log should contain WFLYSRV0010: Deployed "oidc-webapp.war"
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value keycloak on XPath //ns:provider/@name
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value oidc-webapp.war on XPath //*[local-name()='secure-deployment']/@name
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value true on XPath //*[local-name()='provider']/*[local-name()='enable-cors']
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value true on XPath //*[local-name()='secure-deployment'][@name="oidc-webapp.war"]/*[local-name()='bearer-only']
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value true on XPath //*[local-name()='secure-deployment'][@name="oidc-webapp.war"]/*[local-name()='enable-basic-auth'] 
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value http://localhost:8080/auth/realms/demo on XPath //*[local-name()='provider']/*[local-name()='provider-url']

  Scenario: Check oidc subsystem configuration, legacy.
     Given XML namespaces
       | prefix | url                          |
       | ns     | urn:wildfly:elytron-oidc-client:1.0 |
     Given s2i build https://github.com/jboss-container-images/jboss-eap-8-openshift-image from test/test-app-elytron-oidc-client-legacy with env and True using eap8-beta-dev
       | variable               | value                                            |
       | OIDC_PROVIDER_NAME | keycloak |
       | OIDC_PROVIDER_URL           | http://localhost:8080/auth/realms/demo    |
       | OIDC_SECURE_DEPLOYMENT_ENABLE_CORS        | true                          |
       | OIDC_SECURE_DEPLOYMENT_BEARER_ONLY        | true                          |
       | GALLEON_PROVISION_CHANNELS|org.jboss.eap.channels:eap-8.0-beta |
       | GALLEON_PROVISION_LAYERS | cloud-server,elytron-oidc-client |
       | GALLEON_PROVISION_FEATURE_PACKS|org.jboss.eap:wildfly-ee-galleon-pack,org.jboss.eap.cloud:eap-cloud-galleon-pack |
    Then container log should contain WFLYSRV0010: Deployed "oidc-webapp-legacy.war"
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value keycloak on XPath //ns:provider/@name
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value oidc-webapp-legacy.war on XPath //*[local-name()='secure-deployment']/@name
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value true on XPath //*[local-name()='provider']/*[local-name()='enable-cors']
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value true on XPath //*[local-name()='secure-deployment'][@name="oidc-webapp-legacy.war"]/*[local-name()='bearer-only']
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value true on XPath //*[local-name()='secure-deployment'][@name="oidc-webapp-legacy.war"]/*[local-name()='enable-basic-auth'] 
    And XML file /opt/server/standalone/configuration/standalone.xml should contain value http://localhost:8080/auth/realms/demo on XPath //*[local-name()='provider']/*[local-name()='provider-url']