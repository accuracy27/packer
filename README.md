# packer
packer templates and scripts

# Running
```
cd xenial 
packer build -var-file=../variables.json template.json

# Or for only virtualbox
packer build -var-file=../variables.json -only=virtualbox template.json

# Or for only aws
packer build -var-file=../variables.json -only=aws \
  -var 'aws_secret_key={{your_secret_key}}' \
  -var 'aws_access_key={your_access_key_id}}' \
  template.json
```
