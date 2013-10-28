class Status < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates_presence_of :user_id
	validates :content, presence: true, length: { maximum: 140 }
	
	def self.replies(status)
		where(in_reply_to: status.id).order("created_at")
	end

	def reply_to
		Status.where(id: self.in_reply_to).first
	end

    def self.from_users_followed_by(user)
	    followed_user_ids = "SELECT followed_id FROM relationships
	                         WHERE follower_id = :user_id"
	    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
	          user_id: user.id)
  end
end
