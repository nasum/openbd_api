require "spec_helper"

RSpec.describe Openbd do
  it "has a version number" do
    expect(Openbd::VERSION).not_to be nil
  end

  describe 'prepare_url' do
    context 'get method no isbn' do
      it do
        expect(OpenBD.prepare_url('get')).to eq "http://api.openbd.jp/v1/get"
      end
    end

    context 'get method single integer isbn' do
      it do
        expect(OpenBD.prepare_url('get', 9784990304645)).to eq "http://api.openbd.jp/v1/get?isbn=9784990304645"
      end
    end

    context 'get method single string isbn' do
      it do
        expect(OpenBD.prepare_url('get', '9784990304645')).to eq "http://api.openbd.jp/v1/get?isbn=9784990304645"
      end
    end

    context 'get method multi string isbn' do
      it do
        expect(OpenBD.prepare_url('get', '9784990304645, 9784990304646')).to eq "http://api.openbd.jp/v1/get?isbn=9784990304645, 9784990304646"
      end
    end

    context 'get method multi isbn use string array' do
      it do
        expect(OpenBD.prepare_url('get', ['9784990304645', '9784990304646'])).to eq "http://api.openbd.jp/v1/get?isbn=9784990304645, 9784990304646"
      end
    end

    context 'get method multi isbn use integer array' do
      it do
        expect(OpenBD.prepare_url('get', [9784990304645, 9784990304646])).to eq "http://api.openbd.jp/v1/get?isbn=9784990304645, 9784990304646"
      end
    end

    context 'coverage method' do
      it do
        expect(OpenBD.prepare_url('coverage')).to eq "http://api.openbd.jp/v1/coverage"
      end
    end

    context 'schema method' do
      it do
        expect(OpenBD.prepare_url('schema')).to eq "http://api.openbd.jp/v1/schema"
      end
    end
  end
end
