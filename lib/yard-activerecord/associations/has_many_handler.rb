require_relative 'plural_handler'

module YARD::Handlers::Ruby::ActiveRecord::Associations
  class HasManyHandler < PluralHandler
    handles method_call(:has_many)

    def return_description
      "#{namespace} <b>has many</b> #{method_name}"
    end
  end
end