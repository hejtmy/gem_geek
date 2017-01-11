PLAYS_PATH = 'spec/test_data/plays.txt'

#if no internet
def load_plays(path)
	f = File.open(path, 'r')
	plays = Nokogiri::XML(f.read)
	f.close
	return plays
end

plays_xml = load_plays(PLAYS_PATH)