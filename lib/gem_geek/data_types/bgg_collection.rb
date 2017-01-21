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
		
		def add(item)
			#some validation???
			@items.push(item)
		end
		
		def status_of(id)
			item = @items.find { |x| x.id == id}
			item ? item.status : nil
		end
		
		def in_collection
			return select(:in_collection, true)
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
			collection_r = BGGCollection.new()
			collection_r.items = @items.select { |x| x.status[key] }
			return collection_r
		end
		
		def select(key, value, operator = :==)
			#converts key string to parameter
			# selects if
			collection_r = BGGCollection.new()
			@items.each do |item|
				param = item.send(key)
				if not param.nil? 
					collection_r.add(item) if param.send(operator, value) #weird syntax
				end
			end
			return collection_r
		end

		def select_fun(func, value)
			collection_r = BGGCollection.new()
			@items.each do |item|
				collection_r.add(item) if item.send(func, value)
			end
			return collection_r
		end
	end
end