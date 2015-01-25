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

    it 'should detect change in content hash' do
      source = FactoryGirl.create(:visa_source, url: 'http://www.random-url/change', selector: 'div span', updated: false)

      stub_request(:get, 'http://www.random-url/change').to_return(status: 200, body: SampleHTML::DIV_SPAN)

      run_rake_task

      expect(VisaSource.first!.updated?).to eql true
    end
  end
end
