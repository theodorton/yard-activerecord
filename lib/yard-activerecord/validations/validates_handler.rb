require 'active_support/inflector'
require 'active_support/core_ext/array'

module YARD::Handlers::Ruby::ActiveRecord::Validate

  # Define validations tag for later use
  YARD::Tags::Library.define_tag("Validations", :validates )

  # Document ActiveRecord validations.
  # This handler handles the validates statement.
  # It will parse the list of fields, the validation types and their options,
  # and the optional :if/:unless clause.
  # It only handles the newer Rails ":validates" syntax and does not
  # recognize the older "validates_presence_of" type methods.
  class ValidatesHandler < YARD::Handlers::Ruby::MethodHandler
    namespace_only
    handles method_call(:validates)

    def process

      validations = {}
      attributes  = []
      conditions = []

      # Read each parameter to the statement and parse out
      # it's type and intent
      statement.parameters(false).compact.map do |param|
        # list types are options
        if param.type == :list
          param.each do | n |
            kw = n.jump(:ident, :kw, :tstring_content ).source
            # if/unless are conditions that apply to all the validations
            if kw == 'if' || kw=='unless'
              conditions = [kw, n.children.last.source ]
            else # otherwise it's type specific
              opts = n.jump(:hash)
              value = ( opts != n ) ? opts.source : nil
              validations[ kw ] = value
            end
          end
        elsif param.type == :symbol_literal
          attributes << param.jump(:ident, :kw, :tstring_content).source
        end
      end

      # abort in case we didn't parse anything
      return if validations.empty?

      # Loop through each attribute and set a tag on each
      attributes.each do | attribute |
        method_definition = namespace.instance_attributes[attribute.to_sym] || {}
        method = method_definition[:read]
        # If the method isn't defined yet, go ahead and create one
        if ! method
          method = YARD::CodeObjects::MethodObject.new(namespace, attribute )
          method.scope = :instance
          method.explicit = false
          register method
          method_definition[:read] = method
          namespace.instance_attributes[attribute.to_sym] = method_definition
        end
        tag = YARD::Tags::OptionTag.new(:validates, '', conditions ) #, [] )
        tag.types = []
        validations.each{ |arg,options| 
          tag.types << ( arg.capitalize + ( options ? "(#{options})" : '' ) )
        }
        method.docstring.add_tag tag
      end
      
    end
  end

end
