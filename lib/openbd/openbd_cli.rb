module OpenBD
  class OpenbdCLI
    def initialize(argv)
      @argv = argv
      parse_option
    end

    def call
      if method_name.nil?
        puts @opts
      elsif params.empty?
        client = ::OpenBD::Client.new
        puts client.send(method_name).body.to_json
      else
        client = ::OpenBD::Client.new
        puts client.send(method_name, params).body.to_json
      end
    end

    private

    def method_name
      @argv[0]
    end

    def params
      @argv[1..-1]
    end

    def parse_option
      @opts = ::Slop.parse do |o|
        o.banner = "Usage: openbd <method> [arguments] [options]"
        o.on '-v', '--version', 'print the version' do
          puts "openbd_api #{OpenBD::VERSION}"
          exit
        end
        o.on '-h', '--help', 'print help' do
          puts o
          exit
        end
      end
    end
  end
end
