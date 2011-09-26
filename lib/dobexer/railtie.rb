module Dobexer
  class Railtie < Rails::Railtie
    initializer "dobexer.initialize" do |app|
      app.config.after_initialize do

        if defined?(Delayed) && defined?(::ExceptionNotifier)
          module Dobexer
            module ExceptionNotifier
              def error(job, exception)
                return if job.attempts > 0

                env = {"HTTP_HOST" => "delayed_job_fake_host",
                      "REQUEST_URI" => "/",
                      "REQUEST_METHOD" => "GET",
                      "rack.input" => "",
                      "rack.url_scheme" => "http"}
                ::ExceptionNotifier::Notifier.exception_notification(env, exception).deliver
              end
            end
          end
        else
          puts "WARN: Dobexer not loaded, make sure to include delayed_job and exception_notifier in your Gemfile"
        end

      end
    end
  end
end
