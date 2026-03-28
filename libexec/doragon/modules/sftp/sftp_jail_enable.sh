doragon_sftp_jail_enable() {
  _doragon_sftp_require_root jail-enable

  local user jail
  user="$(_doragon_sftp_user)"
  jail="/home/${user}"

  section "SFTP JAIL ENABLE"

  info "[+] Preparing jail: $jail"

  mkdir -p "$jail"
  chown root:root "$jail"
  chmod 755 "$jail"

  mkdir -p "$jail/data"
  chown "$user:$user" "$jail/data"

  local conf="/etc/ssh/sshd_config.d/doragon-sftp-${user}.conf"

  info "[+] Writing SSH config: $conf"

  cat > "$conf" <<EOF
Match User ${user}
    ChrootDirectory ${jail}
    ForceCommand internal-sftp
    AllowTcpForwarding no
    X11Forwarding no
EOF

  chmod 600 "$conf"

  info "[+] Validating sshd config"
  sshd -t

  info "[+] Restarting sshd"
  systemctl restart sshd

  ok "SFTP jail enabled for ${user}"
}
