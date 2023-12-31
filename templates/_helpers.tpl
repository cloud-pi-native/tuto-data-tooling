{{/*
Expand the name of the chart.
*/}}
{{- define "data-tool.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "data-tool.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "data-tool.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "data-tool.labels" -}}
helm.sh/chart: {{ include "data-tool.chart" . }}
{{ include "data-tool.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app: {{ include "data-tool.name" . }}
env: {{ .Values.environnement }}
phase: {{ .Values.phase }}
{{- end }}

{{- define "tcnp.labels.pgrest" -}}
tier: backend
component: postgrest
{{- end }}

{{- define "tcnp.labels.dataloader" -}}
tier: backend
component: dataloader
{{- end }}

{{- define "tcnp.labels.blackbox" -}}
tier: monitoring
component: prometheus-blackbox
{{- end }}

{{- define "tcnp.labels.swagger" -}}
tier: api
component: swagger
{{- end }}

{{/*
Selector labels
*/}}
{{- define "data-tool.selectorLabels" -}}
app.kubernetes.io/name: {{ include "data-tool.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "data-tool.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "data-tool.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
