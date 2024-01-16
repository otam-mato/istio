# templates/_helpers.tpl
{{- define "mychart.passwordSecret" -}}
{{ printf "new-mysql-secret%s" (randAlphaNum 10) | quote }}
{{- end -}}

