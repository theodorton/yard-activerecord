require_relative 'singular_handler'

module YARD::Handlers::Ruby::ActiveRecord::Associations
  class HasOneHandler < SingularHandler
    handles method_call(:has_one)

    def return_description
      "#{namespace} <b>has one</b> #{method_name}"
    end
  end
end