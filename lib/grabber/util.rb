module Grabber
  module Util
 
    def format_url(url)
      url = strip_non_url_parts(url)
      if URI.parse(url).relative?
        url = URI.join("#{uri.scheme}://#{uri.host}", url).to_s
      end

      url.chop! while url.end_with?('/')
      with_url_protocol(url)
    end

    def with_url_protocol(path)
      path =~ /^http/ ? path : 'http://' + path
    end

    def strip_non_url_parts(link)
      if (index = (link =~ /#/))
        link.slice!(index..link.size)
      end
      if (index = (link =~ /\?/))
        link.slice!(index..link.size)
      end
      link
    end

    def uri
      URI.parse(@url)
    end
  end
end
