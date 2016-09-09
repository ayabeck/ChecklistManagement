class CreateFormItems < ActiveRecord::Migration
  def change
    create_table :form_items do |t|
      t.string :type
      t.integer :order
      t.string :label
      t.string :value

      t.timestamps null: false
    end
  end
end
