namespace :git_circling do
  patch_head="local--patch-head"
  local_head="local"

  def branch_exist?(branch_name)
    %x[git branch][/#{branch_name}/] ? true : false
  end

  def store_topic_description(topic_message, topic_commit_message)
    sh %[sed -e 's/<patch description>/#{topic_message}/' -i .topmsg]
    sh "git add .topmsg"
    sh "git commit -m'#{topic_commit_message}'"
  end

  def current_branch_name
    %x[git symbolic-ref HEAD 2>/dev/null].strip().gsub(/refs\/heads\//, '')
  end

  def topgit_remote_configured?
    not %x[git config --get topgit.remote].empty?
  end

  desc "initial setup of local branch and topic tree"
  task :setup do
    sh "git config gitflow.patch-head '#{patch_head}'"
    break if branch_exist? patch_head
    sh "git checkout -b #{local_head}"
    sh "tg create #{patch_head}"
    store_topic_description "Head of the topic tree",
                            "setup local topic branch structure"
    sh "git checkout #{local_head}"
  end

  desc "setup a upstream mirror on a bare remote repository"
  task :setup_mirror do
    gitflow_remote_uri = ask("Enter uri to the bare remote", "GITFLOW_REMOTE_URI")
    sh "git push --set-upstream --mirror #{gitflow_remote_uri}"
  end

  desc "initialize a clone of a fully setup mirror"
  task :new_work_copy do
    #maybe with place in the post-checkout hook
    gitflow_remote_name = ask("Enter remote name",
                              "GITFLOW_REMOTE_NAME",
                              "origin")
    original_branch = current_branch_name
    sh "git branch --set-upstream #{local_head} \
            #{gitflow_remote_name}/#{local_head}"
    sh "tg remote --populate #{gitflow_remote_name}"
    sh "git checkout #{patch_head}"
    sh "tg update"
    sh "git checkout #{original_branch}"
  end

  desc "fork a new topic on top of #{local_head}"
  task :new_topic do
    new_topic_branch = ask("Enter new topic name", "NEW_TOPIC_BRANCH")
    new_topic_description = ask("Description for the new topic",
                                "NEW_TOPIC_DESCRIPTION")
    original_branch = current_branch_name
    sh "git checkout #{local_head}"
    sh "tg create #{new_topic_branch}"
    store_topic_description(new_topic_description, new_topic_branch)
    sh "git checkout #{patch_head}"
    sh "tg depend add #{new_topic_branch}"
    sh "tg push" if topgit_remote_configured?
    sh "git checkout #{new_topic_branch}"
  end
end
