doragon_verify_dirs() {
    local dir

    for dir in \
        "$LIB_DIR" \
        "$AUDIT_DIR" \
        "$F2B_DIR" \
        "$SVC_DIR" \
        "$DIAGNOSE_DIR"
    do
        [[ -d "$dir" ]] || {
            echo "[ERR] missing dir: $dir" >&2
            return 1
        }
    done
}
