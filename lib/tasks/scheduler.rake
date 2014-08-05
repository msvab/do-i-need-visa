require 'net/http'

namespace :scheduler do

  desc 'Checks for source data updates'
  task check_source_updates: :environment do
    puts 'Started checking for source updates'

    sources_to_check = VisaSource.where { (updated == false) & (etag != nil) }
    puts "Found #{sources_to_check.length} sources to check by ETag"
    sources_to_check.each { |source|
      uri = URI(source.url)
      req = Net::HTTP::Get.new(uri)
      req['If-None-Match'] = source.etag

      response = Net::HTTP.start(uri.host, uri.port) {|http|
        http.request(req)
      }

      if response.code == '304'
        puts "Source not modified: #{source.url}"
      elsif response.code == '200'
        source.updated = true
        source.save!
        puts "Source modified: #{source.url}"
      else
        puts "Unexpected response code #{response.code} from #{source.url}"
      end
    }

    puts 'Finished checking for source updates'
  end

end
