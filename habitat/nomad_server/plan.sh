pkg_origin=better-together-demo
pkg_name=nomad_server
pkg_version=0.9.3
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=("MPL-2.0")
pkg_description="Nomad is an easy-to-use, flexible, and performant workload orchestrator - server"
pkg_upstream_url=https://www.nomadproject.io/
pkg_source="https://releases.hashicorp.com/nomad/${pkg_version}/nomad_${pkg_version}_linux_amd64.zip"
pkg_shasum=cbd008dd2f3c622cb931ce8e7e6465f5b683e66845eb70adb776c970a8029578
pkg_filename="nomad-${pkg_version}_linux_amd64.zip"
pkg_deps=(core/glibc)
pkg_build_deps=(core/unzip core/patchelf)
pkg_bin_dirs=(bin)
pkg_exports=(
  [port-rpc]=ports.rpc
)
pkg_exposes=(port-rpc)

pkg_svc_user="root"
pkg_svc_group="${pkg_svc_user}"

do_unpack() {
  cd "${HAB_CACHE_SRC_PATH}" || exit
  unzip "${pkg_filename}" -d "${pkg_name}-${pkg_version}"
}

do_build() {
  return 0
}

do_install() {
  install -D nomad "${pkg_prefix}/bin/nomad"
  patchelf --interpreter "$(pkg_path_for glibc)/lib64/ld-linux-x86-64.so.2" "${pkg_prefix}/bin/nomad"
}
