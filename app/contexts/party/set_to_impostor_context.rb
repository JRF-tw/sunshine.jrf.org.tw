class Party::SetToImpostorContext < BaseContext
  before_perform :record_identify_number
  before_perform :destroy_identify_number
  before_perform :set_to_imposter

  def initialize(party)
    @party = party
  end

  def perform
    run_callbacks :perform do
      return add_error(:data_update_fail, "未能設置為冒用者") unless @party.save(validate: false)
      true
    end
  end

  def record_identify_number
    @party.imposter_identify_number = @party.identify_number
  end

  def destroy_identify_number
    @party.identify_number = ""
  end

  def set_to_imposter
    @party.imposter = true
  end

end
