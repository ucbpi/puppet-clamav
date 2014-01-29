require 'spec_helper'

describe 'clamav' do
  context "package" do
    it do
      should contain_package('clamav').with_ensure('installed')
    end
  end

  context 'required directories' do
    dirs = [ '/etc/clamav', '/etc/clamav/scans' ]
    it do
      dirs.each do |d|
        should contain_file(d).with({
          'ensure' => 'directory',
          'owner' => 'clam' })
      end
    end
  end
end
