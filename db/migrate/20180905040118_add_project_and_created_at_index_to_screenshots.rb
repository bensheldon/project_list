class AddProjectAndCreatedAtIndexToScreenshots < ActiveRecord::Migration[5.2]
  def change
    add_index :screenshots, [:project_id, :created_at], order: { created_at: :desc }
  end
end
