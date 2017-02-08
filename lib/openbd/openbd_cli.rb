class OpenbdCLI
  def initialize(argv)
    @argv = argv
  end

  def call
    opts = Slop.parse do |o|
      o.banner = "Usage: openbd <method> [arguments] [options]"
      o.on '-v', '--version', 'print the version' do
        puts "openbd_api #{Openbd::VERSION}"
        exit
      end
      o.on '-h', '--help', 'print help' do
        puts o
        exit
      end
    end

    if method_name.nil?
      puts opts
    elsif params.empty?
      puts OpenBD.send(method_name)
    else
      puts OpenBD.send(method_name, params)
    end
  end

  private

  def method_name
    @argv[0]
  end

  def params
    @argv[1..-1]
  end
end
