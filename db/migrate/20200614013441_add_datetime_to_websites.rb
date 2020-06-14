class AddDatetimeToWebsites < ActiveRecord::Migration[6.0]
  def change
    add_column :websites, :datetime, :datetime
  end
end
