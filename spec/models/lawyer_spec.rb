# == Schema Information
#
# Table name: lawyers
#
#  id                     :integer          not null, primary key
#  name                   :string           not null
#  current                :string
#  avatar                 :string
#  gender                 :string
#  birth_year             :integer
#  memo                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           not null
#  encrypted_password     :string           default("")
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  last_sign_in_at        :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmation_sent_at   :datetime
#  confirmed_at           :datetime
#  unconfirmed_email      :string
#  phone_number           :string
#  office_number          :string
#  active_notice          :boolean          default(TRUE)
#

require 'rails_helper'

RSpec.describe Lawyer do
  let(:lawyer) { create :lawyer }

  describe 'FactoryGirl' do
    describe 'normalize' do
      subject! { lawyer }
      it { expect(subject).not_to be_new_record }
    end

    describe 'with_avatar' do
      let(:lawyer) { create :lawyer, :with_avatar }
      subject! { lawyer }
      it { expect(lawyer.avatar).to be_present }
    end

    describe '#need_update_info?' do
      subject { lawyer.update_attributes(phone_number: nil) }
      it { expect { subject }.to change { lawyer.reload.need_update_info? }.from(false).to(true) }
    end
  end

  context 'devise async' do
    context 'create not send confirm email' do
      subject { lawyer }
      it { expect { subject }.not_to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
    end
  end
end
