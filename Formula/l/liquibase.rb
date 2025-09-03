class Liquibase < Formula
  desc "Library for database change tracking"
  homepage "https://www.liquibase.org/"
  url "https://package.liquibase.com/downloads/liquibase/homebrew/liquibase-4.33.0.tar.gz" 
  sha256 "689acfcdc97bad0d4c150d1efab9c851e251b398cb3d6326f75e8aafe40ed578"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  no_autobump! because: :requires_manual_review

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "41c94aa6826f3ffb843e01817c8b60b79ea54e9c61536539524b8611254d2a66"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "41c94aa6826f3ffb843e01817c8b60b79ea54e9c61536539524b8611254d2a66"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "41c94aa6826f3ffb843e01817c8b60b79ea54e9c61536539524b8611254d2a66"
    sha256 cellar: :any_skip_relocation, sonoma:        "309ba6ac0f42635065a35a15b2ea2cb996851246b0483d84266cdd9d9c3119c4"
    sha256 cellar: :any_skip_relocation, ventura:       "309ba6ac0f42635065a35a15b2ea2cb996851246b0483d84266cdd9d9c3119c4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "41c94aa6826f3ffb843e01817c8b60b79ea54e9c61536539524b8611254d2a66"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "41c94aa6826f3ffb843e01817c8b60b79ea54e9c61536539524b8611254d2a66"
  end

  depends_on "openjdk"

  def install
    rm(Dir["*.bat"])

    chmod 0755, "liquibase"
    libexec.install Dir["*"]
    (bin/"liquibase").write_env_script libexec/"liquibase", Language::Java.overridable_java_home_env
    (libexec/"lib").install_symlink Dir["#{libexec}/sdk/lib-sdk/slf4j*"]
  end

  def caveats
    <<~EOS
      You should set the environment variable LIQUIBASE_HOME to
        #{opt_libexec}
    EOS
  end

  test do
    system bin/"liquibase", "--version"
  end
end
