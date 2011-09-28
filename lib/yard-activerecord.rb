require 'yard'

module YARD::Handlers::Ruby::ActiveRecord
end

require_relative 'yard-activerecord/fields/create_table_handler'
require_relative 'yard-activerecord/fields/define_handler'
require_relative 'yard-activerecord/fields/field_handler'

require_relative 'yard-activerecord/associations/belongs_to_handler'
require_relative 'yard-activerecord/associations/has_one_handler'
require_relative 'yard-activerecord/associations/has_one_handler'
require_relative 'yard-activerecord/associations/has_and_belongs_to_many_handler'

require_relative 'yard-activerecord/delegations/delegate_handler'

require_relative 'yard-activerecord/scopes/scope_handler'
