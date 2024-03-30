# Maintainer: k01e <k01e.alm07@gmail.com>
pkgname=lightnux-git
pkgver=1.0
pkgrel=1
pkgdesc="a flexible keyboard and monitor backlight auto-dimmer for linux"
arch=('any')
url="https://github.com/k01e-01/lightnux"
license=('MIT')
depends=('brightnessctl' 'evtest')
source=("git+https://github.com/k01e-01/lightnux.git")
sha256sums=('SKIP')

pkgver() {
  cd "$srcdir/lightnux"
  git describe --tags | sed 's/-/+/g'
}

pacakge() {
  cd "$srcdir/lightnux"
  install -Dm755 lightnux.sh "$pkgdir/usr/bin/lightnux"
}
