# Example repo for using Kubernetes with Elixir+Phoenix
Basically this is just something I hacked together one night to learn about Kubernetes and see how well Elixir worked with it. Thanks to bitwalker's [libcluster](https://github.com/bitwalker/libcluster), it works quite well.


## How to make this work for you
If you want to use this project, you'll need to make some changes, and perform some steps in your kubernetes environment. If you haven't used kubernetes before I highly recommend giving it a spin via Google Container Engine, it's a great experience. If you use GCE, their Cloud Shell product makes it really painless to do all of this without messing around with your local machine, but you'll need to install Elixir there (use Erlang Solution's debian repo).

1. Change prod libcluster config to use your app name (if changed)
2. Use distillery to build a release `MIX_ENV=prod mix release --env=prod`
3. Build the docker image, tag it, and upload it somewhere that kubernetes can see (I used Google Container Engine for everything)
4. Update the kubernetes "all-in-one" file for your new image (examplephx-aio.yaml), and check other settings.
5. Create a secret and config map (I've included the proper vm.args for libcluster) see the bottom (Addendum) of [this great post](https://substance.brpx.com/clustering-elixir-nodes-on-kubernetes-e85d0c26b0cf) for details
6. Use kubernetes to create your cluster (ReplicationController+Service) `kubectl create -f examplephx-aio.yaml`

I probably forgot something, don't be afraid to reach out @bbhoss :)
