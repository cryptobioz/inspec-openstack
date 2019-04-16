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

  # Copy AWS's create_resource_methods() method
  def attachments
    @volume.attachments
  end

  def availability_zone
    @volume.availability_zone
  end

  def display_name
    @volume.display_name
  end

  def metadata
    @volume.metadata
  end

  def size
    @volume.size
  end

  def status
    @volume.status
  end

  def volume_type
    @volume.volume_type
  end
end
