require "rails_helper"

RSpec.describe Party::RegistrationsController, type: :request do

  describe "#create" do
    context "success" do
      let!(:params) { attributes_for(:party_for_create) }
      subject { post "/party", party: params, policy_agreement: "1" }

      it { expect { subject }.to change { Party.count } }
      it { expect(subject).to redirect_to("/party/phone/new") }
    end

    context "nil params" do
      let!(:params) { {} }
      subject { post "/party", party: params }

      it { expect { subject }.not_to change { Party.count } }

      context "render new" do
        before { subject }
        it { expect(response).to be_success }
      end
    end

    context "name empty" do
      let!(:params) { attributes_for(:party_for_create).merge(name: "") }
      subject { post "/party", party: params, policy_agreement: "1" }

      it { expect { subject }.not_to change { Party.count } }
    end

    context "identify_number length != 10" do
      let!(:params) { attributes_for(:party_for_create).merge(identify_number: "123123213") }
      subject { post "/party", party: params, policy_agreement: "1" }

      it { expect { subject }.not_to change { Party.count } }
    end

    context "identify_number nil" do
      let!(:params) { attributes_for(:party_for_create).merge(identify_number: "") }
      subject { post "/party", party: params, policy_agreement: "1" }

      it { expect { subject }.not_to change { Party.count } }
    end

    context "identify_number exist" do
      let!(:party) { create :party }
      let!(:params) { attributes_for(:party_for_create).merge(identify_number: party.identify_number) }
      subject { post "/party", party: params, policy_agreement: "1" }

      it { expect { subject }.not_to change { Party.count } }
    end

    context "password caheck failed" do
      let!(:party) { create :party }
      let!(:params) { attributes_for(:party_for_create).merge(password_confirmation: "wrong_password") }
      subject { post "/party", party: params, policy_agreement: "1" }

      it { expect { subject }.not_to change { Party.count } }
    end
  end
end
