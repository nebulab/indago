require "indago/version"

module Indago
  class Error < StandardError; end

  autoload :Field, "indago/field"
  autoload :Hackery, "indago/hackery"
  autoload :Search, "indago/search"
end
