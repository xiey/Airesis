class PostPublishing < ActiveRecord::Base
  belongs_to :blog_post, class_name: 'BlogPost', foreign_key: :blog_post_id, inverse_of: :publishings
  belongs_to :group, class_name: 'Group', foreign_key: :group_id, inverse_of: :post_publishings
end
