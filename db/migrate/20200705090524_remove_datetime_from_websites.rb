class RemoveDatetimeFromWebsites < ActiveRecord::Migration[6.0]
  def change
    remove_column :websites, :datetime, :datetime
  end
end
