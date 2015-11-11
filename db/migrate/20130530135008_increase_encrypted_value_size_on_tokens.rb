class IncreaseEncryptedValueSizeOnTokens < ActiveRecord::Migration
  def change
    change_column :tokens, :encrypted_value, :text
  end
end
