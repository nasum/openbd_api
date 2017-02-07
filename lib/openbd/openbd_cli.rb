class OpenbdCLI
  def initialize(argv)
    @argv = argv
  end

  def call
    if params.empty?
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
