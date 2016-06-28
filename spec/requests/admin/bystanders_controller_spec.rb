require 'rails_helper'

RSpec.describe Admin::BystandersController do
  before{ signin_user }
  let!(:bystander) { FactoryGirl.create :bystander }

  describe "#index" do
    context "render success" do
      before { get "/admin/bystanders" }
      it { expect(response).to be_success }
    end

    context "search name" do
      before { get "/admin/bystanders", q: { name_cont: bystander.name } }
      it { expect(response.body).to match(bystander.email) }
    end
  end

  describe "#show" do
    context "render success" do
      before { get "/admin/bystanders/#{bystander.id}" }
      it { expect(response).to be_success }
    end
  end

  describe "#download_file" do
    let!(:bystander) { FactoryGirl.create :bystander }

    context "success" do
      subject { get "/admin/bystanders/download_file", format: :xlsx }
      it { expect(subject).to be(200) }
    end

    context "after search success" do
      before { get "/admin/bystanders", q: { name_cont: bystander.name } }
      subject { get "/admin/bystanders/download_file", format: :xlsx }
      it { expect(subject).to be(200) }
    end
  end
end
