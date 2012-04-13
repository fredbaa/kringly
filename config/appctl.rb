main do |m, config, controller|
  if config[:environment].nil?
    config[:environment] = config[:daemonize] ? 'production' : 'development'
  end

  call(config[:environment])
end

development do |m, config, controller|
  call :common
end

production do |m, config, controller|
  call :common

  unless config.include?(:servers)
    m.family.main_puppet.count = 3
  end
end

common do |m, config, controller|
  fam = m.single_family!

  if config.include?(:tag)
    proc_tag = "#{config[:tag]}.sortinghat.#{config[:environment]}"
  else
    proc_tag = "sortinghat.#{config[:environment]}"
  end

  if config.include?(:servers)
    count = config[:servers]
  else
    count = 1
  end

  logging_debug = true
  case config[:environment]
  when 'production'
    logging_debug = false
    logging_trace = false
  else
  end

  init_newrelic = lambda { |puppet, worker|
    if defined?(NewRelic::Agent)
      NewRelic::Agent.after_fork(:force_reconnect => true)
    end
  }

  m.proc_tag = proc_tag
  fam.thin_puppet(:proc_tag => proc_tag,
                  :adapter => :rails,
                  :adapter_options => config,
                  :logging_debug => logging_debug,
                  :logging_trace => logging_trace,
                  :count => count,
                  :after_fork => init_newrelic)
end
