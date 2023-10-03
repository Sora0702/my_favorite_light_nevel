require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#full_title' do
    it 'タイトルが動的に変化していること' do
      expect(full_title("title")).to eq("title - Okinove")
    end

    it 'full_titleヘルパーの引数がnilの時にタイトルがOkinoveと表示されること' do
      expect(full_title(nil)).to eq("Okinove")
    end

    it 'full_titleヘルパーの引数がemptyの時にタイトルがOkinoveと表示されること' do
      expect(full_title("")).to eq("Okinove")
    end
  end
end
