require_relative 'base'

module YARD::Handlers::Ruby::ActiveRecord::Associations
  class PluralHandler < Base
    def class_name
      "Array<#{super(true)}>"
    end

    private
    def return_description
      "An array of associated #{method_name.humanize}"
    end
  end
end
