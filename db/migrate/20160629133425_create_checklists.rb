class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.string   :title,                 null: false
      t.string   :checker
      t.datetime :start_at
      t.datetime :due_at
      t.string   :submitter
      t.datetime :submit_at
      t.integer  :checklist_template_id

      t.timestamps null: false
    end
  end
end
