class Party::ToggleSubscribeEdmContext < BaseContext
  before_perform :check_email
  before_perform :check_confirm
  before_perform :assign_value

  def initialize(party)
    @party = party
  end

  def perform
    run_callbacks :perform do
      return add_error(:data_update_fail, "訂閱失敗") unless @party.save
      true
    end
  end

  private

  def check_email
    return add_error(:data_update_fail, "訂閱失敗 : 尚未驗證Email") unless @party.confirmed?
  end

  def check_confirm
    return add_error(:data_update_fail, "訂閱失敗 : Email未填寫") unless @party.email.present?
  end

  def assign_value
    @party.assign_attributes(subscribe_edm: !@party.subscribe_edm)
  end
end
