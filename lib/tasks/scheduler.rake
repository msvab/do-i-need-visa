require 'net/http'

namespace :scheduler do

  desc 'Checks for source data updates'
  task check_source_updates: :environment do
    puts 'Started checking for source updates'

    def execute_request(uri, request, source)
      response = Net::HTTP.start(uri.host, uri.port) { |http|
        http.request(request)
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
    end

    check_source_by_etag = lambda { |source|
      uri = URI(source.url)
      req = Net::HTTP::Get.new(uri)
      req['If-None-Match'] = source.etag

      execute_request(uri, req, source)
    }

    check_source_by_last_modified = lambda { |source|
      uri = URI(source.url)
      req = Net::HTTP::Get.new(uri)
      req['If-Modified-Since'] = source.last_modified.httpdate

      execute_request(uri, req, source)
    }

    sources_to_check = VisaSource.where { (updated == false) & (etag != nil) }
    puts "Found #{sources_to_check.length} sources to check by ETag"
    sources_to_check.each &check_source_by_etag

    sources_to_check = VisaSource.where { (updated == false) & (last_modified != nil) }
    puts "Found #{sources_to_check.length} sources to check by Last Modified"
    sources_to_check.each &check_source_by_last_modified

    puts 'Finished checking for source updates'
  end

end
