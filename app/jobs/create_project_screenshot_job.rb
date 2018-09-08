class CreateProjectScreenshotJob < ApplicationJob
  def perform(project)
    screenshot = project.screenshots.build

    desktop_image = ScreenshotService.new.call(project.url, :desktop)
    mobile_image = ScreenshotService.new.call(project.url, :mobile)

    screenshot.desktop_image.attach(io: File.open(desktop_image), filename: File.basename(desktop_image))
    screenshot.mobile_image.attach(io: File.open(mobile_image), filename: File.basename(mobile_image))
    screenshot.save!
  end
end
