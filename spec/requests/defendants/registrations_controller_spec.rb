require 'rails_helper'

RSpec.describe Defendants::RegistrationsController, type: :request do

  describe "#create" do
    context "success" do
      let!(:params){ attributes_for(:defendant_for_create) }
      subject { post "/defendants", defendant: params }

      it { expect { subject }.to change{ Defendant.count } }
      it { expect(subject).to redirect_to("/defendants") }
    end

    context "nil params" do
      let!(:params){ {} }
      subject { post "/defendants", defendant: params }

      it { expect { subject }.not_to change{ Defendant.count } }

      context "render new" do
        before { subject }
        it { expect(response).to be_success }
      end
    end

    context "name empty" do
      let!(:params){ attributes_for(:defendant_for_create).merge(name: "") }
      subject { post "/defendants", defendant: params }

      it { expect { subject }.not_to change{ Defendant.count } }
    end

    context "identify_number length != 10" do
      let!(:params){ attributes_for(:defendant_for_create).merge(identify_number: "123123213") }
      subject { post "/defendants", defendant: params }

      it { expect { subject }.not_to change{ Defendant.count } }
    end

    context "identify_number nil" do
      let!(:params){ attributes_for(:defendant_for_create).merge(identify_number: "") }
      subject { post "/defendants", defendant: params }

      it { expect { subject }.not_to change{ Defendant.count } }
    end

    context "identify_number exist" do
      let!(:defendant) { FactoryGirl.create :defendant }
      let!(:params){ attributes_for(:defendant_for_create).merge(identify_number: defendant.identify_number) }
      subject { post "/defendants", defendant: params }

      it { expect { subject }.not_to change{ Defendant.count } }
    end

    context "password caheck failed" do
      let!(:defendant) { FactoryGirl.create :defendant }
      let!(:params){ attributes_for(:defendant_for_create).merge(password_confirmation: "wrong_password") }
      subject { post "/defendants", defendant: params }

      it { expect { subject }.not_to change{ Defendant.count } }
    end
  end
end
