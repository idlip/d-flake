{ pkgs, self, inputs, nur, config, ... }: {
  home.file.".mozilla/native-messaging-hosts/ff2mpv.json".source = "${pkgs.ff2mpv}/lib/mozilla/native-messaging-hosts/ff2mpv.json";


  programs.firefox = {
    enable = true;
    #package = pkgs.firefox-unwrapped;


    # https://ffprofile.com/
    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
         #bypass-paywalls-clean
         cookies-txt
              ff2mpv
              vimium
              languagetool
              ublock-origin
              darkreader
              libredirect
              multi-account-containers
            ];

        settings = {
          "app.update.auto" = false;
          "browser.startup.homepage" = "about:blank";
          "browser.urlbar.placeholderName" = "DuckDuckGo";
          "privacy.webrtc.legacyGlobalIndicator" = true;
          "gfx.webrender.all" = true;
          "gfx.webrender.enabled" = true;
          "media.av1.enabled" = false;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.hardware-video-decoding.force-enabled" = true;
          "media.navigator.mediadatadecoder_vpx_enabled" = true;
          "signon.rememberSignons" = false;
          "app.normandy.api_url" = "";
          "app.normandy.enabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "beacon.enabled" = false;
          "breakpad.reportURL" = "";
          "browser.aboutConfig.showWarning" = false;
          "browser.cache.offline.enable" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "browser.crashReports.unsubmittedCheck.enabled" = false;
          "browser.disableResetPrompt" = true;
          "browser.newtab.preload" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = true;
          "browser.newtabpage.enhanced" = false;
          "browser.newtabpage.introShown" = true;
          "browser.safebrowsing.appRepURL" = "";
          "browser.safebrowsing.blockedURIs.enabled" = false;
          "browser.safebrowsing.downloads.enabled" = false;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.downloads.remote.url" = "";
          "browser.safebrowsing.enabled" = false;
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;
          "browser.selfsupport.url" = "";
          "browser.send_pings" = false;
          "browser.sessionstore.privacy_level" = 2;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.urlbar.groupLabels.enabled" = false;
          "browser.urlbar.quicksuggest.enabled" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "device.sensors.ambientLight.enabled" = false;
          "device.sensors.enabled" = false;
          "device.sensors.motion.enabled" = false;
          "device.sensors.orientation.enabled" = false;
          "device.sensors.proximity.enabled" = false;
          "dom.battery.enabled" = false;
          "dom.event.clipboardevents.enabled" = true;
          "dom.webaudio.enabled" = false;
          "experiments.activeExperiment" = false;
          "experiments.enabled" = false;
          "experiments.manifest.uri" = "";
          "experiments.supported" = false;
          "extensions.getAddons.cache.enabled" = false;
          "extensions.getAddons.showPane" = false;
          "extensions.greasemonkey.stats.optedin" = false;
          "extensions.greasemonkey.stats.url" = "";
          "extensions.shield-recipe-client.api_url" = "";
          "extensions.shield-recipe-client.enabled" = false;
          "extensions.webservice.discoverURL" = "";
          "fission.autostart" = true;
          "media.autoplay.default" = 1;
          "media.autoplay.enabled" = false;
          "media.eme.enabled" = false;
          "media.gmp-widevinecdm.enabled" = false;
          "media.navigator.enabled" = false;
          "media.video_stats.enabled" = false;
          "network.IDN_show_punycode" = true;
          "network.allow-experiments" = false;
          "network.captive-portal-service.enabled" = false;
          "network.cookie.cookieBehavior" = 1;
          "network.dns.disablePrefetch" = true;
          "network.dns.disablePrefetchFromHTTPS" = true;
          "network.http.referer.spoofSource" = true;
          "network.http.speculative-parallel-limit" = 0;
          "network.predictor.enable-prefetch" = false;
          "network.predictor.enabled" = false;
          "network.prefetch-next" = false;
          "network.trr.mode" = 5;
          "privacy.donottrackheader.enabled" = true;
          "privacy.donottrackheader.value" = 1;
          "privacy.firstparty.isolate" = true;
          "privacy.trackingprotection.cryptomining.enabled" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.fingerprinting.enabled" = true;
          "privacy.trackingprotection.pbmode.enabled" = true;
          "privacy.usercontext.about_newtab_segregation.enabled" = true;
          "security.ssl.disable_session_identifiers" = true;
          "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false;
          "signon.autofillForms" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.cachedClientID" = "";
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.prompted" = 2;
          "toolkit.telemetry.rejected" = true;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.unifiedIsOptIn" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "webgl.disabled" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "webgl.renderer-string-override" = " ";
          "webgl.vendor-string-override" = " ";
        };

        userChrome = ''
# Check out https://github.com/andreasgrafen/cascade For this THEME
 /*---+---+---+---+---+---+---+
 | C | O | L | O | U | R | S |
 +---+---+---+---+---+---+---*/


@media (prefers-color-scheme: dark) { :root {
  
  /* These colours are (mainly) used by the
     Container Tabs Plugin */
  --uc-identity-colour-blue:      #7ED6DF;
  --uc-identity-colour-turquoise: #55E6C1;
  --uc-identity-colour-green:     #B8E994;
  --uc-identity-colour-yellow:    #F7D794;
  --uc-identity-colour-orange:    #F19066;
  --uc-identity-colour-red:       #FC5C65;
  --uc-identity-colour-pink:      #F78FB3;
  --uc-identity-colour-purple:    #786FA6;
  
  /*  Cascades main Colour Scheme */
  --uc-base-colour:               #1E2021;
  --uc-highlight-colour:          #191B1C;
  --uc-inverted-colour:           #FAFAFC;
  --uc-muted-colour:              #AAAAAC;
  --uc-accent-colour:             var(--uc-identity-colour-purple);
  
}}


@media (prefers-color-scheme: light) { :root {
  
  /* These colours are (mainly) used by the
     Container Tabs Plugin */
  --uc-identity-colour-blue:      #1D65F5;
  --uc-identity-colour-turquoise: #209FB5;
  --uc-identity-colour-green:     #40A02B;
  --uc-identity-colour-yellow:    #E49320;
  --uc-identity-colour-orange:    #FE640B;
  --uc-identity-colour-red:       #FC5C65;
  --uc-identity-colour-pink:      #EC83D0;
  --uc-identity-colour-purple:    #822FEE;
  
  /*  Cascades main Colour Scheme */
  --uc-base-colour:               #FAFAFC;
  --uc-highlight-colour:          #DADADC;
  --uc-inverted-colour:           #1E2021;
  --uc-muted-colour:              #191B1C;
  --uc-accent-colour:             var(--uc-identity-colour-purple);
  
}}






/* Down here I'm just reassigning variables based on the colours set above.
   Feel free to play around with these but there is no editing necessary below this line. c:
   */

:root {

  --lwt-frame: var(--uc-base-colour) !important;
  --lwt-accent-color: var(--lwt-frame) !important;
  --lwt-text-color: var(--uc-inverted-colour) !important;

  --toolbar-field-color: var(--uc-inverted-colour) !important;

  --toolbar-field-focus-color: var(--uc-inverted-colour) !important;
  --toolbar-field-focus-background-color: var(--uc-highlight-colour) !important;
  --toolbar-field-focus-border-color: transparent !important;

  --toolbar-field-background-color: var(--lwt-frame) !important;
  --lwt-toolbar-field-highlight: var(--uc-inverted-colour) !important;
  --lwt-toolbar-field-highlight-text: var(--uc-highlight-colour) !important;
  --urlbar-popup-url-color: var(--uc-accent-colour) !important;

  --lwt-tab-text: var(--lwt-text-colour) !important;

  --lwt-selected-tab-background-color: var(--uc-highlight-colour) !important;

  --toolbar-bgcolor: var(--lwt-frame) !important;
  --toolbar-color: var(--lwt-text-color) !important;
  --toolbarseparator-color: var(--uc-accent-colour) !important;
  --toolbarbutton-hover-background: var(--uc-highlight-colour) !important;
  --toolbarbutton-active-background: var(--toolbarbutton-hover-background) !important;

  --lwt-sidebar-background-color: var(--lwt-frame) !important;
  --sidebar-background-color: var(--lwt-sidebar-background-color) !important;

  --urlbar-box-bgcolor: var(--uc-highlight-colour) !important;
  --urlbar-box-text-color: var(--uc-muted-colour) !important;
  --urlbar-box-hover-bgcolor: var(--uc-highlight-colour) !important;
  --urlbar-box-hover-text-color: var(--uc-inverted-colour) !important;
  --urlbar-box-focus-bgcolor: var(--uc-highlight-colour) !important;

}



.identity-color-blue      { --identity-tab-color: var(--uc-identity-colour-blue)      !important; --identity-icon-color: var(--uc-identity-colour-blue)      !important;  }
.identity-color-turquoise { --identity-tab-color: var(--uc-identity-colour-turquoise) !important; --identity-icon-color: var(--uc-identity-colour-turquoise) !important; }
.identity-color-green     { --identity-tab-color: var(--uc-identity-colour-green)     !important; --identity-icon-color: var(--uc-identity-colour-green)     !important; }
.identity-color-yellow    { --identity-tab-color: var(--uc-identity-colour-yellow)    !important; --identity-icon-color: var(--uc-identity-colour-yellow)    !important; }
.identity-color-orange    { --identity-tab-color: var(--uc-identity-colour-orange)    !important; --identity-icon-color: var(--uc-identity-colour-orange)    !important; }
.identity-color-red       { --identity-tab-color: var(--uc-identity-colour-red)       !important; --identity-icon-color: var(--uc-identity-colour-red)       !important; }
.identity-color-pink      { --identity-tab-color: var(--uc-identity-colour-pink)      !important; --identity-icon-color: var(--uc-identity-colour-pink)      !important; }
.identity-color-purple    { --identity-tab-color: var(--uc-identity-colour-purple)    !important; --identity-icon-color: var(--uc-identity-colour-purple)    !important; }

/*---+---+---+---+---+---+
 | G | L | O | B | A | L |
 +---+---+---+---+---+---*/


 :root {

  /*  Global Border Radius
   *  applied to ALL UI elements
   */ --uc-border-radius: 0px;


  /*  The distance the Statuspanel floats
   *  away from the window border
   *  0 places directly in the corner
   */ --uc-status-panel-spacing: 12px;

}


/* remove window control buttons */
.titlebar-buttonbox-container { display: none !important; }


#pageActionButton { display: none !important; }





/*---+---+---+---+---+---+---+
 | T | O | O | L | B | A | R |
 +---+---+---+---+---+---+---*/


:root {

  /*  Position of the Personal Toolbar
   *  possible values:
   *  0 – toolbar on top
   *  4 – toolbar on bottom
   */ --uc-toolbar-position: 0;

  /*  Darken the Personal Toolbar by X amount
   *  where X = 1 means pure black
   *  and X = 0 means no darkening at all
   */ --uc-darken-toolbar: .2;

}





/*---+---+---+---+---+---+---+
 | U | R | L | — | B | A | R |
 +---+---+---+---+---+---+---*/


:root {

  /*  Width of the URL Bar for the Oneline layout
   *  If enabled the max-width is applied on focus
   *  otherwise the URL Bar will always be it's min-width
   */ --uc-urlbar-min-width: 40vw;
      --uc-urlbar-max-width: 40vw;

  /*  Position of the URL Bar
   *  possible values:
   *  1 – tabs on the right
   *  3 – tabs on the left
   */ --uc-urlbar-position: 1;

}


/* Disable the Navigation Buttons */

/* Disables the Tracking Protection Shield */
/* #tracking-protection-icon-container { display: none !important; } */

/* Encryption and Permissions icons */
  /* Only hides permission items */
  #identity-permission-box { display: none !important; }
  /* Hides encryption AND permission items */
  /* #identity-box { display: none !important } */

/* Hide everything BUT the zoom indicator within the URL Bar */
#page-action-buttons > :not(#urlbar-zoom-button):not(#star-button-box) { display: none !important; }


/* Hide the »Go«-arrow in the URL Bar */
#urlbar-go-button { display: none !important; }





/*---+---+---+---+---+---+---+
 | T | A | B | — | B | A | R |
 +---+---+---+---+---+---+---*/


:root {

  /*  Allow tabs to have dynamic widths based on
   *  the Tab Bars maximum width
   */ --uc-active-tab-width:   clamp(100px, 30vw, 300px);
      --uc-inactive-tab-width: clamp(100px, 20vw, 200px);


  /*  Enable this to always show the Tab Close button
   *  possible values:
   *  show: -moz-inline-block
   *  hide: none
   */ --show-tab-close-button: none;

  /*  Enable this to only show the Tab Close button on tab hover
   *  possible values:
   *  show: -moz-inline-block
   *  hide: none
   */ --show-tab-close-button-hover: -moz-inline-block;


  /*  Left and Right "dip" of the container indicator
   *  0px equals tab width
   *  higer values make the indicator smaller
   */ --container-tabs-indicator-margin: 10px;

  /*  Amount of Glow to add to the container indicator
   *  Setting it to 0 disables the Glow
   */ --uc-identity-glow: 0 1px 10px 1px;

}


/* Hide the secondary Tab Label
 * e.g. playing indicator (the text, not the icon) */
.tab-secondary-label { display: none !important; }

#statuspanel #statuspanel-label { margin: 0 0 var(--uc-status-panel-spacing) var(--uc-status-panel-spacing) !important; }

:root {

  --toolbarbutton-border-radius: var(--uc-border-radius) !important;
  --tab-border-radius: var(--uc-border-radius) !important;
  --arrowpanel-border-radius: var(--uc-border-radius) !important;

}





#main-window,
#toolbar-menubar,
#TabsToolbar,
#navigator-toolbox,
#sidebar-box,
#nav-bar { box-shadow: none !important; }


#main-window,
#toolbar-menubar,
#TabsToolbar,
#PersonalToolbar,
#navigator-toolbox,
#sidebar-box,
#nav-bar { border: none !important; }


/* remove "padding" left and right from tabs */
.titlebar-spacer { display: none !important; }





#PersonalToolbar {

  padding: 6px !important;
  box-shadow: inset 0 0 50vh rgba(0, 0, 0, var(--uc-darken-toolbar)) !important;;

}





#statuspanel #statuspanel-label {

  border: none !important;
  border-radius: var(--uc-border-radius) !important;
}

#nav-bar {

  padding-block-start: 0px !important;

  border:     none !important;
  box-shadow: none !important;
  background: transparent !important;

}


#urlbar,
#urlbar * {

  padding-block-start: var(--uc-urlbar-top-spacing) !important;

  outline: none !important;
  box-shadow: none !important;

}


#urlbar-background { border: transparent !important; }


#urlbar[focused='true']
  > #urlbar-background,
#urlbar:not([open])
  > #urlbar-background { background: var(--toolbar-field-background-color) !important; }


#urlbar[open]
  > #urlbar-background { background: var(--toolbar-field-background-color) !important; }


.urlbarView-row:hover
  > .urlbarView-row-inner,
.urlbarView-row[selected]
  > .urlbarView-row-inner { background: var(--toolbar-field-focus-background-color) !important; }

@media (min-width: 1000px) {

  #nav-bar { margin: calc((var(--urlbar-min-height) * -1) - 12px) calc(100vw - var(--uc-urlbar-min-width)) 0 0 !important; }
  #titlebar { margin-inline-start: var(--uc-urlbar-min-width) !important; }

  #navigator-toolbox:focus-within #nav-bar { margin: calc((var(--urlbar-min-height) * -1) - 12px) calc(100vw - var(--uc-urlbar-max-width)) 0 0 !important; }
  #navigator-toolbox:focus-within #titlebar { margin-inline-start: var(--uc-urlbar-max-width) !important; }

}

@media (min-width: 1000px) {


  #navigator-toolbox { display: flex; flex-wrap: wrap; }


  #nav-bar {

    order: var(--uc-urlbar-position);
    width: var(--uc-urlbar-min-width);

  }


  #titlebar {

    order: 2;
    width: calc(100vw - var(--uc-urlbar-min-width) - 1px);

  }


  #PersonalToolbar {

    order: var(--uc-toolbar-position);
    width: 100%;

  }


  #navigator-toolbox:focus-within #nav-bar { width: var(--uc-urlbar-max-width); }
  #navigator-toolbox:focus-within #titlebar { width: calc(100vw - var(--uc-urlbar-max-width) - 1px); }

}

/* remove gap after pinned tabs */
#tabbrowser-tabs[haspinnedtabs]:not([positionpinnedtabs])
  > #tabbrowser-arrowscrollbox
  > .tabbrowser-tab[first-visible-unpinned-tab] { margin-inline-start: 0 !important; }


/* Hides the list-all-tabs button*/
#alltabs-button { display: var(--uc-show-all-tabs-button) !important; }


/* remove tab shadow */
.tabbrowser-tab
  >.tab-stack
  > .tab-background { box-shadow: none !important;  }


/* multi tab selection */
#tabbrowser-tabs:not([noshadowfortests]) .tabbrowser-tab:is([multiselected])
  > .tab-stack
  > .tab-background:-moz-lwtheme { outline-color: var(--toolbarseparator-color) !important; }





/* tab close button options */
.tabbrowser-tab:not([pinned]) .tab-close-button { display: var(--show-tab-close-button) !important; }
.tabbrowser-tab:not([pinned]):hover .tab-close-button { display: var(--show-tab-close-button-hover) !important }





/* adaptive tab width */
.tabbrowser-tab[selected][fadein]:not([pinned]) { max-width: var(--uc-active-tab-width) !important; }
.tabbrowser-tab[fadein]:not([selected]):not([pinned]) { max-width: var(--uc-inactive-tab-width) !important; }





/* container tabs indicator */
.tabbrowser-tab[usercontextid]
  > .tab-stack
  > .tab-background
  > .tab-context-line {

    margin: -1px var(--container-tabs-indicator-margin) 0 var(--container-tabs-indicator-margin) !important;
    height: 1px !important;

    box-shadow: var(--uc-identity-glow) var(--identity-tab-color) !important;

}





/* show favicon when media is playing but tab is hovered */
.tab-icon-image:not([pinned]) { opacity: 1 !important; }


/* Makes the speaker icon to always appear if the tab is playing (not only on hover) */
.tab-icon-overlay:not([crashed]),
.tab-icon-overlay[pinned][crashed][selected] {

  top: 5px !important;
  z-index: 1 !important;

  padding: 1.5px !important;
  inset-inline-end: -8px !important;
  width: 16px !important; height: 16px !important;

  border-radius: 10px !important;

}


/* style and position speaker icon */
.tab-icon-overlay:not([sharing], [crashed]):is([soundplaying], [muted], [activemedia-blocked]) {

  stroke: transparent !important;
  background: transparent !important;
  opacity: 1 !important; fill-opacity: 0.8 !important;

  color: currentColor !important;

  stroke: var(--toolbar-bgcolor) !important;
  background-color: var(--toolbar-bgcolor) !important;

}


/* change the colours of the speaker icon on active tab to match tab colours */
.tabbrowser-tab[selected] .tab-icon-overlay:not([sharing], [crashed]):is([soundplaying], [muted], [activemedia-blocked]) {

  stroke: var(--toolbar-bgcolor) !important;
  background-color: var(--toolbar-bgcolor) !important;

}


.tab-icon-overlay:not([pinned], [sharing], [crashed]):is([soundplaying], [muted], [activemedia-blocked]) { margin-inline-end: 9.5px !important; }


.tabbrowser-tab:not([image]) .tab-icon-overlay:not([pinned], [sharing], [crashed]) {

  top: 0 !important;

  padding: 0 !important;
  margin-inline-end: 5.5px !important;
  inset-inline-end: 0 !important;

}


.tab-icon-overlay:not([crashed])[soundplaying]:hover,
.tab-icon-overlay:not([crashed])[muted]:hover,
.tab-icon-overlay:not([crashed])[activemedia-blocked]:hover {

  color: currentColor !important;
  stroke: var(--toolbar-color) !important;
  background-color: var(--toolbar-color) !important;
  fill-opacity: 0.95 !important;

}


.tabbrowser-tab[selected] .tab-icon-overlay:not([crashed])[soundplaying]:hover,
.tabbrowser-tab[selected] .tab-icon-overlay:not([crashed])[muted]:hover,
.tabbrowser-tab[selected] .tab-icon-overlay:not([crashed])[activemedia-blocked]:hover {

  color: currentColor !important;
  stroke: var(--toolbar-color) !important;
  background-color: var(--toolbar-color) !important;
  fill-opacity: 0.95 !important;

}


/* speaker icon colour fix */
#TabsToolbar .tab-icon-overlay:not([crashed])[soundplaying],
#TabsToolbar .tab-icon-overlay:not([crashed])[muted],
#TabsToolbar .tab-icon-overlay:not([crashed])[activemedia-blocked] { color: var(--toolbar-color) !important; }


/* speaker icon colour fix on hover */
#TabsToolbar .tab-icon-overlay:not([crashed])[soundplaying]:hover,
#TabsToolbar .tab-icon-overlay:not([crashed])[muted]:hover,
#TabsToolbar .tab-icon-overlay:not([crashed])[activemedia-blocked]:hover { color: var(--toolbar-bgcolor) !important; }

        '';
 
    };
  };

}













