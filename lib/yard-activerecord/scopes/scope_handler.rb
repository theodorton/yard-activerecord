require 'active_support/inflector'

module YARD::Handlers::Ruby::ActiveRecord::Scopes
  class ScopeHandler < YARD::Handlers::Ruby::MethodHandler
    handles method_call(:scope)
    namespace_only
    
    def process
      object = YARD::CodeObjects::MethodObject.new(namespace, method_name, :class)
      object.docstring = return_description
      object.docstring.add_tag get_tag(:return, '', class_name)
      object.docstring.add_tag get_tag(:see,
'http://api.rubyonrails.org/classes/ActiveRecord/NamedScope/ClassMethods.html')
      register object
    end
    
    private
    def method_name
      call_params[0]
    end
    
    def return_description
      "An array of #{ActiveSupport::Inflector.pluralize namespace.to_s} " +
      "that are #{method_name.split('_').join(' ')}. " +
      "<strong>Active Record Scope</strong>"
    end
    
    def class_name
      "Array<#{namespace}>"
    end

    def get_tag(tag, text, return_classes = [])
      YARD::Tags::Tag.new(tag, text, [return_classes].flatten)
    end
  end
end