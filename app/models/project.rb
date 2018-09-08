class Project < ApplicationRecord
  has_one :screenshot, -> { recent(1).with_attached_desktop_image }, class_name: 'Screenshot', inverse_of: :project
  has_many :screenshots, dependent: :destroy

  class << self
    def instance(slug)
      self.where(slug: slug).first_or_create
    end

    def load!
      configs = Rails.configuration.projects
      configs.each do |slug, config|
        instance(slug)
      end
    end
  end

  def configuration
    @configuration ||= Configuration.new(Rails.configuration.projects[slug])
  end

  class Configuration
    include ActiveModel::Model

    ATTRIBUTES = [
        :name,
        :url,
        :description,
        :wait_for_assets_to_load,
    ]

    attr_accessor *ATTRIBUTES
  end

  delegate *self::Configuration::ATTRIBUTES, to: :configuration, allow_nil: true

  def wait_for_assets_to_load
    @wait_for_assets_to_load.nil? ? true : @wait_for_assets_to_load
  end
end
