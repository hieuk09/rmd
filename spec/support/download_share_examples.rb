shared_examples 'download' do
  it 'downloads' do
    VCR.use_cassette(scenario) do
      capture_io { run_method }
      expect(File.exists?(file_path)).to eq true
    end
    File.delete(file_path)
  end
end
