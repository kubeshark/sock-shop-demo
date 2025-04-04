PWD = $(shell pwd)
MANIFESTS = $(or $(shell printenv MANIFESTS), manifests)

.PHONY: gen-complete-demo
gen-complete-demo:
	find ${MANIFESTS} -type f -name '*.yaml' | sort | xargs awk 'NR==1{print "---"} FNR==1 && NR!=1{print "---"} {print}' > complete-demo.yaml
gen-complete-demo-aws:
	find ${MANIFESTS} -type f -name '*.yaml' | sort | xargs awk 'NR==1{print "---"} FNR==1 && NR!=1{print "---"} {print}' > complete-demo-aws.yaml
	sed -i.bak -E 's/(image:\s*)([^[:space:]]+)/\1851725373216.dkr.ecr.us-east-1.amazonaws.com\/\2/g' complete-demo-aws.yaml

.PHONY: check-complete-demo
check-complete-demo:
	awk '{print}' $(shell find ${MANIFESTS} -type f | sort) | diff complete-demo.yaml -
.dockerimage: Dockerfile
	docker build -t manifests-image .
	touch .dockerimage

.PHONY: docker-%
docker-%: .dockerimage
	docker \
	  run \
	  --rm \
	  -it \
	  -u ${UID}:${GID} \
	  -v ${PWD}:/workdir \
	  manifests-image \
	  make $*
