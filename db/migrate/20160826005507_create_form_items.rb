class CreateFormItems < ActiveRecord::Migration
  def change
    create_table :form_items do |t|
      t.string  :type,        null: false
      t.integer :order,       null: false
      t.text    :label,       null: false
      t.text    :value
      t.integer :template_id
      t.integer :checklist_id

      t.timestamps null: false
    end
  end
end
