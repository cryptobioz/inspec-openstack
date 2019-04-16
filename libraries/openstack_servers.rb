class OpenstackServers < Inspec.resource(1)
  name 'openstack_servers'

  attr_reader :table

  def initialize(opts = {})
    @client = inspec.backend.openstack_resource('compute')
    @table = fetch_data
  end


  # FilterTable setup
  FilterTable.create
    .register_column(:id, field: :id)
    .register_column(:name, field: :name)
    .install_filter_methods_on_resource(self, :table)

  def fetch_data
    server_rows = []
    @client.list_servers.each do |server|
      server_rows += [{
        id: server.id,
        name: server.name,
      }]
    end
    @table = server_rows
  end
end
