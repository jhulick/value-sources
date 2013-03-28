# encoding: UTF-8

# This is the Value Services configuration file. Restart the service with
# 'value-services restart' after updating this file.

Value::Services::Config.configure do
  # Set the logging level to debug, info, warn, error, or fatal. The debug
  # level logs all messages.
  log :info

  application 'value.exercise.bfelob' do

    value_source 'my-value-source' do
      klass 'StaticValueSource'
      value 'test'
      specification 'test'
      params :a => 'a', :b => 'b'
    end
  end
end
