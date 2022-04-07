list all instances in table format
<pre><code\small>aws ec2 describe-instances --query 'Reservations[].Instances[].[Placement.AvailabilityZone, State.Name, InstanceId,InstanceType,Platform,Tags.Value,State.Code,Tags.Values]' --output table
</code></pre>
example output:

![](./images/table.png)

what's my user id, account and ARN?
<pre><code\small>{ aws sts get-caller-identity & aws iam list-account-aliases; } | jq -s ".|add"
</code></pre>
example output:

![](./images/get-caller-ident.png)
