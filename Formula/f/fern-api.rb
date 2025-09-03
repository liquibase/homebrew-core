class FernApi < Formula
  desc "Stripe-level SDKs and Docs for your API"
  homepage "https://buildwithfern.com/"
  url "https://registry.npmjs.org/fern-api/-/fern-api-0.68.0.tgz"
  sha256 "18c41b826a750eaa2b330556fba26fe5dabe30b62d049db519b9006f1a760052"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "bca88838802fa8271aadabb7a06d4a6b8c38f8abee5d5106238320c3b63fb9d8"
  end

  depends_on "node"

  def install
    # Supress self update notifications
    inreplace "cli.cjs", "await this.nudgeUpgradeIfAvailable()", "await 0"
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    system bin/"fern", "init", "--docs", "--org", "brewtest"
    assert_path_exists testpath/"fern/docs.yml"
    assert_match '"organization": "brewtest"', (testpath/"fern/fern.config.json").read

    system bin/"fern", "--version"
  end
end
