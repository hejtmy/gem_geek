#Heavilly influenced by https://github.com/AcceptableIce/board-game-gem

# BGG API class that pulls in data and takes a hash as a set of options for the
# query string

require 'nokogiri'
require 'open-uri'

module BGGAPI
  BGG_API2_URL = "https://boardgamegeek.com/xmlapi2"
  SLEEP = 0.25
  RETRIES = 3
  
  WAITING_PERIOD = 1 #in s

  SSL_SETTINGS = OpenSSL::SSL::VERIFY_NONE

  def self.request_xml(type, options, api = 2)
    options = { retries: RETRIES}.merge(options)
    params = self.hash_to_uri(options)
    if api == 2
      api_path = "#{BGG_API2_URL}/#{type}?#{params}"
    else
      api_path = "#{API_1_ROOT}/#{type}/#{options[:id]}?stats=#{options[:stats] ? 1 : 0}"
    end
    p api_path
    value = self.retryable(tries: options[:retries], on: OpenURI::HTTPError) do
      open(api_path, ssl_verify_mode: SSL_SETTINGS) do |file|
        if file.status[0] != "200"
          sleep SLEEP
          raise OpenURI::HTTPError.new('BGG didnt reply', 'io')
        else
          value = Nokogiri::XML(file.read)
        end
      end
    end 
    value
  end

  def self.retryable(options = {}, &block)
    opts = {:on => Exception}.merge(options)

    retry_exception, retries = opts[:on], opts[:tries]

    begin
      return yield
    rescue retry_exception => e
      puts e
      retry if (retries -= 1) > 0
    end
    yield
  end

  def self.hash_to_uri(hash)
    return hash.to_a.map { |x| "#{x[0]}=#{x[1]}" }.join("&")
  end
end