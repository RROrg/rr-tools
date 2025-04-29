#!/usr/bin/env bash
#
# Copyright (C) 2022 Ing <https://github.com/wjz304>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

addblocklog() {
  [ -z "${1}" ] && return 1
  FNAME="f_$(echo "${1}" | sed 's/[^a-zA-Z0-9]/_/g' | sed 's/.*/\L&/' | cut -c 1-30)"
  REGEX="${1}"
  mkdir -p "${SYSLOG_NG_PATH}"
  sed -i "/${FNAME}/d" "${SYSLOG_NG_PATH}/RRU.conf" 2>/dev/null
  # shellcheck disable=SC2059
  printf "filter ${FNAME} { match(\"${REGEX}\" value(\"MESSAGE\")); };\nlog { source(src); filter(${FNAME}); flags(final); };\n" >>"${SYSLOG_NG_PATH}/RRU.conf"
  chown system:log "${SYSLOG_NG_PATH}/RRU.conf"
  chmod 644 "${SYSLOG_NG_PATH}/RRU.conf"

  for D in not2kern not2msg; do
    mkdir -p "${SYSLOG_NG_PATH}/include/${D}"
    sed -i "/${FNAME}/d" "${SYSLOG_NG_PATH}/include/${D}/RRU_${D}.conf" 2>/dev/null
    echo "and not filter(${FNAME})" >>"${SYSLOG_NG_PATH}/include/${D}/RRU_${D}.conf"
    chown system:log "${SYSLOG_NG_PATH}/include/${D}/RRU_${D}.conf"
    chmod 644 "${SYSLOG_NG_PATH}/include/${D}/RRU_${D}.conf"
  done
}

delblocklog() {
  [ -z "${1}" ] && return 1
  if echo "all *" | grep -wq "${1}"; then
    rm -f "${SYSLOG_NG_PATH}/RRU.conf"
    for D in not2kern not2msg; do
      rm -f "${SYSLOG_NG_PATH}/include/${D}/RRU_${D}.conf"
    done
  else
    FNAME="f_$(echo "${1}" | sed 's/[^a-zA-Z0-9]/_/g' | sed 's/.*/\L&/' | cut -c 1-30)"
    sed -i "/${FNAME}/d" "${SYSLOG_NG_PATH}/RRU.conf" 2>/dev/null
    for D in not2kern not2msg; do
      sed -i "/${FNAME}/d" "${SYSLOG_NG_PATH}/include/${D}/RRU_${D}.conf" 2>/dev/null
    done
  fi
}

getblocklog() {
  grep -Eo "filter.*match.*" "${SYSLOG_NG_PATH}/RRU.conf" 2>/dev/null | sed 's/filter \(.*\) { match(\(.*\) value("MESSAGE")); };/\1=\2/'
}

usage() {
  {
    NAME="$(basename "${0}" 2>/dev/null)"
    echo "${NAME} v1.0.0 by Ing <https://github.com/RROrg>"
    echo ""
    echo "Usage: ${NAME} {add|del|get} \"<regex>\""
    echo "Example:"
    echo "  ${NAME} add \"Fail to get power limit.*\"    add a block log"
    echo "  ${NAME} del \"Fail to get power limit.*\"    delete a block log"
    echo "  ${NAME} get                                get all block logs" # miss 2 space of \"\"
  } >&2
}

#####

if [ ! "${USER}" = "root" ]; then
  echo "Please run as root"
  exit 9
fi

SYSLOG_NG_PATH="${ROOT_PATH}/etc/syslog-ng/patterndb.d"

case "${1}" in
add)
  [ -z "${2}" ] && usage && exit 1
  addblocklog "${2}"
  systemctl restart syslog-ng
  ;;
del)
  [ -z "${2}" ] && usage && exit 1
  delblocklog "${2}"
  systemctl restart syslog-ng
  ;;
get)
  getblocklog
  ;;
*)
  usage
  exit 1
  ;;
esac
