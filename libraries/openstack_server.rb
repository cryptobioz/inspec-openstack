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
end
