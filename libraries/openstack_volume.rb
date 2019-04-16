class OpenstackVolume < Inspec.resource(1)
  name 'openstack_volume'

  def initialize(opts = {})
    opts = { volume_id: opts } if opts.is_a?(String)
    @volume_id = opts[:volume_id]
    raise ArgumentError, 'volume_id should not be empty' if @volume_id.empty? || @volume_id.nil?

    @client = inspec.backend.openstack_resource('volume')

    begin
      @volume = @client.get_volume(@volume_id)
    rescue OpenStack::Exception::ItemNotFound
      @volume = nil
    end
  end

  def to_s
    "Openstack volume #{@volume_id}"
  end

  def exists?
    @volume.nil? ? false : true
  end
end
