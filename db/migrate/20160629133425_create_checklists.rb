class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.string :title
      t.string :checker
      t.datetime :start_at
      t.datetime :due_at
      t.string :submitter
      t.datetime :submit_at

      t.timestamps null: false
    end
  end
end
