# frozen_string_literal: true

module Acсessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        if instance_variable_get("@#{name}_history")
          instance_variable_get("@#{name}_history") << instance_variable_get(var_name)
        else
          instance_variable_set("@#{name}_history", [])
        end

        instance_variable_set(var_name, value)
      end

      define_method("#{name}_history") { instance_variable_get "@#{name}_history" }
    end
  end

  def strong_attr_accessor(name, klass)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=".to_sym) do |value|
      raise 'Wrong class!' if value.class != klass

      instance_variable_set(var_name, value)
    end
  end
end
