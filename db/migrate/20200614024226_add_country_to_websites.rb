class AddCountryToWebsites < ActiveRecord::Migration[6.0]
  def change
    add_column :websites, :country, :string
  end
end
