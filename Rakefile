
VIM_HOME = File.join(ENV['HOME'], ".vim")
POWERLINE_FONTS = {
  "https://github.com/Lokaltog/powerline-fonts/blob/master/Menlo/Menlo%20Bold%20Italic%20for%20Powerline.ttf?raw=true" =>
    "Menlo Bold Italic for Powerline.ttf",
  "https://github.com/Lokaltog/powerline-fonts/blob/master/Menlo/Menlo%20Bold%20for%20Powerline.ttf?raw=true" =>
    "Menlo Bold for Powerline.ttf",
  "https://github.com/Lokaltog/powerline-fonts/blob/master/Menlo/Menlo%20Italic%20for%20Powerline.ttf?raw=true" =>
    "Menlo Italic for Powerline.ttf",
  "https://github.com/Lokaltog/powerline-fonts/blob/master/Menlo/Menlo%20Regular%20for%20Powerline.ttf?raw=true" =>
    "Menlo Regular for Powerline.ttf",
}
FONT_INSTALL_LOCATION = "/Library/Fonts"

desc "update all installed bundles including vundle"
task :bundle => ["bundle:update"]

namespace :bundle do

  task :update => ["bundle:update_vundle", "bundle:update_all"]

  desc "update vundle, the vim bundle manager"
  task :update_vundle do
    vundle_home = File.join(VIM_HOME, "bundle", "vundle")
    if File.exist? vundle_home
      Dir.chdir vundle_home do
        puts "Running update on vundle"
        sh "git pull"
      end
    else
      puts "Installing vundle into bundle directory"
      sh "git clone https://github.com/gmarik/vundle.git #{vundle_home}"
    end
  end

  desc "update all bundles installed through vundle"
  task :update_all do
    sh "vim +BundleInstall +qall"
  end
end

desc "Run all setup tasks"
task :setup => [
  "setup:tmp_dirs",
  "setup:install_bundles",
  "setup:command_t",
  "setup:link",
  "setup:install_powerline_fonts"
]

namespace :setup do

  desc "install all bundles"
  task :install_bundles => ["bundle"]

  desc "symlink the vimrc and gvimrc files in place"
  task :link do
    %w[vimrc gvimrc].each do |script|
      dotfile = File.join(ENV['HOME'], ".#{script}")
      if File.exist? dotfile
        warn "~/.#{script} already exists"
      else
        ln_s File.join('.vim', script), dotfile
      end
    end
  end

  desc "Create the temporary directories"
  task :tmp_dirs do
    mkdir_p "_data/backup"
    mkdir_p "_data/swap"
    mkdir_p "_data/undo"
  end

  desc "compile the CommandT bundle extensions"
  task :command_t do
    puts "Compiling Command-T plugin..."
    Dir.chdir "bundle/command-t/ruby/command-t" do
      # first try to read which ruby version is vim compiled against
      read_version = %{require "rbconfig"; print File.join(RbConfig::CONFIG["bindir"], RbConfig::CONFIG["ruby_install_name"])}
      ruby = `vim --cmd 'ruby #{read_version}' --cmd 'q' 2>&1 >/dev/null | grep -v 'Vim: Warning'`.strip
      # fall back to system rubies
      ruby = %w[/usr/bin/ruby1.8 /usr/bin/ruby].find {|rb| File.executable? rb } || 'ruby' if ruby.empty?
      cmd = Array(ruby) + %w[extconf.rb]
      sh(*cmd)
      sh "make clean && make"
    end
  end

  desc "download and install the appropriate fonts for powerline"
  task :install_powerline_fonts do
    puts "Downloading the fonts..."
    tmp_dir = "/tmp/vim-fonts"
    begin
      Dir.mkdir tmp_dir
      POWERLINE_FONTS.each { |font_url, name| sh %{wget #{font_url} -O "#{tmp_dir}/#{name}"} }
      sh "sudo cp #{tmp_dir}/* #{FONT_INSTALL_LOCATION}/"
    ensure
      sh "rm -rf #{tmp_dir}"
    end
  end

end

