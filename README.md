# Generation des secrets

Pour générer les secrets, aller dans le répertoire sops puis :

$ sops -e --age $AGE_KEY,$AGE_KEY_AOT --encrypted-suffix Templates secret-data-loader.sops-mi.yml > secret.sops-mi.enc        

$ sops -e --age $AGE_KEY,$AGE_KEY_AOT --encrypted-suffix Templates secret-data-loader.sops-ovh.yml > secret.sops-ovh.enc