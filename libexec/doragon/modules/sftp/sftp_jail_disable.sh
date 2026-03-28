doragon_sftp_jail_disable() {
  _doragon_sftp_require_root jail-disable

  local user conf
  user="$(_doragon_sftp_user)"
  conf="/etc/ssh/sshd_config.d/doragon-sftp-${user}.conf"

  section "SFTP JAIL DISABLE"

  if [[ -f "$conf" ]]; then
    rm -f "$conf"
    info "[+] Removed SSH config"
  fi

  sshd -t
  systemctl restart sshd

  ok "SFTP jail disabled for ${user}"
}
