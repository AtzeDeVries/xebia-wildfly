
require 'uri'
require 'etc'
require "digest/md5"

class Puppet::Provider::Zip < Puppet::Provider
  def exists?
    File.directory?("#{resource[:destinationdir]}/wildfly-#{resource[:version]}")
  end


  def destroy
    rm('-rf', resource[:destinationdir] )
  end

  def user
    uid = File.stat(resource[:destinationdir]).uid
    Etc.getpwuid(uid).name
  end

  def user=(value)
    chown('-R', "#{resource[:user]}" , resource[:destinationdir])
  end

  def group
    gid = File.stat(resource[:destinationdir]).gid
    Etc.getgrgid(gid).name
  end

  def group=(value)
    chgrp('-R', "#{resource[:group]}", resource[:destinationdir])
  end

  private

  def filename(url)
    File.basename(url)
  end

  def clean_filename(url)
    File.basename(url, extension(url))
  end

  def extension(url)
    extent = ".zip"
    unless zip?(url)
      extent = File.extname(filename(url))
    end
    extent
  end

  def zip?(url)
    filename(url) =~ /(.zip)/
  end

  def md5_match?(file)
    unless resource[:md5hash].nil?
      raise "md5 hash does not match" unless resource[:md5hash] == Digest::MD5.file("#{file}").hexdigest
    end
  end

  def set_proxy_url
    unless resource[:proxy_url].nil?
      ENV['http_proxy'] = resource[:proxy_url]
    end
  end

  def url(version)
    return "http://download.jboss.org/wildfly/#{version}/wildfly-#{version}.zip"
  end

end