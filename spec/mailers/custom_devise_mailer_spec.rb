require "rails_helper"

RSpec.describe CustomDeviseMailer, type: :mailer do
  pending "add some examples to (or delete) #{__FILE__}"

  context "#send_setting_password_mail" do
    let!(:lawyer) { create :lawyer }
    let!(:token) { lawyer.set_reset_password_token }
    let(:mail) { described_class.send_setting_password_mail(lawyer, token).deliver_now }
    it { expect(mail.subject).to eq("設定您在司法陽光網的密碼") }
    it { expect(mail.to).to eq([lawyer.email]) }
  end

  context "#resend_confirmation_instructions" do
    let!(:party) { create :party, :with_unconfirmed_email, confirmation_token: "5566" }
    let(:mail) { described_class.resend_confirmation_instructions(party, "5566").deliver_now }
    it { expect(mail.subject).to eq("更改您在司法陽光網的電子郵件信箱") }
    it { expect(mail.to).to eq([party.unconfirmed_email]) }
  end
end
