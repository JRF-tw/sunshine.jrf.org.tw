module SidekiqHelper

  def sidekiq_reset!
    Sidekiq::Stats.new.queues.keys.each { |queue| Sidekiq::Queue.new(queue).clear }
    Sidekiq::ScheduledSet.new.map(&:delete)
  end

  def fetch_sidekiq_jobs(worker_klass, method = nil, scheduled: false, queue: nil, wait_time: nil)
    queue ||= begin
                worker_klass.get_sidekiq_options["queue"]
              rescue
                nil
              end
    queue ||= "default"
    sleep(wait_time) if wait_time
    (scheduled ? Sidekiq::ScheduledSet.new : Sidekiq::Queue.new(queue)).to_a.select do |j|
      if method # delay extension
        j = YAML.load(j.args.first)
        j[0] == worker_klass && j[1].to_s == method.to_s
      else
        j.klass.to_s == worker_klass.to_s
      end
    end
  end

  def fetch_sidekiq_last_job(queue: "default", scheduled: false)
    sleep(1)
    (scheduled ? Sidekiq::ScheduledSet.new : Sidekiq::Queue.new(queue)).to_a.first
  end

  def change_sidekiq_jobs_size_of(worker_klass, method = nil, scheduled: false, queue: nil)
    change { fetch_sidekiq_jobs(worker_klass, method, scheduled: scheduled, queue: queue).size }
  end

  def perform_sidekiq_job(sidekiq_job)
    sidekiq_job.klass.constantize.new.perform(*sidekiq_job.args)
  end

end
