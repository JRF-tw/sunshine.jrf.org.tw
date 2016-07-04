# == Schema Information
#
# Table name: suits
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  summary    :text
#  content    :text
#  state      :string(255)
#  pic        :string(255)
#  suit_no    :integer
#  keyword    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Suit, type: :model do
  let!(:suit) { FactoryGirl.create :suit }

  it "FactoryGirl" do
    expect(suit).not_to be_new_record
  end

  context "search for suit" do
    it "suit" do
      su = FactoryGirl.create :suit, title: "超級厲害"
      word = "級"
      suit = Suit.find_state("").front_like_search(title: word, summary: word, content: word, keyword: word)
      expect(suit.first.title).to eq(su.title)
    end

    it "search for suit (state: 已懲處)" do
      su = FactoryGirl.create :suit, title: "超級厲害", state: "已懲處"
      word = "級"
      suit = Suit.find_state("已懲處").front_like_search(title: word, summary: word, content: word, keyword: word)
      expect(suit.first.title).to eq(su.title)
    end

    it "search for suit (word: nil)" do
      Suit.destroy_all
      FactoryGirl.create :suit, title: "哈哈哈", state: "處理中"
      FactoryGirl.create :suit, title: "超級厲害", state: "已懲處"
      FactoryGirl.create :suit, title: "SDEFXZDFSD", state: "已懲處"
      word = ""
      suit = Suit.find_state("").front_like_search(title: word, summary: word, content: word, keyword: word)
      expect(suit.count).to eq(3)
    end

  end

end
