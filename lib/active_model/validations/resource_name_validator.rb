require 'active_model/validations'

module ActiveModel
  module Validations
    class ResourceNameValidator < ActiveModel::EachValidator
      cattr_accessor :routes

      def validate_each(record, attribute, value)
        if resource_patterns.include? value
          record.errors.add(attribute, :is_reserved || 'is reserved.')
        end
      end

      private

      def resource_patterns
        routes = self.routes || Rails.application.routes.routes.collect {|r| r.path.spec.to_s }
        routes.map {|path| resource_filter(path)}.compact.uniq
      end

      def resource_filter(path)
        if match = %r{^\/([^\/\(:]+)}.match(path)
          match[1]
        end
      end
    end
  end
end
