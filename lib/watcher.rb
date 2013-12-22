require 'octokit'
require 'boxen/keychain'

module Watcher
  def self.client
    @client ||= Octokit::Client.new(:access_token => access_token)
  end

  def self.access_token
    keychain = Boxen::Keychain.new('dgoodlad')
    keychain.token
  end

  def self.watch_all_from_org(org)
    client.org_repos(org).each do |r|
      slug = "#{org}/#{r.name}"
      puts "Watching #{slug}"
      client.update_subscription(slug, :subscribed => true)
    end
  end
end
