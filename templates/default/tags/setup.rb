def init
  super
  if object.has_tag?(:validates)
    create_tag_methods([:validates])
    sections << Section.new(:validates)
  end
end

def validates
  all_tags = object.tags(:validates)
  out = ''
  conditions = all_tags.map{| tag | tag.pair.join }.uniq.compact
  conditions.each do | condition |
    @tags = all_tags.select{|tag| tag.pair.join == condition }
    unless condition.empty?
      options = @tags.first.pair
      condition = options.first.capitalize + ' '
      if options.last =~/^:/ # it's a symbol, convert to link
        condition << linkify(options.last.gsub(/^:/,'#'))
      else
        condition << options.last
      end
    end
    @condition = condition.empty? ? nil : condition
    out << erb( :validations )
  end
  out
end
