require 'yard'

module YARD::Handlers::Ruby::ActiveRecord::Delegations
  class DelegateHandler < YARD::Handlers::Ruby::MethodHandler
    handles method_call(:delegate)
    namespace_only

    def process
      params = statement.parameters
      params.pop # we shouldn't have a block, so pop that off
      params.map! { |p| p.source }
      options, params = params.partition { |v| v =~ /\=\>|\:\s/ }
      class_name = options.detect { |v| v =~ /to\:\s|\:to \=\>/ } unless options.length == 0
      class_name = class_name.to_s.gsub(/\A.*\:/,'').capitalize
      params.each do |method_name|
        object = YARD::CodeObjects::MethodObject.new(namespace, method_name)
        object.group = "Delegated Instance Attributes"
        object.docstring = "Alias for {#{class_name}##{method_name}}"
        object.docstring.add_tag get_tag(:return,
            "{#{class_name}##{method_name}}", 'Object')
        object.docstring.add_tag get_tag(:see,
            "http://api.rubyonrails.org/classes/Module.html#method-i-delegate")
        register object
      end
      group_name = "Delegated Instance Attributes"
      namespace.groups << group_name unless namespace.groups.include? group_name
    end

    private

    def get_tag(tag, text, return_classes = [])
      YARD::Tags::Tag.new(tag, text, [return_classes].flatten)
    end
  end
end