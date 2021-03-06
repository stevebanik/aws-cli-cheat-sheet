# list all instances in table format
aws ec2 describe-instances --query 'Reservations[].Instances[].[Placement.AvailabilityZone, State.Name, InstanceId,InstanceType,Platform,Tags.Value,State.Code,Tags.Values]' --output table

# what's my user id, account and ARN?
{ aws sts get-caller-identity & aws iam list-account-aliases; } | jq -s ".|add"
