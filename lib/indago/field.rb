class Indago::Field
  autoload :Contain, 'indago/field/contain'

  attr_reader :name

  def initialize(name, &block)
    @name = name
    @block = block
  end

  def call(scope, value)
    @block.call(scope, value)
  end

  def self.for(name)
    case name.to_s
    when /^(\w+)_cont$/ then Contain.new(name.to_sym, $1.to_sym)
    else raise Indago::Error, "Cannot find a proper field for #{name.inspect}"
    end
  end
end
