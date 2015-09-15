module TaiwanAge
  extend ActiveSupport::Concern

  module ClassMethods
    def tw_age_columns(*args)
      args.each do |column|
        define_method "#{column}_in_tw", -> do
          date = public_send(column)
          return nil unless date
          "#{send "#{column}_in_tw_year"}/#{date.month}/#{date.day}"
        end
        define_method "#{column}_in_tw_year", -> do
          date = public_send(column)
          return nil unless date
          date.year - 1911
        end
        define_method "#{column}_in_tw=", ->(value) do
          public_send "#{column}=", value
          date = public_send(column)
          year = date.year < 1000 ? date.year + 1911 : date.year
          public_send "#{column}=", "#{year}/#{date.month}/#{date.day}"
        end
      end
    end
  end
end
