package SmartphoneRebuild::Callbacks;
use strict;

sub build_file_filter {
    my ( $cb, %args ) = @_;
    my $mt = MT->instance();
    return 1 if ( (ref $mt) ne 'MT::App::CMS::Smartphone' );
    return 1 if MT->request( 'init_plugins_for_smartphone_rebuild' );
    MT->request( 'init_plugins_for_smartphone_rebuild', 1 );
    my $cfg          = $mt->config;
    my $use_plugins  = $cfg->UsePlugins;
    my @PluginPaths;
    unshift @PluginPaths, File::Spec->catdir( $MT_DIR, 'addons' );
    $mt->_init_plugins_core( {}, 1, \@PluginPaths );
    @PluginPaths  = $cfg->PluginPath;
    my $PluginSwitch = $cfg->PluginSwitch || {};
    $mt->_init_plugins_core( $PluginSwitch, $use_plugins,
        \@PluginPaths );
    return 1;
}

1;