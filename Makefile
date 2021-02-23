upgrade:
	brew upgrade aws-sam-cli
	
dep:
	aws s3 mb s3://sam-app-test-subtemplates --region us-east-1
	aws cloudformation create-stack --stack-name nestedappstests --template-url template.yaml

package:
	sam package --template template.yaml --output-template-file cloudformation.yaml --s3-prefix tests --s3-bucket sam-app-test-subtemplates --region us-east-1

build:
	sam build

deploy: build package 
	aws cloudformation deploy --template-file cloudformation.yaml --stack-name nestedappstests --region us-east-1 --capabilities CAPABILITY_IAM CAPABILITY_AUTO_EXPAND

validate:
	aws cloudformation validate-template --template-url YOUR_TEMPLATE_URL

describe:
	aws cloudformation describe-stack-events --stack-name nestedappstests

start-api:
	sam local start-api

delete:
	aws cloudformation delete-stack --stack-name nestedappstests

exports:
	aws cloudformation list-exports