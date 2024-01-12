class RenamePostTagsToPostTagRelations < ActiveRecord::Migration[6.1]
  def change
    rename_table :post_tags, :post_tag_relations
  end
end
