def ask(prompt, env, default="")
  return ENV[env] if ENV.include?(env)

  print "#{prompt} (#{default}): "
  resp = STDIN.gets.chomp

  resp.empty? ? default : resp
end
