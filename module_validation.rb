# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations
    def validate(name, type, *args)
      @validations ||= []
      @validations << { var: name, type: type, args: args }
    end
  end

  module InstanceMethods
    def validate!
      # нужно получить данные которые сохранил validate и проверять
      self.class.validations.each do |validation|
        value = instance_variable_get("@#{validation[:var]}")
        send("validate_#{validation[:type]}", value, *validation[:args])
      end
    end

    def validate_presence(value)
      raise 'Empty line' if value.nil? || value == ''
    end

    def validate_format(value, args)
      raise 'Wrong format' if value !~ args[0]
    end

    def validate_type(value, args)
      raise 'Wrong class type' if value.class != args[0]
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
