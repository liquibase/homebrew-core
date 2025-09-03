class Dolt < Formula
  desc "Git for Data"
  homepage "https://github.com/dolthub/dolt"
  url "https://github.com/dolthub/dolt/archive/refs/tags/v1.58.8.tar.gz"
  sha256 "f730a352f0483a379fb16af2e72365755244e9a7490e993e57bdbb299bfde984"
  license "Apache-2.0"
  version_scheme 1
  head "https://github.com/dolthub/dolt.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "dad89d54c2902804d0ea054a8187f0b977bed6af268553033eebbf131c61390a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3b838cecb60462fe34d10294ba612896b7211f029d44882de68b1386f0360037"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b421b0c6b61cb0d62204ee208ba1be24f331c6b3c3e7eef7a1f9f34ad4850042"
    sha256 cellar: :any_skip_relocation, sonoma:        "09e57d8b9f1dcd0d5890bb7de40289e619077cb0fcf7d389a6ad5126eacd460b"
    sha256 cellar: :any_skip_relocation, ventura:       "46a9fa3f6a20209fc3d7c22160dc2e46bf5c899d830d7151fb2723a01f600f66"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8d3ff74b3d1fc14d3aa692eb61466977ed45d4ac0dec215e4db5a33fd4ec1ffe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "feb875b94d338aca339e4115797ef3c2cf6c7f14264cd3f288d7f2e5ee037461"
  end

  depends_on "go" => :build

  def install
    chdir "go" do
      system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/dolt"
    end
  end

  def post_install
    (var/"log").mkpath unless (var/"log").exist?
    (var/"dolt").mkpath
  end

  service do
    run [opt_bin/"dolt", "sql-server"]
    keep_alive true
    log_path var/"log/dolt.log"
    error_log_path var/"log/dolt.error.log"
    working_dir var/"dolt"
  end

  test do
    ENV["DOLT_ROOT_PATH"] = testpath

    mkdir "state-populations" do
      system bin/"dolt", "init", "--name", "test", "--email", "test"
      system bin/"dolt", "sql", "-q", "create table state_populations ( state varchar(14), primary key (state) )"
      assert_match "state_populations", shell_output("#{bin}/dolt sql -q 'show tables'")
    end
  end
end
