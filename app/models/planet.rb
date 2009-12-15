class Planet < ActiveRecord::Base
	def self.update_from_feed(feed_url)
		feed = Feedzirra::Feed.fetch_and_parse(feed_url)
		add_entries(feed.entries)
	end
	def self.add_entries(entries)
		entries.each do |entry|
			unless exists? :guid => entry.id
				create!(
					:name         => entry.title,
					:summary      => entry.summary,
					:url          => entry.url,
					:published_at => entry.published,
					:guid         => entry.id
				)
			end
		end
	end
	def feed(entry)
		url=entry.url.scan(/http:\/\/(.*?)\//).join
		p=PlanetFeed.url_like(url)
		return p[0].name
	end
end
