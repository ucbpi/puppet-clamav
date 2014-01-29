require 'spec_helper'

describe 'clamav::scan' do
  let(:title) { 'virus-scan' }

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
