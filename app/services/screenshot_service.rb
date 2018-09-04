require 'selenium-webdriver'

class ScreenshotService
  DESKTOP_DIMENSIONS = [1200, 800]
  MOBILE_DIMENSIONS = [375, 800]

  def call(url, device = :desktop)
    chrome_options = {
      args: ['headless']
    }

    # https://github.com/heroku/heroku-buildpack-google-chrome#selenium
    chrome_binary = ENV.fetch('GOOGLE_CHROME_BIN', nil)
    chrome_options['binary'] = chrome_binary if chrome_binary.present?

    driver_options = Selenium::WebDriver::Chrome::Options.new(chrome_options)
    driver = Selenium::WebDriver.for(:chrome, options: driver_options)

    driver.navigate.to url

    if device == :desktop
      driver.manage.window.resize_to(*DESKTOP_DIMENSIONS)
    else
      driver.manage.window.resize_to(*MOBILE_DIMENSIONS)
    end

    driver.save_screenshot(Rails.root.join('tmp', 'screenshots', "#{SecureRandom.uuid}.png"))
  end

  private

  def resize_to_full_height
    # https://gist.github.com/elcamino/5f562564ecd2fb86f559
    page_width  = driver.execute_script("return Math.max(document.body.scrollWidth, document.body.offsetWidth, document.documentElement.clientWidth, document.documentElement.scrollWidth, document.documentElement.offsetWidth);")
    page_height = driver.execute_script("return Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight);")

    driver.manage.window.resize_to(page_width + 100, page_height + 100)
  end
end