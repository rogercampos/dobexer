module Dobexer
  class Railtie < Rails::Railtie
    initializer "dobexer.initialize" do |app|
      app.config.after_initialize do

        if defined?(Delayed) && defined?(::ExceptionNotifier)
          require 'dobexer/error'
        end

      end
    end
  end
end
