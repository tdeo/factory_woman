ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users do |t|
    t.string :name
    t.boolean :active
    t.integer :age
    t.timestamps
  end

  create_table :blogs do |t|
    t.integer :user_id
    t.string :url
    t.timestamps
  end

  create_table :articles do |t|
    t.string :title
    t.text :content
    t.integer :author_id
    t.integer :blog_id
    t.timestamps
  end
end
