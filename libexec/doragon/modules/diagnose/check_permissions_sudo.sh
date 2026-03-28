doragon_diagnose_sudo_permissions() {
  section "CHECK SUDO PERMISSIONS"

  local check_permission_sudo="missing"
  local check_permission_sudo_lectured="missing"
  local missing_dir_sudo=0
  local missing_file_sudo_lectured=0
  local has_issue=0

  if [[ -d /var/db/sudo ]]; then
    check_permission_sudo="$(stat -c '%a' /var/db/sudo 2>/dev/null || echo 'unknown')"
  else
    missing_dir_sudo=1
    has_issue=1
  fi

  if [[ -e /var/db/sudo/lectured ]]; then
    check_permission_sudo_lectured="$(stat -c '%a' /var/db/sudo/lectured 2>/dev/null || echo 'unknown')"
  else
    missing_file_sudo_lectured=1
    has_issue=1
  fi

  info "/var/db/sudo"
  if (( missing_dir_sudo == 1 )); then
    warn "Sudo dir missing"
  elif [[ "$check_permission_sudo" == "700" ]]; then
    ok "Sudo dir secure: (${check_permission_sudo})"
  else
    warn "Sudo dir insecure: (${check_permission_sudo})"
    has_issue=1
  fi

  echo
  info "/var/db/sudo/lectured"
  if (( missing_file_sudo_lectured == 1 )); then
    warn "Sudo lectured file missing"
  elif [[ "$check_permission_sudo_lectured" == "600" ]]; then
    ok "Sudo lectured secure: (${check_permission_sudo_lectured})"
  else
    warn "Sudo lectured insecure: (${check_permission_sudo_lectured})"
    has_issue=1
  fi

  if (( has_issue == 1 )); then
    echo
    info "FIX: doragon fix sudo"
  fi

  echo
}


doragon_fix_check_permissions_sudo() {
  section "FIX CHECK PERMISSIONS"

  [[ -d /var/db/sudo ]] || mkdir -p /var/db/sudo
  [[ -e /var/db/sudo/lectured ]] || touch /var/db/sudo/lectured

  chmod 700 /var/db/sudo
  chmod 600 /var/db/sudo/lectured
  chown root:root /var/db/sudo /var/db/sudo/lectured

  ok "Sudo permissions fixed"
}
