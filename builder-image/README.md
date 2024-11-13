
Build with docker:

* JDK11: `cekit --redhat build docker`
* JDK17: `cekit --redhat build --overrides image-jdk17-overrides.yaml docker`
* JDK21: `cekit --redhat build --overrides image-jdk21-overrides.yaml podman`

Build with OSBS:

* JDK11: `cekit --redhat build --overrides rh-jdk11-overrides.yaml osbs`
* JDK17: `cekit --redhat build --overrides image-jdk17-overrides.yaml --overrides rh-jdk17-overrides.yaml osbs`
* JDK21: `cekit --redhat build --overrides image-jdk21-overrides.yaml --overrides rh-jdk21-overrides.yaml osbs`