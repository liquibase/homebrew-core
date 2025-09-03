class CubejsCli < Formula
  desc "Cube.js command-line interface"
  homepage "https://cube.dev/"
  url "https://registry.npmjs.org/cubejs-cli/-/cubejs-cli-1.3.63.tgz"
  sha256 "dcfc0c21f17c08804924582ced14b9841a9e7b3f4ecaf6f291c0ae8b8fb31fc5"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "9da6f5d8f53244c492f84aa54e3f009146ea1b9ec4aefd50cb7b4b13f42014b1"
    sha256 cellar: :any,                 arm64_sonoma:  "9da6f5d8f53244c492f84aa54e3f009146ea1b9ec4aefd50cb7b4b13f42014b1"
    sha256 cellar: :any,                 arm64_ventura: "9da6f5d8f53244c492f84aa54e3f009146ea1b9ec4aefd50cb7b4b13f42014b1"
    sha256 cellar: :any,                 sonoma:        "d9d9d32df173a21abfbb39d00166586b215ebcc773dabc95d7f4cc632e108850"
    sha256 cellar: :any,                 ventura:       "d9d9d32df173a21abfbb39d00166586b215ebcc773dabc95d7f4cc632e108850"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "57e1a2bbb6b3537e82f8925d9b76ed8f85400eeded203b7ade0869fd2e54f758"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "571ac6d71c918548e5e1ceda3feae7075ede8ff9f01ae0a039afa594a1c71572"
  end

  depends_on "node"
  uses_from_macos "zlib"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cubejs --version")
    system bin/"cubejs", "create", "hello-world", "-d", "postgres"
    assert_path_exists testpath/"hello-world/model/cubes/orders.yml"
  end
end
