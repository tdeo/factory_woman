require 'factory_girl'

module FactoryWoman
  def self.create(model_name, attributes = {})
    attributes.symbolize_keys!

    klass = model_name.to_s.camelize.constantize

    associations = load_associations(klass)

    associations.each do |association|
      association_key = ([association[:source_column]] + association[:aliases]).find { |a| attributes.key? a }
      if association_key.nil?
        attributes[association[:source_column]] = FactoryWoman.create(association[:target_klass].to_s.underscore.to_sym).id
      else
        next if association[:target_klass].exists?(association[:target_column] => attributes[association_key])
        FactoryWoman.create(association[:target_klass].to_s.underscore.to_sym, id: attributes[association_key])
      end
    end

    FactoryGirl.create(model_name, attributes)
  end

  def self.load_associations(klass)
    klass.reflect_on_all_associations(:belongs_to).map do |association|
      {
        target_klass: class_name(association),
        target_column: :id,
        source_column: association.foreign_key.to_sym,
        aliases: klass.attribute_aliases.select { |_, v| v.to_sym == association.foreign_key.to_sym }.keys.map(&:to_sym),
      }
    end
  end

  def self.class_name(association)
    model_name = association.options[:class_name] || association.name
    model_name = model_name.to_s.camelize
    begin
      klass = model_name.constantize
    rescue NameError
      klass = model_name.classify.constantize
    end
    klass = klass.superclass until klass.superclass == ActiveRecord::Base
    klass
  end
end
