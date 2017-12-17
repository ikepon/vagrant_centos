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

  task :upload_gemfile do
    on roles(:app) do
      execute :mkdir, '-p', 'sample/hoge/cap_sample'
      upload! "./Gemfile", 'sample/hoge/cap_sample/Gemfile'
      execute :ls, 'sample/hoge/cap_sample'
    end
  end

  task :download_file do
    on roles(:app) do
      file_name = "sample/test.txt"
      if test "[ -f #{file_name} ]"
        download! file_name, '.'
      end
    end
  end
end
