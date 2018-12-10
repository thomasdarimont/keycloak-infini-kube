FROM jboss/keycloak:4.7.0.Final

COPY modules/system/layers/base/org/jgroups/kubernetes/main/ $JBOSS_HOME/modules/system/layers/base/org/jgroups/kubernetes/main/
COPY tools/jgroups.sh tools/jgroups.sh

ENV KUBERNETES_NAMESPACE default
ENV KUBERNETES_SERVICE_HOST kubernetes.$KUBERNETES_NAMESPACE.svc
ENV KUBERNETES_SERVICE_PORT 443

# comman separated list of labels
# := is replaced with =
ENV KUBERNETES_LABELS "app:=keycloak"

ENV JGROUPS_DISCOVERY_PROTOCOL kubernetes.KUBE_PING
ENV JGROUPS_DISCOVERY_PROPERTIES "port_range=1,namespace=$KUBERNETES_NAMESPACE,labels=$KUBERNETES_LABELS,masterHost=$KUBERNETES_SERVICE_HOST,masterPort=$KUBERNETES_SERVICE_PORT"
