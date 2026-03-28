_doragon_sftp_mount_path() {
  local target user jail_root data_dir
  target="$(_doragon_sftp_target)"
  user="$(_doragon_sftp_user)"

  jail_root="/home/${user}"
  data_dir="${jail_root}/data"

  echo "${data_dir}/$(basename "$target")"
}

 # Reads /etc/doragon/sftp.conf if doragon_load_config exists (from config.sh)
_doragon_sftp_load_config() {
  if declare -F doragon_load_config >/dev/null 2>&1; then
    doragon_load_config || true
  fi
}

_doragon_sftp_target() {
  _doragon_sftp_load_config
  [[ -n "${DORAGON_SFTP_TARGET:-}" ]] || die "DORAGON_SFTP_TARGET not set. Run: doragon sftp config --user <user> --target <path>"
  echo "$DORAGON_SFTP_TARGET"
}

_doragon_sftp_user() {
  _doragon_sftp_load_config
  [[ -n "${DORAGON_SFTP_USER:-}" ]] || die "DORAGON_SFTP_USER not set. Run: doragon sftp config --user <user> --target <path>"
  echo "$DORAGON_SFTP_USER"
}

doragon_sftp_config_set() {
  local user="" target=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --user)   user="${2:-}"; shift 2;;
      --target) target="${2:-}"; shift 2;;
      -h|--help|"")
        die "Usage: doragon sftp config --user <user> --target <path>"
        ;;
      *)
        die "Unknown option: $1 (Usage: doragon sftp config --user <user> --target <path>)"
        ;;
    esac
  done

  [[ -z "$user" || -z "$target" ]] && die "Usage: doragon sftp config --user <user> --target <path>"

  _doragon_sftp_require_root config --user "$user" --target "$target"

  # safety checks (recommended)
  id "$user" >/dev/null 2>&1 || die "User does not exist: $user"
  [[ -d "$target" ]] || die "Target directory does not exist: $target"
  [[ "$target" != "/" ]] || die "Refusing to use '/' as target"
  [[ -n "$target" ]] || die "Target cannot be empty"

  mkdir -p /etc/doragon

  local conf="/etc/doragon/sftp.conf"
  local tmp
  tmp="$(mktemp)"

  # Backup if file exists
  if [[ -f "$conf" ]]; then
    cp -a "$conf" "${conf}.bak-$(date +%Y%m%d-%H%M%S)"
  else
    # create a minimal header if new
    cat > "$conf" <<'EOF'

EOF
  fi

  awk -v new_target="$target" -v new_user="$user" '
    BEGIN { found_target=0; found_user=0 }
    {
      if ($0 ~ /^[[:space:]]*DORAGON_SFTP_TARGET=/) { print "DORAGON_SFTP_TARGET=\"" new_target "\""; found_target=1; next }
      if ($0 ~ /^[[:space:]]*DORAGON_SFTP_USER=/)   { print "DORAGON_SFTP_USER=\"" new_user "\"";     found_user=1; next }
      print $0
    }
    END {
      if (!found_target || !found_user) {
        print ""
        print "# SFTP"
        if (!found_target) print "DORAGON_SFTP_TARGET=\"" new_target "\""
        if (!found_user)   print "DORAGON_SFTP_USER=\"" new_user "\""
      }
    }
  ' "$conf" > "$tmp"

  mv -f "$tmp" "$conf"
  chmod 0600 "$conf"

  ok "Saved SFTP config to /etc/doragon/sftp.conf (updated keys only)"
  info "DORAGON_SFTP_TARGET=${target}"
  info "DORAGON_SFTP_USER=${user}"
}

