module GemGeek
	module Helpers
		def self.remove_key! (x, key)
			#really remoes the keys
			x.reject!{|k, v| key == k} if x.is_a? Hash
			x.each{|k, v| self.remove_key!(x[k], key)}
			#if we have an array, we simply loop through it
			x.each{|v| self.remove_key!(v, key)} if x.is_a? Array
			#if we rather have and hash, we loop through it anyway but only through values
		end
		
		def self.except_nested(x, key)
		  case x
		  	when Hash then x = x.inject({}) {|m, (k, v)| m[k] = self.except_nested(v, key) unless k == key ; m }
		  	when Array then x.map! {|e| except_nested(e,key)}
		  end
		  x
		end
	end
end
