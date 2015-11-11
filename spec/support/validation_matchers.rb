module RSpec
  module Rails
    module Matchers

      RSpec::Matchers.define :validate_presence_of do |attribute, options|
        match do |model|
          model.send("#{attribute}=", nil)
          !model.valid? && model.errors[attribute].any?
        end
        description do
          "model to validate the presence of #{attribute}"
        end
      end

      RSpec::Matchers.define :validate_length_of do |attribute, options|
        if options.has_key? :within
          min = options[:within].first
          max = options[:within].last
        elsif options.has_key? :is
          min = options[:is]
          max = min
        elsif options.has_key? :in
          min = options[:in].first
          max = options[:in].last
        elsif options.has_key? :minimum
          min = options[:minimum]
        elsif options.has_key? :maximum
          max = options[:maximum]
        end
        match do |model|
          invalid = false
          if !min.nil? && min >= 1
            model.send("#{attribute}=", 'a' * (min - 1))
            invalid = !model.valid? && model.errors[attribute].any?
          end

          if !max.nil?
            model.send("#{attribute}=", 'a' * (max + 1))
            invalid ||= !model.valid? && model.errors[attribute].any?
          end
          invalid
        end
        description do
          "model to validate the length of #{attribute} within #{min || 0} and #{max || 'Infinity'}"
        end
      end

      RSpec::Matchers.define :validate_uniqueness_of do |attribute|
        match do |model|
          model.send("#{attribute}=", Time.now.to_s)

          model.class.stub_chain(:unscoped, :where, :exists?).and_return(true)
          !model.valid? && model.errors[attribute].any?
        end
        description do
          "model to validate the uniqueness of #{attribute}"
        end
      end

      RSpec::Matchers.define :validate_confirmation_of do |attribute|
        match do |model|
          model.send("#{attribute}_confirmation=", 'asdf')
          !model.valid? && model.errors[attribute].any?
        end
        description do
          "model to validate the confirmation of #{attribute}"
        end
      end

      RSpec::Matchers.define :validate_inclusion_of do |attribute, options|
        # default settings
        allow_nil = false
        allow_blank = false

        # passed in validation options
        allow_nil = options[:allow_nil] if options.has_key? :allow_nil
        allow_blank = options[:allow_blank] if options.has_key? :allow_blank
        in_option = options[:in] if options.has_key? :in

        unsupported_options = [:if, :unless]
        unsupported_options.each do |option|
          raise "Unimplemented option for matcher - validate_inclusion_of: #{option}" if options.has_key? option
        end

        match do |model|
          invalid = false

          # default value checks
          unless allow_nil
            model.send("#{attribute}=", nil)
            invalid = !model.valid? && model.errors[attribute].any?
          end
          unless allow_blank
            model.send("#{attribute}=", "")
            invalid = !model.valid? && model.errors[attribute].any?
          end

          # custom options
          unless in_option.blank?
            random_string = Time.now.to_s
            model.send("#{attribute}=", random_string)
            invalid = !model.valid? && model.errors[attribute].any?
          end

          invalid
        end

        description do
          "model to validate the inclusion of #{attribute}"
        end
      end

    end
    RSpec::Matchers.define :validate_numericality_of do |attribute, options|
      # default settings
      allow_nil = false
      only_integer = false
      options ||= {}
      
      # passed in validation options
      greater_than = options[:greater_than] if options.has_key? :greater_than
      greater_than_or_equal_to = options[:greater_than_or_equal_to] if options.has_key? :greater_than_or_equal_to
      allow_nil = options[:allow_nil] if options.has_key? :allow_nil
      only_integer = options[:only_integer] if options.has_key? :only_integer

      match do |model|
        invalid = false

        # default value checks
        unless allow_nil
          model.send("#{attribute}=", nil)
          invalid = !model.valid? && model.errors[attribute].any?
        end
        if only_integer
          model.send("#{attribute}=", 4.4)
          invalid = !model.valid? && model.errors[attribute].any?
        end

        # custom options
        unless greater_than.nil?
          model.send("#{attribute}=", (greater_than - 1))
          invalid = !model.valid? && model.errors[attribute].any?

          unless invalid
            model.send("#{attribute}=", greater_than)
            invalid = !model.valid? && model.errors[attribute].any?
          end
        end

        unless greater_than_or_equal_to.nil?
          model.send("#{attribute}=", (greater_than_or_equal_to - 1))
          invalid = !model.valid? && model.errors[attribute].any?
        end

        model.send("#{attribute}=", "NaN")
        invalid = !model.valid? && model.errors[attribute].any?

        invalid
      end

      description do
        "model to validate the numericality of #{attribute}"
      end
    end
  end
end