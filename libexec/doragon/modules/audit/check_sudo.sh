doragon_check_sudo_permissions() {

  section "CHECK SUDO PERMISSIONS"

  if  [[ "$(stat -c '%a' /var/db/sudo 2>/dev/null)" == "700" ]]; then
      ok "Sudo dir secure"
  else
      warn "Sudo dir insecure"
  fi

  if  [[ "$(stat -c '%a' /var/db/sudo/lectured 2>/dev/null)" == "600" ]]; then
      ok "Sudo lecture file secure"
  else
      warn "Sudo lecture file insecure"
  fi

}
