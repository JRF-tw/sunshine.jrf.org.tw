require 'rails_helper'

describe '從爬蟲資料中更新股別分表', type: :context do
  let!(:court) { create :court, code: 'TPH', scrap_name: '臺灣高等法院' }

  context '法官的新增' do
    let(:data_string) { '臺灣高等法院民事庭,丁,匡偉　法官,黃千鶴,2415' }
    subject { Scrap::ImportJudgeContext.new(data_string).perform }

    context '同法院下有找到相同姓名的法官' do
      let!(:judge) { create :judge, name: '匡偉', court: court }

      it '不會新增法官' do
        expect { subject }.not_to change { Judge.count }
      end
    end
    context '不同法院下有有相同姓名的法官、但同法院下則沒有' do
      let!(:judge) { create :judge, name: '匡偉' }

      it '會新增法官' do
        expect { subject }.to change { Judge.count }
      end
    end
  end

  context '同法院下，法官王大明有股別甲(missed 為 true)、乙，法官中屁有股別丙' do
    let!(:judge_A) { create :judge, name: '王大明', court: court }
    let!(:judge_B) { create :judge, name: 'B', court: court }
    let!(:branch1) { create :branch, court: court, name: '甲', judge: judge_A, chamber_name: '臺灣高等法院民事庭', missed: true }
    let!(:branch2) { create :branch, court: court, name: '乙', judge: judge_A, chamber_name: '臺灣高等法院民事庭' }
    let!(:branch3) { create :branch, court: court, name: '丙', judge: judge_B, chamber_name: '臺灣高等法院民事庭' }
    subject { Scrap::ImportJudgeContext.new(data_string).perform }

    context '從爬蟲資料中新增了法官張小明' do
      let(:data_string) { '臺灣高等法院民事庭,丁,張小明　法官,黃千鶴,2415' }

      it '法官張小明和法官王大明同法院' do
        expect(subject.court).to eq(judge_A.court)
      end

      context '從爬蟲資料中找到了股別丙' do
        let(:data_string) { '臺灣高等法院民事庭,丙,張小明　法官,黃千鶴,2415' }

        it '不會新增股別' do
          expect { subject }.not_to change { Branch.count }
        end

        before { subject }
        it '股別丙隸屬法官張小明' do
          expect(branch3.reload.judge).to eq(subject)
        end

        it '法官中屁沒有股別' do
          expect(judge_B.branches.count).to eq(0)
        end
      end

      context '從爬蟲資料中找不到資料庫內的股別' do
        let(:data_string) { '臺灣高等法院民事庭,丁,張小明　法官,黃千鶴,2415' }
        let(:branch) { Branch.last }
        before { subject }

        it '新增了股別丁' do
          expect(branch.name).to eq('丁')
        end

        it '股別丁隸屬法官張小明' do
          expect(branch.judge).to eq(subject)
        end

        it '股別丁的 missed 為 false' do
          expect(branch.missed).to be_falsey
        end
      end

      context '爬蟲資料中僅不存在股別 阿英滷肉飯' do
        let!(:fake_branch) { create :branch, court: court, name: '阿英滷肉飯', judge: judge_A, chamber_name: '臺灣高等法院民事庭' }
        subject! { Scrap::GetJudgesContext.new.perform }

        it '股別甲的 missed 為 false' do
          expect(branch1.reload.missed).to be_falsey
        end

        it '股別阿英滷肉飯的 missed 為 true' do
          expect(fake_branch.reload.missed).to be_truthy
        end

        it '股別丙的 missed 為 false(不變)' do
          expect(branch3.reload.missed).to be_falsey
        end
      end
    end

    context '從爬蟲資料中找到了法官王大明' do
      context '從爬蟲資料中找到了股別丙' do
        let(:data_string) { '臺灣高等法院民事庭,丙,王大明　法官,黃千鶴,2415' }

        it '不會新增股別' do
          expect { subject }.not_to change { Branch.count }
        end

        before { subject }
        it '股別丙隸屬法官王大明' do
          expect(branch3.reload.judge).to eq(judge_A)
        end

        it '法官中屁沒有股別' do
          expect(judge_B.branches.count).to eq(0)
        end
      end

      context '從爬蟲資料中找不到資料庫內的股別' do
        let(:data_string) { '臺灣高等法院民事庭,丁,王大明　法官,黃千鶴,2415' }
        let(:branch) { Branch.last }
        before { subject }

        it '新增了股別丁' do
          expect(branch.name).to eq('丁')
        end

        it '股別丁隸屬法官王大明' do
          expect(branch.judge).to eq(judge_A)
        end

        it '股別丁的 missed 為 false' do
          expect(branch.missed).to be_falsey
        end
      end
    end
  end
end
