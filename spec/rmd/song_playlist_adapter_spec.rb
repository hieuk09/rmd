require 'spec_helper'

describe RMD::SongPlaylistAdapter do
  let(:adapter) { described_class.new(song) }

  describe '#songs' do
    let(:song) { instance_double('RMD::NCT::Song', data_link: data_link) }
    subject { adapter.songs }

    context 'when song has the link' do
      let(:data_link) { 'data_link' }
      it { is_expected.to eq [data_link] }
    end

    context 'when song does not have the link' do
      let(:data_link) { nil }
      it { is_expected.to eq [] }
    end
  end

  describe '#errors' do
    let(:song) { instance_double('RMD::NCT::Song', errors: errors) }
    subject { adapter.errors }

    context 'when song has the error' do
      let(:errors) { 'errors' }
      it { is_expected.to eq [errors] }
    end

    context 'when song does not have the error' do
      let(:errors) { nil }
      it { is_expected.to eq [] }
    end
  end
end
