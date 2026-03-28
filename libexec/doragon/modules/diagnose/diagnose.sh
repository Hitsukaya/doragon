#!/usr/bin/env bash
set -euo pipefail

doragon_diagnose_usage() {
    cat <<'USAGE'
Usage:
  doragon diagnose <target>

  doragon diagnose nginx
  doragon diagnose tls
  doragon diagnose database
  doragon diagnose sudo

USAGE
}

doragon_diagnose_cmd() {
  local target="${1:-}"
  shift || true

  case "$target" in
    nginx)
      doragon_diagnose_nginx_certs "$@"
      ;;
    tls)
      doragon_diagnose_tls "$@"
      ;;
    database|db)
      doragon_diagnose_database "$@"
      ;;
    check_permissions|sudo)
      doragon_diagnose_sudo_permissions "$@"
      ;;
    -h|help|--help|"")
      doragon_diagnose_usage
      ;;
    *)
      die "[ERR] Unknown diagnose target: $target. Run: doragon diagnose --help"
      ;;
  esac
}


doragon_diagnose_fix_cmd() {
  local target="${1:-}"
  shift || true

  case "$target" in
    check_permissions|sudo)
      doragon_fix_check_permissions_sudo "$@"
      ;;
    *)
      die "[ERR] Unknown fix target: $target. Run: doragon fix --help"
      ;;
  esac
}
