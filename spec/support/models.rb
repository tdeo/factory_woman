class User < ActiveRecord::Base; end

class Blog < ActiveRecord::Base
  belongs_to :user
  alias_attribute :user_alias_id, :user_id
end

class Article < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user, foreign_key: :author_id
end
