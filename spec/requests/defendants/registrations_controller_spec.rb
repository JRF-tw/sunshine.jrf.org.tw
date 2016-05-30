require 'rails_helper'

RSpec.describe Defendants::RegistrationsController, type: :request do

  describe "#create" do
    context "success" do
      let!(:params){ attributes_for(:defendant_for_create) }
      subject { post "/defendants", defendant: params }

      it { expect { subject }.to change{ Defendant.count } }
      it { expect(subject).to redirect_to("/defendants") }
    end

    context "failed" do
      let!(:params){ attributes_for(:defendant_for_create).merge(password_confirmation: "xxxxx") }
      subject { post "/defendants", defendant: params }

      it { expect { subject }.not_to change{ Defendant.count } }
      it { expect(subject).to redirect_to("/defendants/sign_up") }
    end
  end
end
