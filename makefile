OWNER=graphql
IMAGE_NAME=credentials
QNAME=$(OWNER)/$(IMAGE_NAME)

TAG=$(QNAME):`echo $(TRAVIS_BRANCH) | sed 's/master/latest/;s/develop/unstable/'`

build:
	docker build -t $(TAG)-eventstore -f Dockerfile-eventstore .
	docker build -t $(TAG)-aggregator -f Dockerfile-aggregator .

login:
	@docker login -u "$(DOCKER_USER)" -p "$(DOCKER_PASS)"
push: login
	docker push $(TAG)-eventstore
	docker push $(TAG)-aggregator
