require 'rails_helper'
require 'digest'
require 'tasks/page_hash'

describe 'PageHash' do

  before do
    stub_request(:get, 'http://www.random-url/divspan').to_return(status: 200, body: SampleHTML::DIV_SPAN)
    stub_request(:get, 'http://www.random-url/nested').to_return(status: 200, body: SampleHTML::DOUBLE_SPAN)

    WebMock.disable_net_connect!
  end

  it 'should calculate hash of a text in an element defined by CSS selector for given URL' do
    hash = PageHash.calculate('http://www.random-url/divspan', 'div span')

    expect(hash).to eql Digest::MD5.hexdigest('The end!')
  end

  it 'should handle nested HTML elements' do
    hash = PageHash.calculate('http://www.random-url/nested', 'body')

    expect(hash).to eql Digest::MD5.hexdigest('The end!')
  end

  it 'should fail if more than one element found by the same CSS selector' do
    expect { PageHash.calculate('http://www.random-url/nested', 'span') }.to raise_error(/more than one element found/)
  end

  it 'should fail if no element found by the same CSS selector' do
    expect { PageHash.calculate('http://www.random-url/nested', 'div') }.to raise_error(/no element found/)
  end
end
