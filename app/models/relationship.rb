class Relationship < ApplicationRecord
  belongs_to :follw, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  
end
