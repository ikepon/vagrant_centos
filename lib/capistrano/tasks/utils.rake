namespace :utils do
  task :ls do
    on roles(:app) do
      execute "ls"
    end
  end
  task :ruby_version do
    on roles(:app) do
      execute %[ruby -v]
    end
  end

  task :echo do
    ask(:user_name, nil) ## ここで聞いてる
    on roles(:app) do
      execute "echo #{fetch(:user_name) || raise("ユーザー名は必須だよん☆")}"
    end
  end
end
