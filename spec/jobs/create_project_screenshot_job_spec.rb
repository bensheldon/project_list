require 'rails_helper'

RSpec.describe CreateProjectScreenshotJob do
  let(:screenshot_service) { instance_double(ScreenshotService) }
  let(:project) { create :project, slug: 'island94' }

  before do
    allow(ScreenshotService).to receive(:new).and_return(screenshot_service)
    allow(screenshot_service).to receive(:call).with(a_kind_of(String), :desktop, wait_for_assets_to_load: true).and_return(file_fixture("desktop.png").open)
    allow(screenshot_service).to receive(:call).with(a_kind_of(String), :mobile, wait_for_assets_to_load: true).and_return(file_fixture("mobile.png").open)
  end

  describe '#perform' do
    it 'saves a new screenshot' do
      described_class.new.perform(project)
    end
  end
end