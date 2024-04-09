class LinuxPam < Formula
  desc "Pluggable Authentication Modules for Linux"
  homepage "http://www.linux-pam.org"
  url "https://github.com/linux-pam/linux-pam/releases/download/v1.6.1/Linux-PAM-1.6.1.tar.xz"
  sha256 "f8923c740159052d719dbfc2a2f81942d68dd34fcaf61c706a02c9b80feeef8e"
  license any_of: ["BSD-3-Clause", "GPL-1.0-only"]
  head "https://github.com/linux-pam/linux-pam.git", branch: "master"

  bottle do
    sha256 x86_64_linux: "d6ee4d3bf342df33c406adfa855c1db6725520e482b9850ced836ff9d4962cf5"
  end

  depends_on "pkg-config" => :build
  depends_on "libnsl"
  depends_on "libprelude"
  depends_on "libtirpc"
  depends_on "libxcrypt"
  depends_on :linux

  skip_clean :la

  def install
    args = %W[
      --disable-db
      --disable-silent-rules
      --disable-selinux
      --includedir=#{include}/security
      --oldincludedir=#{include}
      --enable-securedir=#{lib}/security
      --sysconfdir=#{etc}
      --with-xml-catalog=#{etc}/xml/catalog
      --with-libprelude-prefix=#{Formula["libprelude"].opt_prefix}
    ]

    system "./configure", *std_configure_args, *args
    system "make"
    system "make", "install"
  end

  test do
    assert_match "Usage: #{sbin}/mkhomedir_helper <username>",
                 shell_output("#{sbin}/mkhomedir_helper 2>&1", 14)
  end
end
