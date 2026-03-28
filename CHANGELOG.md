# Changelog

All notable changes to this project will be documented here.

## Doragon v1.0.9

### Added 

- Introduced diagnose + fix architecture for structured audit and remediation
- Added fix command system (doragon fix <target>)
- Implemented permission diagnostics for system-critical paths (sudo directories)
- Added remediation functions for automatic permission correction
- Extended SFTP control with improved ACL-based isolation handling
- Introduced structured issue reporting with actionable fix suggestions

### Changed
- Refactored CLI routing to support fix command alongside diagnose
- Improved command dispatching consistency between diagnose and fix layers
- Enhanced module interaction between audit and remediation components
- Refined SFTP behavior to avoid unsafe permission escalation patterns
- Improved internal handling of system checks and validation flow

### Improved
- More predictable system diagnostics with explicit WARN → FIX flow
- Cleaner separation between detection (diagnose) and action (fix)
- Improved runtime stability through better module loading consistency
- Enhanced security score accuracy and issue visibility
- Improved output clarity for system audits and recommendations

### Security
- Improved detection of insecure system permissions (sudo directories)
- Reduced risk of privilege escalation through better SFTP ACL handling
- Safer handling of filesystem access boundaries
- Enhanced visibility of security misconfigurations
- Strengthened audit-to-remediation workflow

### Internal
- Extended registry system to support fix command routing
- Improved loader behavior for nested module structures
- Reduced dependency issues between core and modules
- Standardized internal function naming and execution patterns
- Prepared foundation for automated remediation workflows

### Note
- This release introduces a major operational improvement:
  - diagnose → detect → fix
- Doragon is evolving from a diagnostic tool into a remediation-capable framework.

- This version focuses on:
  - system predictability 
  - controlled remediation 
  - security workflow clarity 

- It prepares the foundation for:
  - doragon fix all 
  - automated remediation flows 
  - policy enforcement layer 
  - advanced compliance auditing 
---

## Doragon v1.0.8

### Added

- Introduced **bootstrap layer** for clean initialization flow
- Added **registry-based CLI routing system** 
- Implemented **GDPR compliance audit command (`doragon gdpr`)** 
- Introduced **dynamic module loading system**
- Added **directory layout abstraction (`dirs.sh`)**

---

### Changed

- Refactored CLI entrypoint (`/usr/bin/doragon`) to be minimal and execution-focused 
- Migrated command routing logic from monolithic `case` into **registry system** 
- Reorganized internal architecture:
  - `core` → bootstrap + loader + registry
  - `modules` → feature-based separation 
- Improved execution flow:
  - bootstrap → verify → load → dispatch 
- Updated internal path handling for better portability 
- Standardized module loading order (core first, then modules)

---

### Improved

- Better modular separation between core and feature modules 
- Cleaner CLI execution with reduced overhead 
- More predictable and deterministic execution flow 
- Improved SFTP security handling (ACL-based control) 
- Enhanced diagnostics and status output consistency 

---

### Security

- Added **GDPR-oriented infrastructure audit layer**
- Improved detection of:
  - exposed services
  - insecure configurations
  - public-facing databases 
- Strengthened SFTP access control logic 

---

### Internal

- Introduced:
  - `bootstrap`
  - `loader.sh`
  - `registry`
- Removed hardcoded module sourcing in favor of dynamic loading 
- Prepared architecture for future binary compilation 
- Improved maintainability and extensibility of the framework 

---

### Notes

This release focuses on **architecture stabilization and modular design**.

It lays the foundation for:

- future binary builds 
- plugin system expansion 
- advanced diagnostics (Doragon FIX) 
- remote execution capabilities 

---


## Doragon v1.0.7

Internal improvements and security diagnostics.

Status improvements:
- Added TLS detection in doragon status
- Added OpenSSL version detection
- Added TLSv1.3 capability check
- Added crypto policy detection
- Added FIPS mode detection

TLS / Crypto audit:
- Detect TLS configuration from nginx
- Check Let's Encrypt certificates
- Certificate expiration detection

Nginx diagnostics:
- Detect nginx ssl_certificate paths
- Detect orphaned certificates (existing but unused)
- Detect missing certificates referenced by nginx

Framework improvements:
- Introduced modular directory structure
- Added dirs.sh for directory layout
- Added verify.sh for runtime checks
- Added loader.sh for module loading

General:
- Improved diagnostic output
- Better internal structure for future modules
"
---

## Doragon  v1.0.6

This release improves the integrated audit engine, status output, and reporting workflow.

### Added
- Security score engine
- Visual security score bar
- Security grade system (`SS`, `A+`, `A`, `B+`, `B`, `C`, `D`, `F`)
- Security assessment messages
- Top Issues detection
- Next Actions recommendations
- Shared audit module: `audit/security_score.sh`

### Improved
- SSH audit is now integrated into `doragon status`
- Status output is more structured and easier to read
- Security score is now reused by both status and report flows
- Report JSON structure is better aligned for future panel integration

### Reporting
- `doragon report --json`
- `doragon report --json --pretty`
- `doragon report --out <dir>`
- automatic output directory creation

### Output example
```text
SECURITY SCORE
Score: ███████████████████░ 95/100
Grade: A
Status: WARN
Assessment: Strong security baseline with minor adjustments recommended.


---

## v1.0.5

### Added

- Modular Fail2Ban command architecture
- Fail2Ban engine helpers
- Dedicated `lib/f2b` module structure

### Improved

- CLI routing modularization
- Maintainability of command handlers

---

## v1.0.4

- Core status improvements
- Reporting adjustments

---

## v1.0.3

- Initial modular CLI structure
