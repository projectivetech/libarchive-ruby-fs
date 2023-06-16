{
  libarchive-ruby-fs = {
    groups = ["default"];
    platforms = [];
    source = {
      path = ".";
      target = "ruby";
      type = "path";
    };
    targets = [];
    version = "0.2.4";
  };
  minitest = {
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1kg9wh7jlc9zsr3hkhpzkbn0ynf4np5ap9m2d8xdrb8shy0y6pmb";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "5.18.1";
  };
  rake = {
    groups = ["default" "development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "15whn7p9nrkxangbs9hh75q585yfn66lv0v2mhj6q6dl6x8bzr2w";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "13.0.6";
  };
  rake-compiler = {
    dependencies = ["rake"];
    groups = ["development"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1j166viy5491wawqn49fdaazwwrmkrr85c90qq92z3sdyzn8y9sa";
      target = "ruby";
      type = "gem";
    };
    targets = [];
    version = "0.9.9";
  };
}