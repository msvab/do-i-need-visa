require 'nokogiri'
require_relative 'page_hash'

namespace :scheduler do

  desc 'Checks for source data updates'
  task check_source_updates: :environment do
    Rails.logger.info 'Started checking for source updates'

    execute_request = lambda { |source|
      begin
        current_hash = PageHash.calculate(source.url, source.selector)
        if current_hash != source.page_hash
          source.updated = true
          source.save!
          Rails.logger.info "Source modified: #{source.url}"
        else
          Rails.logger.info "Source not modified: #{source.url}"
        end
      rescue Exception => e
        Rails.logger.warn "Unexpected error while checking #{source.url} for updates: #{e.message}"
      end
    }

    VisaSource.where { !updated && !page_hash.nil? }.each &execute_request

    Rails.logger.info 'Finished checking for source updates'
  end

  task :print_page_hash, [:url, :selector] => :environment do |t, args|
    begin
      puts PageHash.calculate(args[:url], args[:selector])
    rescue Exception => e
      puts e.message
    end
  end
end
