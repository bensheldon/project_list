class Project < ApplicationRecord
  has_many :screenshots

  class << self
    def instance(slug)
      self.where(slug: slug).first_or_create
    end

    # Loads city configuration data into database
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
        :url
    ]

    attr_accessor *ATTRIBUTES
  end

  delegate *self::Configuration::ATTRIBUTES, to: :configuration, allow_nil: true
end
