require 'spec_helper'

describe 'clamav' do

  context 'with default parameters' do

    it do
      should contain_package('clamav').with_ensure('installed')
    end

    dirs = [ '/etc/clamav', '/etc/clamav/scans' ]
    it do
      dirs.each do |d|
        should contain_file(d).with({
          'ensure' => 'directory',
          'owner' => 'clam' })
      end
    end

    it { should contain_file('/var/lib/clamav/local.ign2').with_ensure('absent') }
    it { should contain_file('/var/lib/clamav/local.sfp').with_ensure('absent')  }
    it { should contain_file('/var/lib/clamav/local.fp').with_ensure('absent')   }
  end

  context 'with valid whitelists set' do
    let :params do
      {
        :whitelist_sig => [ 'ClamAV-Test-Signature' ],
        :whitelist_sha => [
          'da39a3ee5e6b4b0d3255bfef95601890afd80709',
          'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
        ],
        :whitelist_md5 => [ 'd41d8cd98f00b204e9800998ecf8427e' ]
      }
    end

    it { should contain_file('/var/lib/clamav/local.ign2').with({
      :ensure  => 'file',
      :owner   => 'clam',
      :group   => 'clam',
      :content => /ClamAV-Test-Signature/,
    })}
    it { should contain_file('/var/lib/clamav/local.sfp').with({
      :ensure  => 'file',
      :owner   => 'clam',
      :group   => 'clam',
      :content => /da39a3ee5e6b4b0d3255bfef95601890afd80709\ne3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855/,
    })}
    it { should contain_file('/var/lib/clamav/local.fp').with({
      :ensure  => 'file',
      :owner   => 'clam',
      :group   => 'clam',
      :content => /d41d8cd98f00b204e9800998ecf8427e/,
    })}
  end

  context 'with just whitelist_sig set' do
    let :params do
      {
        :whitelist_sig => [ 'ClamAV-Test-Signature' ],
      }
    end

    it { should contain_file('/var/lib/clamav/local.ign2').with({
      :ensure  => 'file',
      :owner   => 'clam',
      :group   => 'clam',
      :content => /ClamAV-Test-Signature/,
    })}
    it { should contain_file('/var/lib/clamav/local.sfp').with_ensure('absent')  }
    it { should contain_file('/var/lib/clamav/local.fp').with_ensure('absent')   }
  end

  context 'with just whitelist_sha set' do
    let :params do
      {
        :whitelist_sha => [
          'da39a3ee5e6b4b0d3255bfef95601890afd80709',
          'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
        ],
      }
    end

    it { should contain_file('/var/lib/clamav/local.sfp').with({
      :ensure  => 'file',
      :owner   => 'clam',
      :group   => 'clam',
      :content => /da39a3ee5e6b4b0d3255bfef95601890afd80709\ne3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855/,
    })}
    it { should contain_file('/var/lib/clamav/local.ign2').with_ensure('absent') }
    it { should contain_file('/var/lib/clamav/local.fp').with_ensure('absent')   }
  end

  context 'with just whitelist_md5 set' do
    let :params do
      {
        :whitelist_md5 => [ 'd41d8cd98f00b204e9800998ecf8427e' ]
      }
    end

    it { should contain_file('/var/lib/clamav/local.fp').with({
      :ensure  => 'file',
      :owner   => 'clam',
      :group   => 'clam',
      :content => /d41d8cd98f00b204e9800998ecf8427e/,
    })}
    it { should contain_file('/var/lib/clamav/local.ign2').with_ensure('absent') }
    it { should contain_file('/var/lib/clamav/local.sfp').with_ensure('absent')  }
  end

  context 'with whitelists set as strings' do
    let :params do
      {
        :whitelist_sig => 'ClamAV-Test-Signature',
        :whitelist_sha => 'da39a3ee5e6b4b0d3255bfef95601890afd80709',
        :whitelist_md5 => 'd41d8cd98f00b204e9800998ecf8427e',
      }
    end

    it do
      should compile.and_raise_error(/is not an Array/)
    end
  end
end
