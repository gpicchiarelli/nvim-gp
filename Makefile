PREFIX ?= $(HOME)/.config/nvim

.PHONY: install bootstrap update health diagnose backup profile validate
.PHONY: bootstrap-debian

install:
	./scripts/install.sh

bootstrap:
	./scripts/bootstrap_macports.sh

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
