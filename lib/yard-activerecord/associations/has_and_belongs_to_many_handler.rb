require_relative 'plural_handler'

module YARD::Handlers::Ruby::ActiveRecord::Associations
  class HasAndBelongsToManyHandler < PluralHandler
    handles method_call(:has_and_belongs_to_many)

    private
    def return_description
      "#{namespace} <b>has and belongs to many</b> #{method_name}"
    end
  end
end
