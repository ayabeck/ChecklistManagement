class CreateChecklistTemplates < ActiveRecord::Migration
  def change
    create_table :checklist_templates do |t|
      t.string  :title,            null: false
      t.text    :description
      t.integer :checklists_count, null: false, default: 0
      t.string  :creator,          null: false
      t.string  :updater,          null: false

      t.timestamps null: false
    end
  end
end
