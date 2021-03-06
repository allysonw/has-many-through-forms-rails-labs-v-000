class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  accepts_nested_attributes_for :user, reject_if: proc { |attributes| attributes['username'].blank?}

  def user_id=(user_id)
    if !user_id.blank?
      user = User.find_or_create_by(id: user_id)
      self.user = user
    end
  end

  def user_attributes=(user_attributes)
    user_attributes.values.each do |user_attribute|
      if !user_attribute.blank?
        user = User.find_or_create_by(username: user_attribute)
        self.user = user
      end
    end
  end
end
