require 'awspec'
require 'hcl/checker'

TFVARS = HCL::Checker.parse(File.open('testing.tfvars').read())
TFOUTPUTS  = eval(ENV['KITCHEN_KITCHEN_TERRAFORM_OUTPUTS'])

describe route53_hosted_zone(TFVARS['route53_zone_id']) do
  it { should exist }
  it { should have_record_set("#{TFVARS['mail_from_domain']}.").type('txt') }
  it { should have_record_set("#{TFVARS['domain_name']}.").type('txt') }
  it { should have_record_set("#{TFVARS['mail_from_domain']}.").mx('10 feedback-smtp.us-east-1.amazonses.com').ttl(600) }
  it { should have_record_set("#{TFVARS['domain_name']}.").mx(TFVARS['mx_receive_records'].first).ttl(600) }
  it { should have_record_set("_dmarc.#{TFVARS['domain_name']}.").type('txt') }
  it { should have_record_set("_amazonses.#{TFVARS['domain_name']}.").type('txt') }

  describe 'the dkim records' do
    TFOUTPUTS[:dkim_tokens][:value].each do |token|
      it { should have_record_set("#{token}._domainkey.#{TFVARS['domain_name']}.").cname("#{token}.dkim.amazonses.com").ttl(600) }
    end
  end
end