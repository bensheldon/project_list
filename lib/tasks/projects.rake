class ProjectsTasks
  include Rake::DSL

  def initialize
    namespace :projects do
      desc 'Load all projects into the database'
      task :load => :environment do |t, args|
        Project.load!
      end

      desc 'Take all screenshots'
      task :screenshot, [:slug] => :environment do |t, args|
        slug_override = args[:slug]

        projects = if slug_override
                     Project.where(slug: slug_override)
                   else
                     Project.all
                   end
        projects.find_each do |project|
          $stdout.puts "Generating screenshot for #{project.slug}"
          CreateProjectScreenshotJob.perform_now(project)
        end
      end
    end
  end
end

ProjectsTasks.new