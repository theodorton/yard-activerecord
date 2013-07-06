module YARD::Handlers::Ruby::ActiveRecord::Fields
  class FieldHandler < YARD::Handlers::Ruby::MethodHandler
    handles method_call(:string)
    handles method_call(:text)
    handles method_call(:integer)
    handles method_call(:float)
    handles method_call(:boolean)
    handles method_call(:timestamp)
    handles method_call(:datetime)
    handles method_call(:date)
  
    def process
      return unless statement.namespace.jump(:ident).source == 't'
      method_name = call_params.first
      
      return if method_name['_id'] # Skip all id fields, associations will handle that
      
      ensure_loaded! P(globals.klass)
      namespace = P(globals.klass)
      return if namespace.nil?

      method_definition = namespace.instance_attributes[method_name.to_sym] || {}
    
      unless method_definition[:read]
        r_object = YARD::CodeObjects::MethodObject.new(namespace, method_name)
        r_object.docstring = description(method_name)
        r_object.docstring.add_tag get_tag(:return, '', class_name)
        r_object.dynamic = true
        register r_object
        method_definition[:read] = r_object
      end
    
      unless method_definition[:write]
        w_object = YARD::CodeObjects::MethodObject.new(namespace, "#{method_name}=")
        w_object.docstring = description(method_name)
        w_object.docstring.add_tag get_tag(:return, '', class_name)
        w_object.dynamic = true
        register w_object
        method_definition[:write] = w_object
      end

      namespace.instance_attributes[method_name.to_sym] = method_definition
    end
  
    def description(method_name)
      '' # "Database field value of #{method_name}. Defined in {file:db/schema.rb}"
    end
  
    def get_tag(tag, text, return_classes)
      YARD::Tags::Tag.new(:return, text, [return_classes].flatten)
    end

    private

    def class_name
      if ['datetime', 'timestamp'].include?(caller_method)
        'DateTime'
      else
        caller_method.capitalize
      end
    end
  end
end
