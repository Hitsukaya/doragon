doragon_sftp_on() {
  _doragon_sftp_require_root on

  local target user mount
  target="$(_doragon_sftp_target)"
  user="$(_doragon_sftp_user)"
  mount="$(_doragon_sftp_mount_path)"

  section "SFTP ON"

  info "[+] Mounting ${target} -> ${mount}"

  mkdir -p "$mount"

  if ! mountpoint -q "$mount"; then
    mount --bind "$target" "$mount"
  fi

  info "[+] Applying ACL"
  setfacl -R -m "u:${user}:rwx" "$target"
  setfacl -R -d -m "u:${user}:rwx" "$target"

  ok "SFTP TARGET EXPOSED"
}
