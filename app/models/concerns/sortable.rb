module Sortable
  extend ActiveSupport::Concern

  module ClassMethods
    # to see options:
    #   https://github.com/swanandp/acts_as_list
    def sortable(opts = {})
      column = opts[:column] || 'position' # acts as list default

      acts_as_list(opts)
      define_column_setter!(column)
      scope :sorted, -> { order("#{column} ASC") }
    end

    private

    # let acts_as_list usage like ranked-model
    def define_column_setter!(column)
      send :define_method, "#{column}=", lambda { |value|
        return if new_record?
        orig_value = public_send(column)
        if value.present?
          insert_at && move_to_bottom if orig_value.blank?
          return insert_at(value) if value.to_s.to_i > 0 || value == '0' || value == 0
          method = { up: :move_higher,
                     down: :move_lower,
                     first: :move_to_top,
                     last: :move_to_bottom,
                     remove: :remove_from_list }[value.to_sym]
          send(method) if method
        elsif orig_value
          remove_from_list
        end
      }
    end
  end
end
