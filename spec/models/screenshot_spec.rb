require 'rails_helper'

RSpec.describe Screenshot, type: :model do
  describe '.recent' do
    it 'returns most recent for each project' do
      dayoftheshirt_screenshots= create_list :screenshot, 2, project: Project.instance('dayoftheshirt')
      island94_screenshots = create_list :screenshot, 2, project: Project.instance('island94')

      results = described_class.recent(1)
      expect(results).to eq [dayoftheshirt_screenshots.last, island94_screenshots.last]
    end
  end
end
