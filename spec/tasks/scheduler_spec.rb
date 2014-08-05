require 'rails_helper'
require 'rake'

describe 'Scheduler' do
  describe 'Check for source updates' do

    before do
      Rake.application.rake_require 'tasks/scheduler'
      Rake::Task.define_task(:environment)
    end

    let :run_rake_task do
      Rake::Task['scheduler:check_source_updates'].reenable
      Rake.application.invoke_task 'scheduler:check_source_updates'
    end

    it 'should detect change in ETag' do
      source = FactoryGirl.create(:visa_source, url: 'http://travel.state.gov/content/visas/english/visit/visa-waiver-program.html', last_modified: nil, etag: 'not-the-current-etag', updated: false)

      run_rake_task

      expect(VisaSource.first!.updated?).to eql true
    end

    it 'should not do anything for matching ETag' do
      source = FactoryGirl.create(:visa_source, url: 'http://travel.state.gov/content/visas/english/visit/visa-waiver-program.html', last_modified: nil, etag: '15f725-14ed4-4ffa5373a3c45', updated: false)

      run_rake_task

      expect(VisaSource.first!.updated?).to eql false
    end
  end
end
