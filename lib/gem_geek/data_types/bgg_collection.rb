#modified from https://github.com/AcceptableIce/board-game-gem/

module GemGeek
	class BGGCollection < BGGBase

		attr_accessor :count, :items
		attr_writer :items
		
		def initialize(xml = nil)
			if !xml.nil?
				@count = get_integer(xml, "items", "totalitems")
				@items = []
				xml.css("item").each do |item|
					@items.push(BGGCollectionItem.new(item))
				end
			else
				@count = 0
				@items = []
			end
		end

		def status_of(id)
			item = @items.find { |x| x.id == id}
			item ? item.status : nil
		end

		def owned
			return filter_by(:own)
		end

		def previously_owned
			return filter_by(:prev_owned)
		end

		def wants
			return filter_by(:want)
		end

		def want_to_play
			return filter_by(:want_to_play)
		end

		def want_to_buy
			return filter_by(:want_to_buy)
		end

		def wishlist
			return filter_by(:wishlist)
		end

		def preordered
			return filter_by(:preordered)
		end

		def for_trade
			return filter_by(:for_trade)
		end
		
		private

		def filter_by(key)
			collection = BGGCollection.new()
			collection.items = @items.select { |x| x.status[key] }
			return collection
		end
	end
end