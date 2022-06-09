{{/*
Return the proper image name
*/}}
{{- define "backstage.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.backstage.image "global" .Values.global) }}
{{- end -}}
