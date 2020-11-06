class Indago::Search
  def initialize(scope, fields, params)
    @scope = scope
    @params = params.presence || {}
    @fields = fields
    @field_names = @fields.map { |field| field.name.to_sym }
  end

  def result
    @result ||= @fields.reduce(@scope) do |scope, field|
      value = @params[field.name]
      value.present? ? field.call(scope, value) : scope
    end
  end

  def method_missing(name, *args, &block)
    if @field_names.include?(name) && args.empty?
      @params[name]
    elsif @scope.respond_to?(name)
      @scope.send(name, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(name, include_private = false)
    @field_names.include?(name) || @scope.respond_to?(name) || super
  end
end
