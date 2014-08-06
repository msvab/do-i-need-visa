require 'rails_helper'
require 'rake'

describe 'Scheduler' do
  describe 'Check for source updates' do

    before do
      Rake.application.rake_require 'tasks/scheduler'
      Rake::Task.define_task(:environment)

      WebMock.disable_net_connect!
    end

    let :run_rake_task do
      Rake::Task['scheduler:check_source_updates'].reenable
      Rake.application.invoke_task 'scheduler:check_source_updates'
    end

    it 'should detect change in ETag' do
      source = FactoryGirl.create(:visa_source, url: 'http://www.random-url/etag', last_modified: nil, etag: 'wrong-etag', updated: false)

      stub_request(:get, 'http://www.random-url/etag').with(headers: {'If-None-Match' => 'wrong-etag'})

      run_rake_task

      expect(VisaSource.first!.updated?).to eql true
    end

    it 'should not do anything for matching ETag' do
      source = FactoryGirl.create(:visa_source, url: 'http://www.random-url.com/etag', last_modified: nil, etag: 'good-etag', updated: false)

      stub_request(:get, 'http://www.random-url.com/etag').with(headers: {'If-None-Match' => 'good-etag'})
        .to_return(status: 304)

      run_rake_task

      expect(VisaSource.first!.updated?).to eql false
    end

    it 'should not do any request for source with ETag which is known to be out of date' do
      source = FactoryGirl.create(:visa_source, url: 'http://www.random-url.com/etag', last_modified: nil, etag: 'good-etag', updated: true)

      run_rake_task

      expect(VisaSource.first!.updated?).to eql true
    end

    it 'should detect change in Last Modified date' do
      source = FactoryGirl.create(:visa_source, url: 'http://www.random-url.com/last_modified', last_modified: Date.current, etag: nil, updated: false)

      stub_request(:get, 'http://www.random-url.com/last_modified').with(headers: {'If-Modified-Since' => source.last_modified.httpdate})

      run_rake_task

      expect(VisaSource.first!.updated?).to eql true
    end

    it 'should not do anything when Last Modified date hasnt changed' do
      source = FactoryGirl.create(:visa_source, url: 'http://www.random-url.com/last_modified', last_modified: Date.current, etag: nil, updated: false)

      stub_request(:get, 'http://www.random-url.com/last_modified').with(headers: {'If-Modified-Since' => source.last_modified.httpdate})
        .to_return(status: 304)

      run_rake_task

      expect(VisaSource.first!.updated?).to eql false
    end

    it 'should not do any request for source with Last Modified date which is known to be out of date' do
      source = FactoryGirl.create(:visa_source, url: 'http://www.random-url.com/etag', last_modified: Date.current, etag: nil, updated: true)

      run_rake_task

      expect(VisaSource.first!.updated?).to eql true
    end
  end
end
