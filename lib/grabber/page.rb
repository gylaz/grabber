module Grabber
  class Page
    include Util
    attr_reader :links

    def initialize(url)
      @url = url
      @assets = []
      @links = []
    end

    def crawl
      puts "Grabbing: #{uri.to_s}"

      content.search('img').each do |asset|
        @assets << asset['src']
      end

      content.search('a').each do |asset|
        location = asset['href']
        next if location.nil? || location == '' || location[/^#/]

        @links << location # if on same domain
      end

      @links.compact!
      @links.uniq! if @links
    end

    def uri
      URI.parse(@url)
    end

    def content
      Nokogiri::HTML(uri.read)
    end

    def basename
      if uri.path.nil? || uri.path == ''
        "index.html"
      else
        uri.path.split('/').last + ".html"
      end
    end

    def download(directory)
      local_path = File.expand_path(File.join(directory, basename))
      File.open(local_path, "wb") do |file|
        file.write open(uri).read
      end
    end

    def download_assets(directory)
      @assets.each do |asset|
        local_path = File.expand_path(File.join(directory, File.basename(asset)))
        File.open(local_path, "wb") do |file|
          begin
            file.write open(format_url(asset)).read
          rescue OpenURI::HTTPError => e
            puts "Failed download for #{format_url(asset)}: #{e.message}"
          end
        end
      end
    end
  end
end
