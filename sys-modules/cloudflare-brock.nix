{
  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = "/var/lib/secrets/cloudflare-token";
    domains = [ "brockdewbs.uk" ];
  };
}
