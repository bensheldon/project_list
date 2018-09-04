class ProjectsTasks
  include Rake::DSL

  def initialize
    namespace :projects do
      desc 'Load all projects into the database'
      task :load => :environment do |t, args|
        Project.load!
      end

      desc 'Take all screenshots'
      task :screenshot => :environment do |t, args|
        Project.all.find_each do |project|
          CreateProjectScreenshotJob.perform_now(project)
        end
      end
    end
  end
end

ProjectsTasks.new