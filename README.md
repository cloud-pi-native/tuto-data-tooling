# TCNP
Traitement de correspondances des Noms et Prénoms

TCNP fournit une API REST afin d'interroger une base de données des changements noms/prénoms en lien avec la loi Vignal

# Gestion des secrets
Les secrets sont chiffrés avec SOPS, un exemple:

```bash
export AGE_KEY=age1aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
export AGE_KEY_AOT=age1bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb

sops -e --age $AGE_KEY,$AGE_KEY_AOT --encrypted-suffix Templates secret-data-loader.sops-mi.yml > secret.sops-mi.enc
```

Pour déchiffrer le fichier:
```bash
sops --decrypt --output-type yaml --input-type yaml secret.sops-mi.enc
```

## Scripts
### Chiffrement
Un script existe dans le dossier `environments` pour plus de commodité dans le chiffrement des fichiers.
Le script parcourt le dossier et ses sous-dossiers courants (ou celui passé en paramètre), cibles les fichiers avec l'extension `.dec` et les chiffres en les sauvegardant avec l'extension `.enc`

#### Utilisation du script
Prenons l'arborescence suivante: 
```
test/
  encrypt.sh
  ovh/
    dev/
       secrets.yml.dec
       other_secrets.yml.dec
  mi/
    pprod/secrets.yml.dec
```

Exemple sans argument:
```
bash encrypt.sh
```
Chiffre les fichiers suivants:
- ovh/dev/secrets.yml.dec
- ovh/dev/other_secrets.yml.dec
- mi/pprod/secrets.yml.dec

Exemple avec un dossier comme argument:
```
bash encrypt.sh ovh
```
Chiffre les fichiers suivants:
- ovh/dev/secrets.yml.dec
- ovh/dev/other_secrets.yml.dec

Exemple avec un fichier comme argument:
```
bash encrypt.sh ovh/dev/secrets.yml.dec
```
Chiffre les fichiers suivants:
- ovh/dev/secrets.yml.dec


### Déchiffrement
Pour déchiffrer, un exemple de script possible:
```bash
#!/bin/bash

# Exemple du fichier ${HOME}/.config/sops/age/keys.txt
# Les 2 1ère lignes sont en commentaire dans le fichier (created at et public key)
############## 
# # created: 2023-12-14T14:04:44+01:00
# # public key: age1jr2xwgg4chqqptvusk6efrfjxqaaaahhsy95jswnd4eeqchyps8qc3aaaa
# AGE-SECRET-KEY-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
##############

PRIVATE_KEY_LOCATION="${HOME}/.config/sops/age/keys.txt"
EXEMPLE_PRIVATE_KEY="""
# created: 2023-12-14T14:04:44+01:00\n
# public key: ageaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\n
AGE-SECRET-KEY-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
"""

if [ ! -e ${PRIVATE_KEY_LOCATION} ]; then
  echo "Ajouter la clé pour déchiffrer dans ${PRIVATE_KEY_LOCATION} avec le contenu suivant (exemple):"
  echo "Voir exemple dans les commentaires du script:"
  echo -e ${EXEMPLE_PRIVATE_KEY}
  exit 1
else
  sops --decrypt --output-type yaml --input-type yaml $1
fi
```

Ce script prend en entrée un fichier chiffré et affiche le contenu déchiffré sur sa sortie standard
