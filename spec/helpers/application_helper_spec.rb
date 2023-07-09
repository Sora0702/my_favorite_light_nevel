require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#full_title' do
    it 'タイトルが動的に変化していること' do
      expect(full_title("title")).to eq("title - Novel Share")
    end

    it 'full_titleヘルパーの引数がnilの時にタイトルがNovel Shareと表示されること' do
      expect(full_title(nil)).to eq("Novel Share")
    end

    it 'full_titleヘルパーの引数がemptyの時にタイトルがNovel Shareと表示されること' do
      expect(full_title("")).to eq("Novel Share")
    end
  end
end
