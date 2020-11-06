# BEWARE of the Hackery!
module Indago::Hackery
  extend self

  def install!
    Indago::Search.prepend Search
    ActiveRecord::Base.singleton_class.prepend Base
  end

  module Search
    # Pretend to be a Ransack::Search
    def is_a?(klass)
      return true if defined?(Ransack::Search) && klass == Ransack::Search
      super
    end
  end

  module Base
    def ransack(params)
      fields = params.keys.map { |name| Indago::Fields.for(name) }
      Indago::Search.new(all, fields, params)
    end
  end
end
