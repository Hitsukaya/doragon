# ============================================================
# Doragon Framework - Module Loader
# Loads core modules and feature modules
# ============================================================

# LIB DIR
LIB_DIR="/usr/libexec/doragon/lib"

# DIR F2B AUDIT SVC Diagnose
F2B_DIR="${LIB_DIR}/f2b"
AUDIT_DIR="${LIB_DIR}/audit"
SVC_DIR="${LIB_DIR}/svc"
DIAGNOSE_DIR="${LIB_DIR}/diagnose"

# Source Doragon Lib
source "${LIB_DIR}/common.sh"
source "${LIB_DIR}/checks.sh"
source "${LIB_DIR}/report.sh"
source "${LIB_DIR}/fail2ban.sh"
source "${LIB_DIR}/selinux.sh"
source "${LIB_DIR}/firewall.sh"
source "${LIB_DIR}/network.sh"
source "${LIB_DIR}/services.sh"
source "${LIB_DIR}/helper.sh"
source "${LIB_DIR}/sftp.sh"
source "${LIB_DIR}/config.sh"
source "${LIB_DIR}/discord.sh"
source "${LIB_DIR}/status.sh"

# Source Doragon Audit
source "${AUDIT_DIR}/system.sh"
source "${AUDIT_DIR}/database.sh"
source "${AUDIT_DIR}/network.sh"
source "${AUDIT_DIR}/ssh.sh"
source "${AUDIT_DIR}/security_score.sh"
source "${AUDIT_DIR}/tls.sh"

# Source Doragon F2B
source "${F2B_DIR}/engine_f2b.sh"
source "${F2B_DIR}/status.sh"
source "${F2B_DIR}/nginx-errors.sh"
source "${F2B_DIR}/tail.sh"
source "${F2B_DIR}/bans.sh"
source "${F2B_DIR}/unban_global.sh"
source "${F2B_DIR}/unban_jail.sh"
source "${F2B_DIR}/unban_set.sh"

# Source Doragon SVC
source "${SVC_DIR}/status.sh"
source "${SVC_DIR}/reload.sh"
source "${SVC_DIR}/restart.sh"
source "${SVC_DIR}/start.sh"
source "${SVC_DIR}/stop.sh"
source "${SVC_DIR}/enable.sh"
source "${SVC_DIR}/disable.sh"

# Source Doragon Diagnose
source "${DIAGNOSE_DIR}/diagnose.sh"
source "${DIAGNOSE_DIR}/nginx.sh"
