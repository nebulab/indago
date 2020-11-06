class Indago::Field::Contain
  attr_reader :name

  # @example
  #   Indago::Fields::Contain.new(:title)
  #
  def initialize(name, attribute)
    @name = name || :"#{attribute}_cont"
    @attribute = attribute
  end

  def call(scope, value)
    scope.where("#{@attribute} LIKE ?", "%#{value}%")
  end
end
