class CarrierWaveForAssets < ActiveRecord::Migration
  def up
    table_prefix = 'newsletter_'
    begin
      table_prefix = ::Newsletter.table_prefix
    rescue
    end
    rename_column :"#{table_prefix}newsletter_assets", :filename, :image
  end

  def down
    table_prefix = 'newsletter_'
    begin
      table_prefix = ::Newsletter.table_prefix
    rescue
    end
    rename_column :"#{table_prefix}newsletter_assets", :image, :filename
  end
end
