#!/bin/bash

# Script permettant de chiffrer des manifest kubernetes via SOPS
# Le script parcourt le dossier courant et sous-dossiers pour trouver des fichiers avec l'extension .dec
# Les fichiers chiffrés sont sauvegardés avec l'extension .enc au lieu de .dec
# Il est possible de passer un argument pour changer le dossier courant, voir de donner un chemin vers un fichier
# test/
#   encrypt.sh
#   ovh/
#     dev/
#        secrets.yml.dec
#        other_secrets.yml.dec
#   mi/
#     pprod/secrets.yml.dec
#
# bash encrypt.sh => ovh/dev/secrets.yml.dec , ovh/dev/other_secrets.yml.dec , mi/pprod/secrets.yml.dec
# bash encrypt.sh ovh => ovh/dev/secrets.yml.dec , ovh/dev/other_secrets.yml.dec
# bash encrypt.sh ovh/dev/secrets.yml.dec => ovh/dev/secrets.yml.dec
#

export AGE_KEY=age1g867s7tcftkgkdraz3ezs8xk5c39x6l4thhekhp9s63qxz0m7cgs5kan9a
export AGE_KEY_AOT=age1jr2xwgg4chqqptvusk6efrfjxq44n4hhsy95jswnd4eeqchyps8qc3mtfx
export AGE_KEY_PPROD=age1lxduvqtglrdj38m27gsa4akdu82keqwgh7r57ep3dcwf7uaref4qtafwy5
export AGE_KEY_PROD=age190waxlxyv9l0s5ec8600u7ujknrugffz6fjxde8tndy9gw68rckstws8dp

encrypt_path="."

if [ $# -gt 0 ]; then
  if [ -d "$1" ]; then
    encrypt_path="$1"
  elif [ -f "$1" ]; then
    encrypt_path="$1"
  else
    echo "Chemin non existant"
    exit 1
  fi
fi

for current_file in $(find ${encrypt_path} -name *.dec)
do
  filename="${current_file%.*}"
  extension="${current_file##*.}"

  if [ $extension == "dec" ]; then
    encrypted_file_path="${filename}.enc"
    echo "Encrypt file ${current_file} to ${encrypted_file_path}"
    sops -e --age $AGE_KEY,$AGE_KEY_AOT,$AGE_KEY_PPROD,$AGE_KEY_PROD --input-type yaml --output-type yaml --encrypted-suffix Templates "${current_file}" > "${encrypted_file_path}"
  fi
done
