gem 'test-unit'
require 'test/unit'
require 'yaml'
require 'uber_config'
begin
  require File.join(File.dirname(__FILE__), '../lib/iron_cache')
rescue Exception => ex
  puts "Could NOT load current iron_cache: " + ex.message
  raise ex
end


class TestBase < Test::Unit::TestCase
  def setup
    puts 'setup'
    # check multiple config locations
    @config = UberConfig.load
    puts "config=" + @config.inspect
    @client = IronCache::Client.new(@config['iron'])
    @client.logger.level = Logger::DEBUG
    @client.cache_name = 'iron_cache_ruby_tests'

  end

  def clear_queue(queue_name=nil)
    #queue_name ||= @client.cache_name
    #puts "clearing queue #{queue_name}"
    #while res = @client.messages.get(:cache_name=>queue_name)
    #  p res
    #  puts res.body.to_s
    #  res.delete
    #end
    #puts 'cleared.'
  end

  def assert_performance(time)
    start_time = Time.now
    yield
    execution_time =  Time.now - start_time
    assert execution_time < time, "Execution time too big #{execution_time.round(2)}, should be #{time}"
  end



end
