# copyright: 2018, The Authors

title "XC tests"


XC_TENANT = input('xc_tenant')
XC_TOKEN = input('xc_token')
XC_SITE_TYPE = input('xc_site_type')
XC_SITE_NAME = input('xc_site_name')
XC_SERVICE_DISCOVERY = input('xc_service_discovery')
XC_API_URL = "https://#{XC_TENANT}.console.ves.volterra.io/api"
XC_AWS_SITE_NAME = input('xc_aws_site_name')
XC_AZURE_SITE_NAME = input('xc_azure_site_name')

control "aws-site-online" do
  impact 0.5
  title "XC Site is ONLINE"
  desc "check that the status of the specified XC Site is ONLINE"
  http_response = http("#{XC_API_URL}/config/namespaces/system/aws_vpc_sites/#{XC_SITE_NAME}", 
                        headers: {'Authorization' => "APIToken #{XC_TOKEN}"}, method: 'GET', ssl_verify: false )
  describe http_response do
      its('status') { should cmp 200 }
  end
  describe json(content: http_response.body) do
    its(['spec','site_state']) { should cmp 'ONLINE' }
  end

end

control "aws-site-does-not-exist" do
  impact 0.5
  title "XC Site does not exist"
  desc "check that the site does not exist"
  http_response = http("#{XC_API_URL}/config/namespaces/system/aws_vpc_sites/#{XC_SITE_NAME}", 
                        headers: {'Authorization' => "APIToken #{XC_TOKEN}"}, method: 'GET', ssl_verify: false )
  describe http_response do
    its('status') { should cmp 404 }
  end
end

control "azure-site-online" do
  impact 0.5
  title "Azure XC Site is ONLINE"
  desc "check that the status of the specified XC Site is ONLINE"
  http_response = http("#{XC_API_URL}/config/namespaces/system/azure_vnet_sites/#{XC_AZURE_SITE_NAME}", 
                        headers: {'Authorization' => "APIToken #{XC_TOKEN}"}, method: 'GET', ssl_verify: false )
  describe http_response do
      its('status') { should cmp 200 }
  end
  describe json(content: http_response.body) do
    its(['spec','site_state']) { should cmp 'ONLINE' }
  end

end

control "azure-site-does-not-exist" do
  impact 0.5
  title "Azure XC Site does not exist"
  desc "check that the site does not exist"
  http_response = http("#{XC_API_URL}/config/namespaces/system/azure_vnet_sites/#{XC_AZURE_SITE_NAME}", 
                        headers: {'Authorization' => "APIToken #{XC_TOKEN}"}, method: 'GET', ssl_verify: false )
  describe http_response do
    its('status') { should cmp 404 }
  end
end


control "discovery-publishing" do
  impact 0.5
  title "XC Service Discovery is publishing"
  desc "check that the discovery is publishing"
  http_response = http("#{XC_API_URL}/config/namespaces/system/discoverys/#{XC_SERVICE_DISCOVERY}", 
                        headers: {'Authorization' => "APIToken #{XC_TOKEN}"}, method: 'GET', ssl_verify: false )
  describe http_response do
    its('status') { should cmp 200 }
  end
  describe json(content: http_response.body) do
    its(['status',0,'metadata','publish']) { should cmp 'STATUS_PUBLISH' }
  end  
end

control "discovery-does-not-exists" do
  impact 0.5
  title "XC Service Discovery does not exist"
  desc "check that the discovery does not exist"
  http_response = http("#{XC_API_URL}/config/namespaces/system/discoverys/#{XC_SERVICE_DISCOVERY}", 
                        headers: {'Authorization' => "APIToken #{XC_TOKEN}"}, method: 'GET', ssl_verify: false )
  describe http_response do
    its('status') { should cmp 404 }
  end
end