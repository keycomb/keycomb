class WaitlistJob < ActiveJob::Base
  @queue = :waitlist
end
