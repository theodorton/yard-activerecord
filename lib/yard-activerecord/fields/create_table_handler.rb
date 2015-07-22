require 'yard'
require 'active_support/inflector'
  
module YARD::Handlers::Ruby::ActiveRecord::Fields
  class CreateTableHandler < YARD::Handlers::Ruby::MethodHandler
    handles method_call(:create_table)
    def process
      return unless globals.ar_schema
      table_name = call_params.first
      class_name_regex = table_name.
        singularize.
        split('_').
        map(&:camelize).
        join('(::|_)?')
      regex = Regexp.new("#{class_name_regex}$")
      globals.klass = YARD::Registry.all(:class).find do |co|
        regex.match(co.path)
      end
      parse_block(statement.last.last)
      globals.klass = nil
    end
  end
end
