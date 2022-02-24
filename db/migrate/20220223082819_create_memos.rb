class CreateMemos < ActiveRecord::Migration[6.0]
  def change
    create_table :memos do |t|
      t.text :title_history, null: false
      t.text :why_content
      t.text :who_content
      t.text :what_content
      t.text :where_content
      t.text :content,       null: false
      t.references :user,    null: false, foreign_key: true
      t.timestamps
    end
  end
end
