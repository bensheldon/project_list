require 'selenium-webdriver'

class ScreenshotService
  DESKTOP_DIMENSIONS = [1200, 800]
  MOBILE_DIMENSIONS = [375, 800]

  DRIVER_IMPLICIT_WAIT = 5 # seconds
  DRIVER_PAGE_LOAD_TIMEOUT = 25 # seconds
  DRIVER_READ_TIMEOUT = 30 # seconds

  def call(url, device = :desktop, wait_for_assets_to_load: true)
    @wait_for_assets_to_load = wait_for_assets_to_load

    driver.navigate.to url
    wait_for_page_load

    if device == :desktop
      driver.manage.window.resize_to(*DESKTOP_DIMENSIONS)
    else
      driver.manage.window.resize_to(*MOBILE_DIMENSIONS)
    end

    tempfile = Tempfile.new(["", ".png"])
    driver.save_screenshot(tempfile.path)
    tempfile
  ensure
    driver.close if driver
  end

  private

  def resize_to_full_height
    # https://gist.github.com/elcamino/5f562564ecd2fb86f559
    page_width  = driver.execute_script("return Math.max(document.body.scrollWidth, document.body.offsetWidth, document.documentElement.clientWidth, document.documentElement.scrollWidth, document.documentElement.offsetWidth);")
    page_height = driver.execute_script("return Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight);")

    driver.manage.window.resize_to(page_width + 100, page_height + 100)
  end

  def driver_options
    chrome_options = {
        args: ['headless', 'hide-scrollbars'],
    }

    # https://github.com/heroku/heroku-buildpack-google-chrome#selenium
    chrome_binary = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
    chrome_options[:binary] = chrome_binary if chrome_binary.present?

    Selenium::WebDriver::Chrome::Options.new(chrome_options)
  end

  def driver_capabilities
    page_load_strategy = @wait_for_assets_to_load ? 'normal' : 'none'
    Selenium::WebDriver::Remote::Capabilities.chrome(pageLoadStrategy: page_load_strategy)
  end

  def driver_http_client
    Selenium::WebDriver::Remote::Http::Default.new.tap do |client|
      client.read_timeout = DRIVER_READ_TIMEOUT
    end
  end

  def driver
    @driver ||= Selenium::WebDriver.for(:chrome, desired_capabilities: driver_capabilities, options: driver_options, http_client: driver_http_client).tap do |driver|
      driver.manage.timeouts.implicit_wait = DRIVER_IMPLICIT_WAIT
      driver.manage.timeouts.page_load = DRIVER_PAGE_LOAD_TIMEOUT
    end
  end

  def wait_for_page_load
    wait = Selenium::WebDriver::Wait.new(timeout: DRIVER_PAGE_LOAD_TIMEOUT)
    wait.until do
      driver.execute_script("return document.readyState") == "complete"
    end
  rescue Selenium::WebDriver::Error::TimeOutError
    nil
  end
end