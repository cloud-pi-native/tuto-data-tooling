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
