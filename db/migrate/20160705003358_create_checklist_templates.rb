class CreateChecklistTemplates < ActiveRecord::Migration
  def change
    create_table :checklist_templates do |t|
      t.string :title
      t.text :description
      t.integer :checklists_count
      t.string :creator
      t.string :updater

      t.timestamps null: false
    end
  end
end
