class Party::ChangeEmailContext < BaseContext
  PERMITS = [:email, :current_password].freeze

  before_perform :check_email_valid
  before_perform :check_email_different
  before_perform :check_email_unique
  before_perform :transfer_email_to_unconfirmed_email
  after_perform :generate_confirmation_token, if: :already_confirmed?
  after_perform :resend_confirmation_email, if: :already_confirmed?
  after_perform :first_time_send_confirmation_email, unless: :already_confirmed?

  def initialize(party)
    @party = party
  end

  def perform(params)
    @params = permit_params(params[:party] || params, PERMITS)
    run_callbacks :perform do
      unless @party.update_with_password(@params)
        @party.assign_attributes(email: @params[:unconfirmed_email])
        return add_error(:wrong_password)
      end
      true
    end
  end

  private

  def assign_email
    @party.assign_attributes(email: @params[:email])
  end

  def check_email_valid
    unless @params[:email][/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i]
      assign_email
      return add_error(:email_pattern_invalid)
    end
  end

  def check_email_different
    if @params["email"] == @party.email
      assign_email
      return add_error(:email_conflict)
    end
  end

  def check_email_unique
    if Party.pluck(:email).include?(@params["email"])
      assign_email
      return add_error(:email_exist)
    end
  end

  def transfer_email_to_unconfirmed_email
    @params["unconfirmed_email"] = @params.delete("email")
  end

  def already_confirmed?
    @party.confirmation_token.present?
  end

  def generate_confirmation_token
    token = Devise.token_generator.generate(@party.class, :confirmation_token)[0]
    @party.update_attributes(confirmation_sent_at: Time.zone.now, confirmation_token: token)
  end

  def first_time_send_confirmation_email
    @party.send_confirmation_instructions
  end

  def resend_confirmation_email
    CustomDeviseMailer.delay.resend_confirmation_instructions(@party)
  end

end
