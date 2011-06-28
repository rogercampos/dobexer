Dobexer
=======

This gem aims to provide a simple integration of ExceptionNotification and
DelayedJob, so we can be emailed when an error occurs inside a job's
`perform`. It relies on collectiveidea's [delayed_job](https://github.com/collectiveidea/delayed_job) and smartinez87's [exception_notification](https://github.com/smartinez87/exception_notification) both the official versions you can find on rubygems.org.


Usage
-----

In order to make this thing work, you must use custom jobs with DelayedJob
(this is a DJ limitation) and then include the provided mixin:

    class MyJob
      include Dobexer::ExceptionNotifier

      def perform
        # Do work
      end
    end

Your Job class will then gain an `error` method which will perform the
integration with ExceptionNotification every time an exception occurs inside the
job's `perform`.


Sent notifications
------------------

Dobexer will send an exception notification only the first time a job fails,
so even if the job itself runs for 25 attemps or more, the notification will
be sent only once.


Fake Request
------------

ExceptionNotification expects a real *request* object to exists and of course
we don't have any from the DelayedJob context, this is why Dobexer will fake
it. Thus in the email sent by ExceptionNotification the request env will
appear like this:

    -------------------------------
    Request:
    -------------------------------

      * URL       : http://delayed_job_fake_host
      * IP address:
      * Parameters: {}
      * Rails root: /your/app/root


    -------------------------------
    Environment:
    -------------------------------

      * HTTP_HOST                                 : delayed_job_fake_host
      * REQUEST_METHOD                            : GET
      * REQUEST_URI                               : /
      * action_dispatch.request.content_type      :
      * action_dispatch.request.parameters        : {}
      * action_dispatch.request.path_parameters   : {}
      * action_dispatch.request.query_parameters  : {}
      * action_dispatch.request.request_parameters: {}
      * rack.input                                :
      * rack.request.query_hash                   : {}
      * rack.request.query_string                 :
      * rack.session                              : {}
      * rack.url_scheme                           : http

      * Process: 6666
      * Server : Hostname

