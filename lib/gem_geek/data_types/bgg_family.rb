#modified from https://github.com/AcceptableIce/board-game-gem/

module GemGeek
	class BGGFamily < BGGBase

		attr_reader :id, :thumbnail, :image, :name, :alternate_names, :description
		
		def initialize(xml = nil)
			fill_data(xml)
		end
		
		def fake_init(id, name)
			@id = id
			@name = name
		end
		
		def fetch_info
			if not @id.nil?
				family_xml = BGGGetter.get_family(@id)
				fill_data(family_xml)
			end		
		end
		
		private
		def fill_data(xml)
			if not xml.nil?
				@id = get_integer(xml, "item", "id")
				@thumbnail = get_string(xml, "thumbnail")
				@image = get_string(xml, "image")
				@name = get_string(xml, "name[type='primary']", "value")
				@alternate_names = get_strings(xml, "name[type='alternate']", "value")
				@description = get_string(xml, "description")
			else
				@id = -1
				@thumbnail = ""
				@image = ""
				@name = ""
				@alternate_names = []
				@description = ""
			end
		end
	end
end