#!/usr/bin/env bash
set -euo pipefail

doragon_sftp_usage() {
  cat <<'USAGE'
SFTP toggle:
  doragon sftp on
  doragon sftp off
  doragon sftp jail-enable
  doragon sftp jail-disable
  doragon sftp status
  doragon sftp config --user <user> --target <path>

Config:
  Uses /etc/doragon/sftp.conf:
    DORAGON_SFTP_TARGET="/home/user/"
    DORAGON_SFTP_USER="user"

Overrides:
  You can still override via environment variables:
    DORAGON_SFTP_TARGET=/path
    DORAGON_SFTP_USER=user

Notes:
  - 'on/off/config' require root (Doragon will sudo automatically).
USAGE
}

_doragon_sftp_require_root() {
  if [[ $EUID -ne 0 ]]; then
    info "Doragon SFTP module requires root privileges."
    info "SSH configuration can only be modified by root."
    info "Re-run with: sudo doragon sftp ${sub} $*"
    exec sudo "$0" sftp "$@"
  fi
}

doragon_sftp_cmd() {
  local sub="${1:-}"
  shift || true

  case "$sub" in
    on) doragon_sftp_on ;;
    off) doragon_sftp_off ;;
    status) doragon_sftp_status ;;
    config) doragon_sftp_config_set "$@" ;;
    jail-enable) doragon_sftp_jail_enable ;;
    jail-disable) doragon_sftp_jail_disable ;;
    -h|--help|"") doragon_sftp_usage ;;
    *)
      die "Unknown sftp command: $sub. Run: doragon sftp --help"
      ;;
  esac
}
