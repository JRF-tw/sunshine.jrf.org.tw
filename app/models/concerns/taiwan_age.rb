module TaiwanAge
  extend ActiveSupport::Concern

  module ClassMethods
    def tw_age_columns(*args)
      args.each do |column|
        define_method "#{column}_in_tw", lambda {
          date = public_send(column)
          return nil unless date
          "#{send "#{column}_in_tw_year"}/#{date.month}/#{date.day}"
        }
        define_method "#{column}_in_tw_year", lambda {
          date = public_send(column)
          return nil unless date
          date.year - 1911
        }
        define_method "#{column}_in_tw=", lambda { |value|
          public_send "#{column}=", value
          date = public_send(column)
          if value.blank?
            public_send(column)
          else
            is_leap_year = date.nil?
            date = Time.parse(value) if is_leap_year
            year = date.year < 1000 ? date.year + 1911 : date.year
            date = Time.parse("#{year}/#{date.month}/#{date.day}") - 1.day if is_leap_year
            public_send "#{column}=", "#{year}/#{date.month}/#{date.day}"
          end
        }
      end
    end
  end
end
