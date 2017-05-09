require 'rails_helper'

describe '律師資料匯入', type: :request do
  subject { Import::CreateLawyerContext.new(lawyer_data).perform }

  context '已存在的律師資料（email）' do
    let!(:lawyer) { create(:lawyer) }
    let!(:lawyer_data) { { name: '孔令則', phone: 33_381_841, email: lawyer.email } }

    it '跳過不匯入' do
      expect { subject }.not_to change { Lawyer.count }
    end
  end

  context '未存在的律師資料，且資料無姓名或 email' do
    let!(:lawyer_data) { { phone: 33_381_841, email: 'hello88@gmail.com' } }

    it '跳過不匯入' do
      expect { subject }.not_to change { Lawyer.count }
    end
  end

  context '未存在的律師資料，且至少有 email 和姓名' do
    let!(:lawyer_data) { { name: '孔令則', phone: 33_381_841, email: 'kungls@hotmail.com' } }

    it '成功匯入' do
      expect { subject }.to change { Lawyer.count }.by(1)
    end

    it '不會發送註冊信' do
      expect { subject }.not_to change_sidekiq_jobs_size_of(CustomDeviseMailer, :send_confirm_mail)
    end

    it '不會發送密碼設定信' do
      expect { subject }.not_to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq)
    end
  end
end
