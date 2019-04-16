class OpenstackVolumes < Inspec.resource(1)
  name 'openstack_volumes'

  attr_reader :table

  def initialize(opts = {})
    @client = inspec.backend.openstack_resource('volume')
    @table = fetch_data
  end


  # FilterTable setup
  FilterTable.create
    .register_column(:id, field: :id)
    .register_column(:display_name, field: :display_name)
    .install_filter_methods_on_resource(self, :table)

  def fetch_data
    volume_rows = []
    @client.list_volumes.each do |volume|
      volume_rows += [{
        id: volume.id,
        display_name: volume.display_name,
      }]
    end
    @table = volume_rows
  end
end
