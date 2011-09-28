require_relative 'base'

module YARD::Handlers::Ruby::ActiveRecord::Associations
  class SingularHandler < Base
    def class_name
      super(false)
    end
  
    def return_description
      "An associated #{method_name}"
    end
  end
end
