.DEFAULT_GOAL := init

init:
	cd scripts && bash init-cfg.sh && sleep 2 && \
	bash init-shards.sh && sleep 2 && \
	bash init-routers.sh && sleep 2 && \
	bash check-shards.sh

check:
	cd scripts && bash check-shards.sh
