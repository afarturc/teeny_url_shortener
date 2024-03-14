class RemoveColumnCustomAliasFromLinks < ActiveRecord::Migration[7.1]
  def change
    remove_column :links, :custom_alias
  end
end
