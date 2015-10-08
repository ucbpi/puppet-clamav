require 'spec_helper'

describe 'clamav::scan' do
  let(:title) { 'virus-scan' }

  context 'default parameters' do
    let(:params) { { } }
    it { should compile }
    it { should contain_file('/etc/clamav').with({
      :ensure => 'directory',
      :owner  => 'clam',
    })}
    it { should contain_file('/etc/clamav/scans').with({
      :ensure => 'directory',
      :owner  => 'clam',
    })}
    it { should contain_file('/etc/clamav/scans/virus-scan').with({
      :ensure  => 'present',
      :owner   => 'clam',
      :mode    => '0500',
      :require => 'Class[Clamav]',
      :content => /^BIN='\/usr\/bin\/clamscan'$/,
    })}
    it { should contain_cron('clamav-scan-virus-scan').with({
      :ensure   => 'present',
      :command  => '/etc/clamav/scans/virus-scan',
      :hour     => /[0-9]|[1-5][0-9]/,
      :minute   => /[0-9]|[1-5][0-9]/,
      :weekday  => nil,
      :month    => nil,
      :monthday => nil,
      :require  => 'File[/etc/clamav/scans/virus-scan]',
    })}
  end

  context 'verify action items' do
    let(:params) { {
      'action_virus' => '/usr/local/sbin/send-virus-alert',
      'action_ok' => '/usr/local/sbin/log-scan-report',
      'action_error' => '/usr/local/sbin/send-error-alert', } }
    it do
      should contain_file('/etc/clamav/scans/virus-scan').with({
        'content' => /^\s+\/usr\/local\/sbin\/send-virus-alert$/
      })
      should contain_file('/etc/clamav/scans/virus-scan').with({
        'content' => /^\s+\/usr\/local\/sbin\/log-scan-report$/
      })
      should contain_file('/etc/clamav/scans/virus-scan').with({
        'content' => /^\s+\/usr\/local\/sbin\/send-error-alert$/
      })
    end
  end

  context 'without move directory' do
    let(:params) { { 'move' => '' } }
    it { should contain_file('/etc/clamav/scans/virus-scan').without_content(
      /--move=/
    )}
  end

  context 'with move directory' do
    let(:params) { {'move' => '/var/lib/clamav/quarantine'} }
    it { should contain_file('/etc/clamav/scans/virus-scan').with_content(
      /--move=\/var\/lib\/clamav\/quarantine/
    )}
  end

  context 'with an alternative binary defined' do
    let :params do { :clamscan_bin => '/usr/local/bin/clamscan' } end
    it { should contain_file('/etc/clamav/scans/virus-scan').with_content(
      /^BIN='\/usr\/local\/bin\/clamscan'$/
    )}
  end

  context 'with an invalid binary defined' do
    let :params do { :clamscan_bin => '$(which clamscan)' } end
    it do
      should compile.and_raise_error(/"\$\(which clamscan\)" is not an absolute path./)
    end
  end

  context 'scheduled scan' do
    #
    # Test for disabled scans
    context 'disabled' do
      let(:params) { { 'enable' => false } }
      it {
        should contain_cron('clamav-scan-virus-scan').with_ensure('absent')
      }
    end

    #
    # Test for enabled scans
    context 'enabled/default' do
      let(:params) { {
        'hour' => '10',
        'minute' => '30', } }
      it do
        should contain_cron('clamav-scan-virus-scan').with({
          'ensure' => 'present',
          'command' => '/etc/clamav/scans/virus-scan',
          'hour' => '10',
          'minute' => '30',
          'weekday' => nil,
          'require' => 'File[/etc/clamav/scans/virus-scan]',
        })
      end

    end
  end
end
