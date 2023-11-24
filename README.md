# Chart Helm d'outils postgres

## Présentation


## Mode opératoire


En cas d'ajout de table, il faut relancer le script :
GRANT SELECT,INSERT,UPDATE,DELETE ON ALL TABLES IN SCHEMA public TO {{ .Values.pgrest.anonRole }}

ou GRANT SELECT,INSERT,UPDATE,DELETE ON ALL TABLES IN SCHEMA public TO anon

Puis relancer le pod postgrest

> __Notes__: Certains mots de passe doivent être générés et placés dans le fichier [values.yaml](./values.yaml)
> Pour générer un mot de passe random vous pouvez utiliser la commande '`openssl rand -base64 12`'.