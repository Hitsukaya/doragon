#!/usr/bin/env bash
set -euo pipefail

doragon_sftp_status() {

   section "SFTP MOUNT STATUS"

   mount="$(_doragon_sftp_mount_path)"

   if mountpoint -q "$mount"; then
     info "Target exposed at: $mount"
   else
     info "Target NOT exposed"
   fi

}
