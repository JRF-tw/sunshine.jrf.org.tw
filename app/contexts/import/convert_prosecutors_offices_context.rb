class Import::ConvertProsecutorsOfficesContext < BaseContext

  def initialize
    @prosecutors_offices_by_court = Court.prosecutors
  end

  def perform
    run_callbacks :perform do
      prosecutors_offices = []
      @prosecutors_offices_by_court.each do |p|
        prosecutors_offices << ProsecutorsOffice.create(prosecutors_office_data(p))
      end
      prosecutors_offices
    end
  end

  def prosecutors_office_data(p)
    court = Court.find_by_full_name(p.full_name.gsub('檢察署', ''))
    {
      name: p.name,
      full_name: p.full_name,
      weight: p.weight,
      is_hidden: p.is_hidden,
      court: court
    }
  end
end
