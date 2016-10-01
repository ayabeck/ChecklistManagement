class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.string   :title,            null: false
      t.string   :checker
      t.datetime :start_at
      t.datetime :due_at
      t.integer  :progression_rate, null: false, default: 0
      t.string   :submitter
      t.datetime :submit_at
      t.integer  :template_id

      t.timestamps null: false
    end
  end
end
