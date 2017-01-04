use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: :dev

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"H/p:)$6&Bx:<raY>,V5|?qP}RIiM&qKYu&&pC78;a&Wxtg=Uf.2cLB5[PW4sQ<Y2"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"~*,6j3Sw9~i_U<:R)N_Vo*`thN<SxXUtuw95S>~m}|R?1APKm9Uo]>!E@:bu75?W"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :example_phx do
  set version: current_version(:example_phx)
end

