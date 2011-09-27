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

