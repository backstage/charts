{{/*
Return the proper image name
*/}}
{{- define "backstage.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.backstage.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "backstage.renderImagePullSecrets" -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list .Values.backstage.image) "context" $) -}}
{{- end -}}

{{/*
 Create the name of the service account to use
 */}}
{{- define "backstage.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "backstage.postgresql.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "postgresql" "chartValues" .Values.postgresql "context" $) -}}
{{- end -}}

{{/*
Return the Postgres Database hostname
*/}}
{{- define "backstage.postgresql.host" -}}
{{- if eq .Values.postgresql.architecture "replication" }}
{{- include "backstage.postgresql.fullname" . -}}-primary
{{- else -}}
{{- include "backstage.postgresql.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Return the Postgres Database Secret Name
*/}}
{{- define "backstage.postgresql.databaseSecretName" -}}
{{- if ((((.Values).global).postgresql).auth).existingSecret }}
    {{- tpl .Values.global.postgresql.auth.existingSecret $ -}}
{{- else if .Values.postgresql.auth.existingSecret }}
    {{- tpl .Values.postgresql.auth.existingSecret $ -}}
{{- else -}}
    {{- default (include "backstage.postgresql.fullname" .) (tpl .Values.postgresql.auth.existingSecret $) -}}
{{- end -}}
{{- end -}}

{{/*
Return the Postgres databaseSecret key to retrieve credentials for database
*/}}
{{- define "backstage.postgresql.databaseSecretKey" -}}
{{- $defaultDatabaseSecretKey := "password" -}}
{{- if (or ((((.Values).global).postgresql).auth).existingSecret .Values.postgresql.auth.existingSecret) }}
    {{- if (((((.Values).global).postgresql).auth).secretKeys).userPasswordKey -}}
        {{- .Values.global.postgresql.auth.secretKeys.userPasswordKey  -}}
    {{- else if ((((.Values).postgresql).auth).secretKeys).userPasswordKey -}}
        {{- .Values.postgresql.auth.secretKeys.userPasswordKey  -}}
    {{- else -}}
        {{- print $defaultDatabaseSecretKey -}}
    {{- end -}}
{{- else -}}
    {{- print $defaultDatabaseSecretKey -}}
{{- end -}}
{{- end -}}
