require "spec_helper"

class Example
  include Dobexer::ExceptionNotifier
end

describe Dobexer::ExceptionNotifier do
  it "should add an error method" do
    Example.new.respond_to?(:error).should be_true
  end

  context "when job attemps is grater than 0" do
    it "should return nil and not generate the notification" do
      job_mock = mock("A job")
      job_mock.stub!(:attempts).and_return(1)
      ExceptionNotifier::Notifier.should_not_receive(:exception_notification)

      Example.new.error(job_mock, nil).should be_nil
    end
  end

  context "when is the first job try" do
    it "should call the exception_notification method" do
      job_mock = mock("A job")
      job_mock.stub!(:attempts).and_return(0)

      msg = mock("A message")
      ExceptionNotifier::Notifier.should_receive(:exception_notification).and_return(msg)
      msg.should_receive(:deliver)

      Example.new.error(job_mock, "")
    end
  end
end

