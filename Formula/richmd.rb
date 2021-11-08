class Richmd < Formula
  include Language::Python::Virtualenv

  desc "Format Markdown in the terminal with Rich"
  homepage "https://github.com/willmcgugan/rich"
  url "https://files.pythonhosted.org/packages/dc/b4/ad6cac44c9978787cc73d8dd36373665ad3b8613be9120a893e87b99e134/rich-10.13.0.tar.gz"
  sha256 "d80fc76f34d819c481a48f73ec9ac396bed3bd6a16ecd57f9e0654cd89a8fb56"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "53eaf4e2dee58612460c435ca1d76e78917ea067161298fe5b9e3165f3033b73"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2007a1699b391f8aad831f22994d93ca0b71911f844ad6ffc9c008a6846a088a"
    sha256 cellar: :any_skip_relocation, monterey:       "c22f45d92427f71c5f3668e2bd09217c0fce88317fb5ae532a34c9f2d73dd5f2"
    sha256 cellar: :any_skip_relocation, big_sur:        "4b180be6656c9e37de0c524ebd53d481c71306dc0b8ccb9500b3682ed52850f6"
    sha256 cellar: :any_skip_relocation, catalina:       "8bfd7eaf8c4749971915e9e6bdd5ce507535a2e9b009c0679d0624eecb1b28d6"
    sha256 cellar: :any_skip_relocation, mojave:         "d785977634c44d46b4fb2d35569464969eed3e0844e9bbdb2ba9e6b55a70cb55"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "598366c5b63761126bdc0b58b9be03fd9479f860a3d93eda65222f98c738d736"
  end

  depends_on "python@3.10"

  resource "colorama" do
    url "https://files.pythonhosted.org/packages/1f/bb/5d3246097ab77fa083a61bd8d3d527b7ae063c7d8e8671b1cf8c4ec10cbe/colorama-0.4.4.tar.gz"
    sha256 "5941b2b48a20143d2267e95b1c2a7603ce057ee39fd88e7329b0c292aa16869b"
  end

  resource "commonmark" do
    url "https://files.pythonhosted.org/packages/60/48/a60f593447e8f0894ebb7f6e6c1f25dafc5e89c5879fdc9360ae93ff83f0/commonmark-0.9.1.tar.gz"
    sha256 "452f9dc859be7f06631ddcb328b6919c67984aca654e5fefb3914d54691aed60"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/b7/b3/5cba26637fe43500d4568d0ee7b7362de1fb29c0e158d50b4b69e9a40422/Pygments-2.10.0.tar.gz"
    sha256 "f398865f7eb6874156579fdf36bc840a03cab64d1cde9e93d68f46a425ec52c6"
  end

  def install
    virtualenv_install_with_resources

    (bin/"richmd").write <<~SH
      #!/bin/bash
      #{libexec/"bin/python"} -m rich.markdown $@
    SH
  end

  test do
    (testpath/"foo.md").write("- Hello, World")
    assert_equal "• Hello, World", shell_output("#{bin}/richmd foo.md").strip
  end
end
