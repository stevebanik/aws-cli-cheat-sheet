Here are a few useful [AWS CLI](https://aws.amazon.com/cli/) commands taken from [this article](https://medium.com/circuitpeople/aws-cli-with-jq-and-bash-9d54e2eabaf1).

1) List all instances in table format
<pre>aws ec2 describe-instances --query 'Reservations[].Instances[].[Placement.AvailabilityZone, State.Name, InstanceId,InstanceType,Platform,Tags.Value,State.Code,Tags.Values]' --output table
</pre>
example output:

![](./images/table.png)

2) What's my user id, account and ARN?
<pre>{ aws sts get-caller-identity & aws iam list-account-aliases; } | jq -s ".|add"
</pre>
example output:

![](./images/get-caller-ident.png)

3) Which of my ec2 security groups are being used?
<pre>{ aws ec2 describe-network-interfaces | jq '[.NetworkInterfaces[].Groups[]|.]|map({ (.GroupId|tostring): true }) 
| add'; aws ec2 describe-security-groups | jq '[.SecurityGroups[].GroupId]|map({ (.|tostring): false })|add'; } | jq -s '[.[1], .[0]]|add|to_entries|[group_by(.value)[]|{ (.[0].value|if . then "in-use" else "unused" end): [.[].key] }]|add'</pre>