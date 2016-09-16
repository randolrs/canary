class Order < ActiveRecord::Base

	has_many :order_items

	belongs_to :user

	has_many :item_arts, :through => :order_items


	def order_item

		return self.order_items.last

	end

	def subtotal

		return self.order_item.item_art.price.to_i
	end
end
