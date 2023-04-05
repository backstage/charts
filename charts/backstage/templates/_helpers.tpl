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
{{- if .Values.postgresql.enabled -}}
    {{- if eq .Values.postgresql.architecture "replication" }}
        {{- include "backstage.postgresql.fullname" . -}}-primary
    {{- else -}}
        {{- include "backstage.postgresql.fullname" . -}}
    {{- end -}}
{{- else if .Values.externalPostgresql.enabled -}}
    {{- required `property "externalPostgresql.host" must be set` .Values.externalPostgresql.host  -}}
{{- end -}}
{{- end -}}

{{/*
Return the Postgres Database port
*/}}
{{- define "backstage.postgresql.port" -}}
{{- if .Values.postgresql.enabled -}}
    {{- default 5432 .Values.postgresql.containerPorts.postgresql -}}
{{- else if .Values.externalPostgresql.enabled -}}
    {{- default 5432 .Values.externalPostgresql.port  -}}
{{- end -}}
{{- end -}}

{{/*
Return the Postgres Database Username
*/}}
{{- define "backstage.postgresql.username" -}}
{{- if .Values.postgresql.enabled -}}
    {{- default "backstage" .Values.postgresql.auth.username -}}
{{- else if .Values.externalPostgresql.enabled -}}
    {{- default "backstage" .Values.externalPostgresql.username  -}}
{{- end -}}
{{- end -}}

{{/*
Return the Postgres Database Secret Name
*/}}
{{- define "backstage.postgresql.databaseSecretName" -}}
{{- if .Values.postgresql.enabled }}
    {{- if .Values.postgresql.auth.existingSecret }}
        {{- tpl .Values.postgresql.auth.existingSecret $ -}}
    {{- else -}}
        {{- include "backstage.postgresql.fullname" . -}}
    {{- end -}}
{{- else if .Values.externalPostgresql.enabled -}}
    {{- required `property "externalPostgresql.passwordSecret" must be set` .Values.externalPostgresql.passwordSecret -}}
{{- end -}}
{{- end -}}

{{/*
Return the Postgres databaseSecret key to retrieve credentials for database
*/}}
{{- define "backstage.postgresql.databaseSecretKey" -}}
{{- if .Values.postgresql.enabled }}
    {{- if .Values.postgresql.auth.existingSecret -}}
        {{- .Values.postgresql.auth.secretKeys.userPasswordKey  -}}
    {{- else -}}
        {{- "password" -}}
    {{- end -}}
{{- else if .Values.externalPostgresql.enabled -}}
    {{- default "password" .Values.externalPostgresql.passwordSecretKey -}}
{{- end -}}
{{- end -}}
