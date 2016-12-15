class Import::ConvertProsecutorsOfficesContext < BaseContext

  def initialize
    @offices = Court.prosecutors
  end

  def perform
    run_callbacks :perform do
      prosecutors_offices = []
      @offices.each do |p|
        prosecutors_office = ProsecutorsOffice.create(prosecutors_office_data(p))
        if prosecutors_office
          prosecutors_offices << prosecutors_office
        end
      end
      prosecutors_offices
    end
  end

  def prosecutors_office_data(p)
    court = Court.find_by_full_name(p.full_name.gsub('檢察署', ''))
    p.attributes.symbolize_keys.except(:id, :court_type, :scrap_name, :code, :weight).merge(court: court)
  end
end
