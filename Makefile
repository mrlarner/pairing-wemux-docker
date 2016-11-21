default:
	echo Hello World

docker: destroy build run

build:
	docker build -t wemux .; 

run:
	docker run -t -i -d -p 2255:22 wemux

destroy:
	docker rm --force `docker ps -l -q`

ssh:
	ssh -F config/ssh.${WHOAMI}.conf ${WHOAMI}

pair:
	ssh -F config/ssh.${WHOAMI}.conf ${WHOAMI} -t wemux
