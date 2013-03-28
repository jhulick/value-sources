# encoding: UTF-8

require '../lib/value/values'
require 'minitest/autorun'

class ConfigTest < MiniTest::Unit::TestCase

  def test_missing_host_raises
    assert_raises(RuntimeError) do
      Value::Config.new do
        # missing domain
      end
    end
  end

  def test_multiple_applications_raises
    assert_raises(RuntimeError) do
      Value::Config.new do
        application 'value.exercise.bfelob', 'value.exercise.bfelob' do
          value_source 'my-value-source' do
            klass 'StaticValueSource'
            specification 'test'
            params :a => 'a', :b => 'b'
          end
        end
      end
    end
  end

  def test_configure
    config = Value::Config.configure do
      application 'value.exercise.bfelob' do
        value_source 'my-value-source' do
          klass 'StaticValueSource'
          value 'test'
          specification 'test'
          params :a => 'a', :b => 'b'
        end
      end
    end
    refute_nil config
    assert_same config, Value::Config.instance
  end

  def test_missing_value_raises
    assert_raises(RuntimeError) do
      Value::Config.new do
        application 'value.exercise.bfelob' do
        end
      end
    end
  end

  def test_static_value_source
    config = Value::Config.new do
      application 'value.exercise.bfelob' do
        value_source 'my-value-source' do
          klass "StaticValueSource"
          value 'test-value'
          specification 'test'
          params :a => 'a', :b => 'b'
        end
      end
    end
    assert_equal 1, config.applications.size
    assert_equal 'test-value', config.applications['value.exercise.bfelob'].values['my-value-source'].process
  end

  def test_multiple_sources
    config = Value::Config.new do
      application 'value.exercise.bfelob' do
        value_source 'my-value-source' do
          klass 'StaticValueSource'
          specification 'test'
          value 'test'
          params :a => 'a', :b => 'b'
        end
      end
      application 'value.exercise.bumed' do
        value_source 'my-value-source' do
          klass 'StaticValueSource'
          specification 'test'
          value 'test'
          params :a => 'a', :b => 'b'
        end
      end
    end
    assert_equal 2, config.applications.size
    assert_equal 'value.exercise.bfelob', config.applications['value.exercise.bfelob'].name
    assert_equal 'value.exercise.bumed', config.applications['value.exercise.bumed'].name
  end

  def test_invalid_log_level
    assert_raises(RuntimeError) do
      config = Value::Config.new do
        log 'bogus'
        application 'value.exercise.bfelob' do
          value_source 'my-value-source' do
            klass 'StaticValueSource'
            specification 'test'
            params :a => 'a', :b => 'b'
          end
        end
      end
    end
  end

  def test_valid_log_level
    config = Value::Config.new do
      log :error
      application 'value.exercise.bfelob' do
        value_source 'my-value-source' do
          klass 'StaticValueSource'
          value 'test'
          specification 'test'
          params :a => 'a', :b => 'b'
        end
      end
    end
    assert_equal Logger::ERROR, Class.new.extend(Value::Log).log.level
  end
end
