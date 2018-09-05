class ProjectsController < ApplicationController
  def index
    @projects = Project.all.includes(:screenshot)
  end
end
