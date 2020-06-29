(function() {
  var creativeDefinition = {
    customScriptUrl: '',
    isDynamic: false,
    delayedImpression: false,
    standardEventIds: {
      DISPLAY_TIMER: '72',
      INTERACTION_TIMER: '73',
      INTERACTIVE_IMPRESSION: '74',
      MANUAL_CLOSE: '75',
      BACKUP_IMAGE_IMPRESSION: '76',
      EXPAND_TIMER: '77',
      FULL_SCREEN: '78',
      VIDEO_PLAY: '79',
      VIDEO_VIEW_TIMER: '80',
      VIDEO_COMPLETE: '81',
      VIDEO_INTERACTION: '82',
      VIDEO_PAUSE: '83',
      VIDEO_MUTE: '84',
      VIDEO_REPLAY: '85',
      VIDEO_MIDPOINT: '86',
      VIDEO_STOP: '87',
      VIDEO_UNMUTE: '88',
      DYNAMIC_CREATIVE_IMPRESSION: '',
      HTML5_CREATIVE_IMPRESSION: ''
    },
    exitEvents: [
      {
        name: 'BackgroundExit',
        reportingId: '181319283',
        url: 'https://www.amazon.co.uk/stores/page/A043A405-A9A9-4F43-A007-FA3819426D68?ingress\x3d0\x26visitId\x3d07fe2fe0-ea25-4dca-8bfc-8868c4350a1a',
        targetWindow: '_blank',
        windowProperties: ''
      }
    ],
    timerEvents: [
    ],
    counterEvents: [
    ],
    childFiles: [
      {
        name: 'Pearson_ad_3DLeader_728x90.jpg',
        url: '/ads/richmedia/studio/pv2/61488878/20200622032946107/Pearson_ad_3DLeader_728x90.jpg',
        isVideo: false,
        transcodeInformation: null
      },
      {
        name: 'bookbackground.png',
        url: '/ads/richmedia/studio/pv2/61488878/20200622032946107/Users/charlotte.giraudot/Documents/Pearson ads redesign/728x90/Export_studio/images/bookbackground.png',
        isVideo: false,
        transcodeInformation: null
      },
      {
        name: 'Pearson_ad_FT_Guide_FTW_728x90.js',
        url: '/ads/richmedia/studio/pv2/61488878/20200622032946107/Users/charlotte.giraudot/Documents/Pearson ads redesign/728x90/Export_studio/Pearson_ad_FT_Guide_FTW_728x90.js',
        isVideo: false,
        transcodeInformation: null
      }
    ],
    videoFiles: [
    ],
    videoEntries: [
    ],
    primaryAssets: [
      {
        id: '80361080',
        artworkType: 'HTML5',
        displayType: 'BANNER',
        width: '728',
        height: '90',
        servingPath: '/ads/richmedia/studio/pv2/61488878/20200622032946107/Users/charlotte.giraudot/Documents/Pearson ads redesign/728x90/Export_studio/Pearson_ad_FT_Guide_FTW_728x90.html',
        zIndex: '1000000',
        customCss: '',
        flashArtworkTypeData: null,
        htmlArtworkTypeData: {
          isTransparent: false,
          sdkVersion: '01_242' // Duplicating sdk version in subsequent field as version format not the same.
        },
        floatingDisplayTypeData: null,
        expandingDisplayTypeData: null,
        imageGalleryTypeData: null,
        pageSettings:null,
layoutsConfig: null,
layoutsApi: null
      }
    ]
  }
  var rendererDisplayType = '';
  rendererDisplayType += 'html_';
  var rendererFormat = 'inpage';
  var rendererName = rendererDisplayType + rendererFormat;

  var creativeId = '138315039797';
  var adId = '0';
  var templateVersion = '200_260';
  var studioObjects = window['studioV2'] = window['studioV2'] || {};
  var creativeObjects = studioObjects['creatives'] = studioObjects['creatives'] || {};
  var creativeKey = [creativeId, adId].join('_');
  var creative = creativeObjects[creativeKey] = creativeObjects[creativeKey] || {};
  creative['creativeDefinition'] = creativeDefinition;
  var adResponses = creative['adResponses'] || [];
  for (var i = 0; i < adResponses.length; i++) {
    adResponses[i].creativeDto && adResponses[i].creativeDto.csiEvents &&
        (adResponses[i].creativeDto.csiEvents['pe'] =
            adResponses[i].creativeDto.csiEvents['pe'] || (+new Date));
  }
  var loadedLibraries = studioObjects['loadedLibraries'] = studioObjects['loadedLibraries'] || {};
  var versionedLibrary = loadedLibraries[templateVersion] = loadedLibraries[templateVersion] || {};
  var typedLibrary = versionedLibrary[rendererName] = versionedLibrary[rendererName] || {};
  if (typedLibrary['bootstrap']) {
    typedLibrary.bootstrap();
  }
})();
