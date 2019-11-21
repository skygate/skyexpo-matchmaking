#!/usr/bin/env bash

TMP_FILE=/tmp/docker-compose.$$.yaml

finish() {
  rm ${TMP_FILE} ${TMP_FILE}.tmp 2>/dev/null
}

trap finish EXIT

compose-config() {
  mv -f ${TMP_FILE} ${TMP_FILE}.tmp
  docker-compose -f ${1} -f ${TMP_FILE}.tmp config > ${TMP_FILE}

  rm -f ${TMP_FILE}.tmp 2>/dev/null
}

args=()
files=()

while :; do
  getopts ":" opt
  case $OPTARG in
    f) files+=(${!OPTIND})
    ;;
    ?) args+=("-${OPTARG}" "${!OPTIND}")
    ;;
    *) args+=("${!OPTIND}")
    ;;
  esac

  ((OPTIND++))
  [ $OPTIND -gt $# ] && break
done

echo 'version: "3.7"' > ${TMP_FILE}

for f in ${files[@]}; do
  compose-config ${f}
done

docker-compose -f ${TMP_FILE} ${args[@]}
exit $?
