class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :website, null: false, foreign_key: true
      t.string :name
      t.string :summary
      t.string :url
      t.date :date
      t.text :content

      t.timestamps
    end
  end
end
