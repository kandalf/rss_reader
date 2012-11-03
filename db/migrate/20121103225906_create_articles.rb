class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :link
      t.text :description
      t.date :pub_date
      t.boolean :starred
      t.boolean :read
      t.integer :subscription_id

      t.timestamps
    end
  end
end
