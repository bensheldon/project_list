class CreateScreenshots < ActiveRecord::Migration[5.2]
  def change
    create_table :screenshots do |t|
      t.timestamps
      t.references :project, foreign_key: true
    end
  end
end
