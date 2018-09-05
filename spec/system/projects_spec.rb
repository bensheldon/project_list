require 'rails_helper'

RSpec.describe 'Projects', type: :system do
  before do
    Project.load!
  end

  it 'shows all projects on frontpage' do
    visit root_path
  end
end
