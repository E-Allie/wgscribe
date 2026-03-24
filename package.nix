{
  bash,
  coreutils,
  curl,
  gawk,
  gnugrep,
  gnused,
  iproute2,
  jq,
  lib,
  resholve,
  wireguard-tools,
}:

resholve.mkDerivation rec {
  pname = "wgscribe";
  version = "0.2.1";

  src = ./.;

  postPatch = ''
    substituteInPlace wgscribe \
      --replace-fail '$conf_dir/template.conf' "$out/share/template.conf"
  '';

  dontBuild = true;

  installPhase = ''
    install -Dm 755 wgscribe -t $out/bin/
    install -Dm 644 countries.txt -t $out/share/
    install -Dm 644 template.conf -t $out/share/
  '';

  solutions.default = {
    scripts = [ "bin/wgscribe" ];
    interpreter = "${bash}/bin/sh";
    inputs = [
      coreutils
      curl
      gawk
      gnugrep
      gnused
      iproute2
      jq
      wireguard-tools
    ];
    fix.aliases = true;
    execer = [
      "cannot:${iproute2}/bin/ip"
      "cannot:${wireguard-tools}/bin/wg-quick"
      "cannot:${wireguard-tools}/bin/wg"
    ];
  };

  meta = {
    description = "Windscribe WireGuard client in POSIX shell";
    homepage = "https://github.com/E-Allie/wgscribe";
    license = lib.licenses.agpl3Only;
    mainProgram = "wgscribe";
    platforms = lib.platforms.linux;
  };
}
