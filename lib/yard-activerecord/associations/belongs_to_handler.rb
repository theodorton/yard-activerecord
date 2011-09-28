require_relative 'singular_handler'

module YARD::Handlers::Ruby::ActiveRecord::Associations
  class BelongsToHandler < SingularHandler
    handles method_call(:belongs_to)

    private
    def return_description
      "#{namespace} <b>belongs to</b> a #{class_name}"
    end
  end
end
