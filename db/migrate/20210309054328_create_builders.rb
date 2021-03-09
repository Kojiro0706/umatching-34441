class CreateBuilders < ActiveRecord::Migration[6.0]
  def change
    create_table :builders do |t|
      t.string  :title, null:false
      t.text    :description, null:false
      t.integer :category_id, null:false
      t.string  :place
      t.references :user,    foreign_key: true
      t.timestamps
    end
  end
end
