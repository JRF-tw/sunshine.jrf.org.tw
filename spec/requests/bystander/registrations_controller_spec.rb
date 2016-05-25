require 'rails_helper'

RSpec.describe Bystander::RegistrationsController, :type => :request do
  let!(:bystander) { FactoryGirl.create :bystander }

  describe "bystander action" do
    context "sign up with exist e-mail" do
      subject { post "/bystanders", bystander: { name: "haha", email: bystander.email, password: "55667788", password_confirmation: "55667788"} }
      it { expect{ subject }.to_not change{ Bystander.count } }
    end

    context "sign up" do
      subject { post "/bystanders", bystander: { name: "haha", email: "h2312@gmail.com", password: "55667788", password_confirmation: "55667788"} }
      it { expect(subject).to redirect_to("/bystanders/sign_in")}
    end
  end


end
