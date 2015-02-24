require 'spec_helper'
require 'middleman-vcard'


describe 'MiddlemanVCard::VERSION' do

  it 'should have a semver compliant format' do
    version = MiddlemanVCard::VERSION
    expect(version).to_not be_empty
    expect(version).to match(/[0-9]+\.[0-9]+\.[0-9]+/)
  end

end

describe 'MiddlemanVCard::VERSION_MAJOR' do

  it 'should be positive' do
    expect(MiddlemanVCard::VERSION_MAJOR).to be >= 0
  end

end

describe 'MiddlemanVCard::VERSION_MINOR' do

  it 'should be positive' do
    expect(MiddlemanVCard::VERSION_MINOR).to be >= 0
  end

end

describe 'MiddlemanVCard::VERSION_PATCH' do

  it 'should be positive' do
    expect(MiddlemanVCard::VERSION_PATCH).to be >= 0
  end

end
