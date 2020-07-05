class AddDescriptionToWebsites < ActiveRecord::Migration[6.0]
  def change
    add_column :websites, :description, :string
  end
end
