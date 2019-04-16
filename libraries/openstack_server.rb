class OpenstackServer < Inspec.resource(1)
  name 'openstack_server'

  def initialize(opts = {})
    opts = { instance_id: opts } if opts.is_a?(String)
    @instance_id = opts[:instance_id]
    raise ArgumentError, 'instance_id should not be empty' if @instance_id.empty? || @instance_id.nil?

    @client = inspec.backend.openstack_resource('compute')

    begin
      @instance = @client.get_server(@instance_id)
    rescue OpenStack::Exception::ItemNotFound
      @instance = nil
    end
  end

  def to_s
    "Openstack server #{@instance_id}"
  end

  def exists?
    @instance.nil? ? false : true
  end

  # Copy AWS's create_resource_methods() method

  def accessipv4
    @instance.accessipv4
  end

  def accessipv6
    @instance.accessipv6
  end

  def addresses
    @instance.addresses
  end

  def fault
    @instance.fault
  end

  def flavor
    @instance.flavor
  end

  def hostId
    @instance.hostId
  end

  def image
    @instance.image
  end

  def key_name
    @instance.key_name
  end

  def libvirt_id
    @instance.libvirt_id
  end

  def metadata
    @instance.metadata
  end

  def name
    @instance.name
  end

  def progress
    @instance.progress
  end

  def security_groups
    @instance.security_groups
  end

  def status
    @instance.status
  end
end
