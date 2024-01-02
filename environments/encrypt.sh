#!/bin/bash
export AGE_KEY=age1g867s7tcftkgkdraz3ezs8xk5c39x6l4thhekhp9s63qxz0m7cgs5kan9a
export AGE_KEY_AOT=age1jr2xwgg4chqqptvusk6efrfjxq44n4hhsy95jswnd4eeqchyps8qc3mtfx
export AGE_KEY_PPROD=age1lxduvqtglrdj38m27gsa4akdu82keqwgh7r57ep3dcwf7uaref4qtafwy5
export AGE_KEY_PROD=age190waxlxyv9l0s5ec8600u7ujknrugffz6fjxde8tndy9gw68rckstws8dp

for current_file in $(find . -name *.dec)
do
  filename="${current_file%.*}"
  extension="${current_file##*.}"

  if [ $extension == "dec" ]; then
    encrypted_file_path="${filename}.enc"
    echo "Encrypt file ${current_file} to ${encrypted_file_path}"
    sops -e --age $AGE_KEY,$AGE_KEY_AOT,$AGE_KEY_PPROD,$AGE_KEY_PROD --input-type yaml --output-type yaml --encrypted-suffix Templates "${current_file}" > "${encrypted_file_path}"
  fi
done
