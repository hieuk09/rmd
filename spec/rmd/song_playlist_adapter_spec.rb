require 'spec_helper'

describe RMD::SongPlaylistAdapter do
  let(:adapter) { described_class.new(song) }

  describe '#songs' do
    let(:data_link) { 'data_link' }
    let(:song) { instance_double('RMD::NCT::Song', data_link: data_link) }
    subject { adapter.songs }
    it { is_expected.to eq [data_link] }
  end

  describe '#errors' do
    let(:errors) { 'errors' }
    let(:song) { instance_double('RMD::NCT::Song', errors: errors) }
    subject { adapter.errors }
    it { is_expected.to eq [errors] }
  end
end
