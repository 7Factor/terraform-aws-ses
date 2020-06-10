require 'awspec'
require 'hcl/checker'

TFVARS = HCL::Checker.parse(File.open('testing.tfvars').read())
TFOUTPUTS = eval(ENV['KITCHEN_KITCHEN_TERRAFORM_OUTPUTS'])

describe iam_user(TFOUTPUTS[:smtp_user_name][:value]) do
  it { should exist }
  its(:path) { should eq '/'}
  it do
    should have_inline_policy('AmazonSesSendingAccess').policy_document(<<-'DOC')
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ses:SendRawEmail",
            "Resource": "*"
        }
    ]
}
    DOC
  end
end