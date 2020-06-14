class AddKeywordToWebsites < ActiveRecord::Migration[6.0]
  def change
    add_column :websites, :keyword, :string
  end
end
