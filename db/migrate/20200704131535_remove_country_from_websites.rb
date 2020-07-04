class RemoveCountryFromWebsites < ActiveRecord::Migration[6.0]
  def change
    remove_column :websites, :country, :string
  end
end
