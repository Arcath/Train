xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "News"
    xml.description "The news from " + System.find(:first, :conditions => "variable = 'sitename'").value || "Train CMS"
    xml.link root_url
    
    for post in @rssposts
      xml.item do
        xml.title post.topic.title
        xml.description post.body.tbbc
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link formatted_topic_url(post.topic)
        xml.guid formatted_topic_url(post.topic)
      end
    end
  end
end
