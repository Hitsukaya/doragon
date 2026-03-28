doragon_sftp_off() {
  _doragon_sftp_require_root off

  local target user mount
  target="$(_doragon_sftp_target)"
  user="$(_doragon_sftp_user)"
  mount="$(_doragon_sftp_mount_path)"

  section "SFTP OFF"

  info "[-] Removing ACL"
  setfacl -R -x "u:${user}" "$target"
  setfacl -R -k "$target"

  if mountpoint -q "$mount"; then
    info "[-] Unmounting ${mount}"
    umount "$mount"
  fi

  rmdir "$mount" 2>/dev/null || true

  ok "SFTP TARGET HIDDEN"
  warn "SFTP disabled. System permissions may have changed."
  info "Run: doragon diagnose sudo | doragon fix sudo"
}
