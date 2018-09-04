require 'rails_helper'

RSpec.describe ScreenshotService do
  let(:service) { described_class.new }
  let(:driver) { instance_double(Selenium::WebDriver::Chrome::Driver) }

  before do
    allow(driver).to receive_message_chain("navigate.to")
    allow(driver).to receive_message_chain("manage.window.resize_to")
    allow(driver).to receive(:save_screenshot)
  end

  describe '#call' do
    it 'creates a screenshot' do
      allow(Selenium::WebDriver).to receive(:for).and_return(driver)
      screenshot_file = service.call('http://example.com')
    end
  end
end