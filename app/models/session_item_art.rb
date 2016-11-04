class SessionItemArt < ActiveRecord::Base

	belongs_to :item_art

	belongs_to :user
end
