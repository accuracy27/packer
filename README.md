# packer
packer templates and scripts

# Running
```
# To build both virtualbox & aws
cd ubuntu/xenial 
packer build -var-file=../variables.json \
  -var 'aws_secret_key={{your_secret_key}}' \
  -var 'aws_access_key={your_access_key_id}}' \
  template.json

# Or for only virtualbox
packer build -var-file=../variables.json -only=virtualbox template.json

# Or for only aws
packer build -var-file=../variables.json -only=aws \
  -var 'aws_secret_key={{your_secret_key}}' \
  -var 'aws_access_key={your_access_key_id}}' \
  template.json
```
