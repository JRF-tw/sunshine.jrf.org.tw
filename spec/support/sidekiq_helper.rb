module SidekiqHelper

  def sidekiq_reset!
    Sidekiq::Stats.new.queues.keys.each{ |queue| Sidekiq::Queue.new(queue).clear }
    Sidekiq::ScheduledSet.new.map(&:delete)
  end

  def fetch_sidekiq_jobs(worker_klass, method = nil, scheduled: false)
    queue = method ? "default" : worker_klass.get_sidekiq_options["queue"]
    ( scheduled ? Sidekiq::ScheduledSet.new : Sidekiq::Queue.new(queue) ).to_a.select do |j|
      if method # delay extension
        j = YAML::load(j.args.first)
        j[0] == worker_klass && j[1].to_s == method.to_s
      else
        j.klass.to_s == worker_klass.to_s
      end
    end
  end

  def fetch_sidekiq_last_job(queue: "default", scheduled: false)
    ( scheduled ? Sidekiq::ScheduledSet.new : Sidekiq::Queue.new(queue) ).to_a.first
  end

  def change_sidekiq_jobs_size_of(worker_klass, method = nil, scheduled: false)
    change{ fetch_sidekiq_jobs(worker_klass, method, scheduled: scheduled).size }
  end

  def perform_sidekiq_job(sidekiq_job)
    sidekiq_job.klass.constantize.new.perform(*sidekiq_job.args)
  end
  
end