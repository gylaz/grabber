module Grabber
  class Site
    include Util

    def initialize(url, path)
      @url = with_url_protocol(url)
      @download_path = path
    end

    def crawl
      index = 0
      page_urls = [format_url(@url)]

      while (url = page_urls[index])
        page = process_page(url)
        other_urls = page.links.map { |link| format_url(link) }.select do |link|
          URI.parse(link).host == uri.host
        end
        page_urls = page_urls | other_urls.compact

        index += 1
      end
    end

    def process_page(url)
      page = Page.new(url)
      page.crawl
      page.download(@download_path)
      page.download_assets(@download_path)
      page
    end
  end
end
