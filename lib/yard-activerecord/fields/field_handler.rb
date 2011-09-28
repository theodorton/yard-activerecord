module YARD::Handlers::Ruby::ActiveRecord::Fields
  class FieldHandler < YARD::Handlers::Ruby::MethodHandler
    handles method_call(:string)
    handles method_call(:text)
    handles method_call(:integer)
    handles method_call(:float)
    handles method_call(:boolean)
    handles method_call(:datetime)
  
    def process
      return unless statement.namespace.jump(:ident).source == 't'
      method_name = call_params.first
      class_name = caller_method.capitalize
      
      return if method_name['_id'] # Skip all id fields, associations will handle that
      
      if class_name == "Datetime"
        class_name = "DateTime"
      end
      ensure_loaded! P(globals.klass)
      namespace = P(globals.klass)
      return if namespace.nil?
    
      r_object = YARD::CodeObjects::MethodObject.new(namespace, method_name)
      r_object.docstring = description(method_name)
      r_object.docstring.add_tag get_tag(:return, '', class_name)
      r_object.dynamic = true
      register r_object
    
      w_object = YARD::CodeObjects::MethodObject.new(namespace, "#{method_name}=")
      w_object.docstring = description(method_name)
      w_object.docstring.add_tag get_tag(:return, '', class_name)
      w_object.dynamic = true
      register w_object
    
      namespace.instance_attributes[method_name.to_sym] = {
        read: r_object,
        write: w_object
      }
    end
  
    def description(method_name)
      "Database field value of #{method_name}. Defined in {file:db/schema.rb}"
    end
  
    def get_tag(tag, text, return_classes)
      YARD::Tags::Tag.new(:return, text, [return_classes].flatten)
    end
  end
end