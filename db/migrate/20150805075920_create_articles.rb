class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :profile_id
      t.string :article_type
      t.integer :publish_year
      t.date :paper_publish_at
      t.date :news_publish_at
      t.string :title
      t.string :journal_no
      t.string :journal_periods
      t.integer :start_page
      t.integer :end_page
      t.string :editor
      t.string :author
      t.string :publisher
      t.string :publish_locat
      t.string :department
      t.string :degree
      t.string :source
      t.text :memo
      t.timestamps
    end
    add_index :articles, :profile_id
  end
end
