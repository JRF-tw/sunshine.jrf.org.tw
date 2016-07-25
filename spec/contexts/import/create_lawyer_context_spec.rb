require "rails_helper"

describe Import::CreateLawyerContext do
  describe "#perform" do
    subject { described_class.new(lawyer_data).perform }

    context "create success" do
      let!(:lawyer_data) { { name: "孔令則", phone: 33_381_841, email: "kungls@hotmail.com" } }

      it { expect { subject }.to change { Lawyer.count }.by(1) }
    end

    context "fail" do
      context "lawyer exist" do
        let!(:lawyer) { create(:lawyer) }
        let!(:lawyer_data) { { name: "孔令則", phone: 33_381_841, email: lawyer.email } }

        it { expect { subject }.not_to change { Lawyer.count } }
      end

      context "data without name" do
        let!(:lawyer_data) { { phone: 33_381_841, email: "hello88@gmail.com" } }

        it { expect { subject }.not_to change { Lawyer.count } }
      end

      context "data without email" do
        let!(:lawyer_data) { { name: "孔令則", phone: 33_381_841 } }

        it { expect { subject }.not_to change { Lawyer.count } }
      end
    end

    context "transfer phone to office_number" do
      let!(:lawyer_data) { { name: "孔令則", phone: 33_381_841, email: "hello88@gmail.com" } }
      before { subject }

      it { expect(Lawyer.last.office_number).to eq("033381841") }
    end

    context "transfer phone to phone_number" do
      let!(:lawyer_data) { { name: "孔令則", phone: 933_818_411, email: "hello88@gmail.com" } }
      before { subject }

      it { expect(Lawyer.last.phone_number).to eq("0933818411") }
    end
  end
end
