require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'Rails.application.config.projects' do
    specify do
      expect(Rails.application.config.projects).to be_a Hash
    end
  end
end
