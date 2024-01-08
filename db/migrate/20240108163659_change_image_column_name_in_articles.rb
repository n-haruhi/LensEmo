class ChangeImageColumnNameInArticles < ActiveRecord::Migration[6.1]
  def change
    rename_column :articles, :image, :article_image
  end
end
