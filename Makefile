PREFIX ?= $(HOME)/.config/nvim

.PHONY: install bootstrap ensure-macports update health diagnose backup profile validate lint smoke test format
.PHONY: bootstrap-debian

install:
	./scripts/install.sh

bootstrap:
	./scripts/bootstrap_macports.sh

ensure-macports:
	./scripts/ensure_macports.sh

bootstrap-debian:
	./scripts/bootstrap_debian.sh

update:
	./scripts/update.sh

health:
	./scripts/health-check.sh

diagnose:
	./scripts/diagnostica.sh

backup:
	./scripts/backup.sh

profile:
	nvim --startuptime startup.log +qa

validate:
	./scripts/validate.sh

lint:
	./scripts/lint.sh

smoke:
	./scripts/smoke.sh

test:
	./scripts/test.sh

format:
	./scripts/format.sh
