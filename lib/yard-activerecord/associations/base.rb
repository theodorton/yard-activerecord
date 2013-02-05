require 'yard'
require 'active_support/inflector'

module YARD::Handlers::Ruby::ActiveRecord::Associations
  class Base < YARD::Handlers::Ruby::MethodHandler
    namespace_only

    def process
      group_name = "Active Record Associations"
      namespace.groups << group_name unless namespace.groups.include? group_name

      object           = YARD::CodeObjects::MethodObject.new(namespace, method_name)
      object.group     = group_name
      object.docstring = return_description
      object.docstring.add_tag get_tag(:return, '', class_name)
      object.docstring.add_tag get_tag(:see, 'http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html')
      object.dynamic = true
      register object
    end

    private
    def method_name
      call_params[0]
    end

    def class_name(singularize = false)
      param_size = statement.parameters.size
      if param_size > 2
        i           = 1
        return_this = false
        while i < param_size - 1
          # May want to evaluate doing it this way
          statement.parameters[i].jump(:hash).source =~ /(:class_name\s*=>|class_name:)\s*["']([^"']+)["']/
          return $2 if $2
          i += 1
        end
      end
      if singularize == true
        ActiveSupport::Inflector.singularize method_name.capitalize
      else
        method_name.capitalize
      end
    end

    def return_description
      "An array of associated #{method_name}."
    end

    def get_tag(tag, text, return_classes = [])
      YARD::Tags::Tag.new(tag, text, [return_classes].flatten)
    end
  end
end
