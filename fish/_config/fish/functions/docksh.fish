function docksh  --description 'Open a shell in docker container'
	docker exec -it $argv[1] /bin/bash
end
