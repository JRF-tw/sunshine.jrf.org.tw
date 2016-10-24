require 'rails_helper'

describe CourtObserver::ChangeEmailContext do
  let!(:court_observer) { create :court_observer }

  describe 'perform' do
    let!(:new_email) { 'h2312@gmail.com' }

    context 'success' do
      let(:params) { { email: new_email, current_password: '123123123' } }
      subject { described_class.new(court_observer) }

      it { expect { subject.perform(params) }.to change { court_observer.reload.unconfirmed_email } }
    end

    context 'update the invalid email' do
      let(:params) { { email: 'h2312', current_password: '123123123' } }
      subject { described_class.new(court_observer) }

      it { expect { subject.perform(params) }.not_to change { court_observer.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:email_pattern_invalid] } }
    end

    context 'update the same email' do
      let(:params) { { email: court_observer.email, current_password: '123123123' } }
      subject { described_class.new(court_observer) }

      it { expect { subject.perform(params) }.not_to change { court_observer.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:email_conflict] } }
    end

    context "update other's email" do
      let!(:court_observer2) { create :court_observer }
      let(:params) { { email: court_observer2.email, current_password: '123123123' } }
      subject { described_class.new(court_observer) }

      it { expect { subject.perform(params) }.not_to change { court_observer.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:email_exist] } }
    end

    context "update other's unconfirmed_email" do
      let!(:court_observer2) { create :court_observer, :with_unconfirmed_email }
      let(:params) { { email: court_observer2.unconfirmed_email, current_password: '123123123' } }
      subject { described_class.new(court_observer) }

      it { expect { subject.perform(params) }.to change { court_observer.reload.unconfirmed_email } }
    end

    context 'empty password' do
      let(:params) { { email: new_email, current_password: '' } }
      subject { described_class.new(court_observer) }

      it { expect { subject.perform(params) }.not_to change { court_observer.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:wrong_password] } }
    end

    context 'wrong password' do
      let(:params) { { email: new_email, current_password: '556655566' } }
      subject { described_class.new(court_observer) }

      it { expect { subject.perform(params) }.not_to change { court_observer.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:wrong_password] } }
    end
  end

end
