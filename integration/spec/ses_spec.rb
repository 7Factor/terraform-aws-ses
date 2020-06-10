require 'awspec'
require 'hcl/checker'

TFVARS = HCL::Checker.parse(File.open('testing.tfvars').read())

describe ses_identity(TFVARS['domain_name']) do
  it { should exist }
  its(:dkim_enabled) { should eq true }
  its(:dkim_verification_status) { should eq 'Success'}
  its(:forwarding_enabled) { should eq true}
end