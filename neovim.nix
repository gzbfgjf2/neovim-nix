# neovim.nix
{
  symlinkJoin,
  neovim-unwrapped,
  makeWrapper,
  runCommandLocal,
  vimPlugins,
  lib,
}: let
  appName = "nv";
  packageName = "nv-pack";
  
  treesitter = vimPlugins.nvim-treesitter.withPlugins (
    p: with p; [
      nix
      python
      rust
      regex
      bash
      # lua
      # c
    ]
  );
  

  startPlugins = (with vimPlugins; [
    #vimPlugins.telescope-nvim
    #vimPlugins.plenary-nvim # not needed, since it will be pulled automatically as a dependency
    # nvim-treesitter.withAllGrammars
    oil-nvim
    flash-nvim
    snacks-nvim
    onedark-nvim
    noice-nvim
    nui-nvim
    conform-nvim
    blink-cmp
    friendly-snippets
    indent-blankline-nvim
    nvim-autopairs
    nvim-surround
  ])++[treesitter];

  foldPlugins = builtins.foldl' (
    acc: next:
      acc
      ++ [
        next
      ]
      ++ (foldPlugins (next.dependencies or []))
  ) [];

  startPluginsWithDeps = lib.unique (foldPlugins startPlugins);

  packpath = runCommandLocal "packpath" {} ''
    mkdir -p $out/pack/${packageName}/{start,opt}
    ln -vsfT ${./nv-config} $out/pack/${packageName}/start/nv-config
    ln -vsfT ${./nv-lsp-config} $out/pack/${packageName}/start/nv-lsp-config

    ${
      lib.concatMapStringsSep
      "\n"
      (plugin: "ln -vsfT ${plugin} $out/pack/${packageName}/start/${lib.getName plugin}")
      startPluginsWithDeps
      # startPlugins
    }
  '';
in
  symlinkJoin {
    name = appName;
    paths = [neovim-unwrapped];
    nativeBuildInputs = [makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/nvim \
        --add-flags '-u' \
        --add-flags 'NORC' \
        --add-flags '--cmd' \
        --add-flags "'set packpath^=${packpath} '" \
        --set-default NVIM_APPNAME ${appName}
      mv $out/bin/nvim $out/bin/nv

    '';

    passthru = {
      inherit packpath;
    };
  }


# --add-flags "'set packpath^=${packpath} | set runtimepath^=${packpath}'" \
