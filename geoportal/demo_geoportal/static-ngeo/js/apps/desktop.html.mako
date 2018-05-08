<!DOCTYPE html>
<html lang="{{mainCtrl.lang}}" ng-app="AppDesktop" ng-controller="DesktopController as mainCtrl">
  <head>
    % if request is not None and "no_redirect" not in request.params:
            <script>
                var small_screen = window.matchMedia ? window.matchMedia('(max-width: 1024px)') : false;
                if (small_screen && (('ontouchstart' in window) || window.DocumentTouch && document instanceof DocumentTouch)) {
    % if "themes" in request.matchdict:
                    window.location = "${request.route_url('mobiletheme', themes=request.matchdict['themes'], _query=dict(request.GET)) | n}";
    % else:
                    window.location = "${request.route_url('mobile', _query=dict(request.GET)) | n}";
    % endif
                }
            </script>
    % endif

    <title ng-bind-template="{{'Desktop Application'|translate}}">GeoMapFish</title>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <link rel="shortcut icon" href="/${instance}/wsgi/static-ngeo/BUSTING_VERSION/images/favicon.ico')}"/>
  </head>
  <body ng-class="{'gmf-profile-chart-active': !!profileChartActive}">
    <header>
      <div class="logo">
        <img src="/${instance}/wsgi/static-ngeo/BUSTING_VERSION/images/logo.png')}" />
        <span>by Camptocamp</span>
      </div>
    </header>
    <main>
      <div class="gmf-app-data-panel" ng-cloak>
        <div class="gmf-app-header">
          <div class="dropdown">
            <a href class="btn btn-default btn-block btn-primary"
              data-toggle="dropdown">
              <span class="fa fa-grid"></span>
              <span ng-if="mainCtrl.gmfThemeManager.modeFlush">
                <span translate>Theme:</span>
                <b ng-if="mainCtrl.gmfThemeManager.isLoading()" translate>Loading...</b>
                <b ng-if="!mainCtrl.gmfThemeManager.isLoading()">{{mainCtrl.gmfThemeManager.getThemeName()|translate}}</b>
              </span>
              <span ng-if="!mainCtrl.gmfThemeManager.modeFlush">
                <b ng-if="!mainCtrl.gmfThemeManager.themeName" translate>Themes</b>
              </span>
              <span class="caret"></span>
            </a>
            <gmf-themeselector class="dropdown-menu"
              gmf-themeselector-currenttheme="mainCtrl.theme"
              gmf-themeselector-filter="::mainCtrl.filter">
            </gmf-themeselector>
          </div>
        </div>
        <div class="gmf-app-content">
          <gmf-layertree
            gmf-layertree-dimensions="mainCtrl.dimensions"
            gmf-layertree-map="::mainCtrl.map">
          </gmf-layertree>
        </div>
      </div>
      <div class="gmf-app-tools" ngeo-resizemap="mainCtrl.map" ngeo-resizemap-state="mainCtrl.toolsActive">
        <div class="gmf-app-bar">
          <div ngeo-btn-group class="btn-group-vertical" ngeo-btn-group-active="mainCtrl.toolsActive">
            <button ngeo-btn class="btn btn-default" ng-model="mainCtrl.loginActive"
              data-toggle="tooltip" data-placement="left" data-original-title="{{'Login'|translate}}">
              <span class="fa fa-user" ng-class="mainCtrl.gmfUser.username ? 'fa-user-times' : 'fa-user'"></span>
            </button>
            <button ngeo-btn class="btn btn-default" ng-model="mainCtrl.printPanelActive"
              data-toggle="tooltip" data-placement="left" data-original-title="{{'Print'|translate}}">
              <span class="fa fa-print"></span>
            </button>
            <button ngeo-btn class="btn btn-default" ng-model="mainCtrl.drawFeatureActive"
              data-toggle="tooltip" data-placement="left" data-original-title="{{'Draw & Measure'|translate}}">
              <span class="fa fa-paint-brush"></span>
            </button>
            <button ngeo-btn class="btn btn-default" ng-model="mainCtrl.filterSelectorActive"
              data-toggle="tooltip" data-placement="left" data-original-title="{{'Filter'|translate}}">
              <span class="fa fa-filter"></span>
            </button>
            <button ngeo-btn class="btn btn-default" ng-model="mainCtrl.editFeatureActive"
              data-toggle="tooltip" data-placement="left" data-original-title="{{'Editing'|translate}}"
              ng-show="mainCtrl.hasEditableLayers" ng-cloak>
              <span class="fa fa-pencil"></span>
            </button>
            <button ngeo-btn class="btn btn-default" ng-model="mainCtrl.drawProfilePanelActive"
              data-toggle="tooltip" data-placement="left" data-original-title="{{'Profile'|translate}}">
              <span class="fa fa-area-chart"></span>
            </button>
            <button ngeo-btn class="btn btn-default" ng-model="mainCtrl.googleStreetViewActive"
              data-toggle="tooltip" data-placement="left" data-original-title="{{'Street View'|translate}}">
              <span class="fa fa-street-view"></span>
            </button>
            <button ngeo-btn class="btn btn-default" ng-model="mainCtrl.importDataSourceActive"
                    data-toggle="tooltip" data-placement="left" data-original-title="{{'Import Layer'|translate}}">
              <span class="fa fa-upload"></span>
            </button>
          </div>
          <br/>
          <br/>
          <span data-toggle="tooltip" data-placement="left" data-original-title="{{'Share this map'|translate}}">
            <button ngeo-btn class="btn btn-default" ng-model="mainCtrl.modalShareShown">
              <span class="fa fa-share-alt"></span>
            </button>
          </span>
        </div>
        <div
            class="gmf-app-tools-content container-fluid"
            ng-class="{'gmf-app-active': mainCtrl.toolsActive,'gmf-app-googlestreetview-active': mainCtrl.googleStreetViewActive }">
          <div ng-show="mainCtrl.loginActive" class="row">
            <div class="col-sm-12">
              <div class="gmf-app-tools-content-heading">
                {{'Login' | translate}}
                <a class="btn close" ng-click="mainCtrl.loginActive = false">&times;</a>
              </div>
              <gmf-authentication></gmf-authentication>
            </div>
          </div>
          <div ng-show="mainCtrl.printPanelActive" class="row">
            <div class="col-sm-12">
              <div class="gmf-app-tools-content-heading">
                {{'Print' | translate}}
                <a class="btn close" ng-click="mainCtrl.printPanelActive = false">&times;</a>
              </div>
              <gmf-print
                gmf-print-map="::mainCtrl.map"
                gmf-print-active="mainCtrl.printActive">
              </gmf-print>
            </div>
          </div>
          <div ng-show="mainCtrl.drawFeatureActive" class="row">
            <div class="col-sm-12">
              <div class="gmf-app-tools-content-heading">
                {{'Draw & Measure'|translate}}
                <a class="btn close" ng-click="mainCtrl.drawFeatureActive = false">&times;</a>
              </div>
              <gmf-drawfeature
                  gmf-drawfeature-active="mainCtrl.drawFeatureActive"
                  gmf-drawfeature-layer="::mainCtrl.drawFeatureLayer"
                  gmf-drawfeature-map="::mainCtrl.map">
              </gmf-drawfeature>
            </div>
          </div>
          <div ng-show="mainCtrl.filterSelectorActive" class="row">
            <div class="col-sm-12">
              <div class="gmf-app-tools-content-heading">
                {{'Filter'|translate}}
                <a class="btn close" ng-click="mainCtrl.filterSelectorActive = false">&times;</a>
              </div>
              <gmf-filterselector
                  active="mainCtrl.filterSelectorActive"
                  map="mainCtrl.map"
                  tool-group="mainCtrl.mapToolsGroup">
              </gmf-filterselector>
            </div>
          </div>
          <div ng-show="mainCtrl.editFeatureActive" class="row">
            <div class="col-sm-12">
              <div class="gmf-app-tools-content-heading">
                {{'Editing'|translate}}
                <a class="btn close" ng-click="mainCtrl.editFeatureActive = false">&times;</a>
              </div>
              <div ng-switch="mainCtrl.gmfUser.username">
                <div ng-switch-when="null">
                  {{'In order to use the editing tool, you must log in first.' | translate}}
                </div>
                <gmf-editfeatureselector
                    ng-switch-default
                    gmf-editfeatureselector-active="mainCtrl.editFeatureActive"
                    gmf-editfeatureselector-map="::mainCtrl.map"
                    gmf-editfeatureselector-vector="::mainCtrl.editFeatureVectorLayer">
                </gmf-editfeatureselector>
              </div>
            </div>
          </div>
          <div ng-show="mainCtrl.drawProfilePanelActive" class="row">
            <div class="col-sm-12">
              <div class="gmf-app-tools-content-heading">
                {{'Profile'|translate}}
                <a class="btn close" ng-click="mainCtrl.drawProfilePanelActive = false">&times;</a>
              </div>
              <div gmf-drawprofileline
                   gmf-drawprofileline-active="mainCtrl.drawProfilePanelActive"
                   gmf-drawprofileline-map="::mainCtrl.map"
                   gmf-drawprofileline-line="mainCtrl.profileLine">
                 <p>
                  <button class="btn btn-default"
                    ngeo-btn ng-model="ctrl.interaction.active"
                    translate> Draw profile line
                  </button>
                </p>
                <p>
                  <em translate ng-if="ctrl.interaction.active" class="text-muted small">
                    Draw a line on the map to display the corresponding elevation profile.
                    Use double-click to finish the drawing.
                  </em>
                </p>
              </div>
            </div>
          </div>
          <div ng-show="mainCtrl.googleStreetViewActive" class="row">
            <div class="col-sm-12">
              <div class="gmf-app-tools-content-heading">
                {{'Street View'|translate}}
                <a class="btn close" ng-click="mainCtrl.googleStreetViewActive = false">&times;</a>
              </div>
              <ngeo-googlestreetview
                  active="mainCtrl.googleStreetViewActive"
                  feature-style="mainCtrl.googleStreetViewStyle"
                  map="mainCtrl.map">
              </ngeo-googlestreetview>
            </div>
          </div>
          <div ng-show="mainCtrl.importDataSourceActive" class="row">
            <div class="col-sm-12">
              <div class="gmf-app-tools-content-heading">
                {{'Import Layer'|translate}}
                <a class="btn close" ng-click="mainCtrl.importDataSourceActive = false">&times;</a>
              </div>
              <gmf-importdatasource
                      map="mainCtrl.map">
              </gmf-importdatasource>
            </div>
          </div>
        </div>
      </div>
      <div class="gmf-app-map-container" ng-class="{'gmf-app-infobar-active': mainCtrl.showInfobar}">
        <gmf-search gmf-search-map="::mainCtrl.map"
          gmf-search-datasources="::mainCtrl.searchDatasources"
          gmf-search-coordinatesprojections="::mainCtrl.searchCoordinatesProjections">
        </gmf-search>
        <ngeo-displaywindow
          content="mainCtrl.displaywindowContent"
          desktop="true"
          height="mainCtrl.displaywindowHeight"
          open="mainCtrl.displaywindowOpen"
          title="mainCtrl.displaywindowTitle"
          url="mainCtrl.displaywindowUrl"
          width="mainCtrl.displaywindowWidth"
        ></ngeo-displaywindow>
        <div class="gmf-app-map-bottom-controls">
          <div class="gmf-backgroundlayerbutton btn-group dropup">
            <button
                class="btn btn-default dropdown-toggle"
                data-toggle="dropdown">
              <img src="/${instance}/wsgi/static-ngeo/BUSTING_VERSION/images/background-layer-button.png')}" />
            </button>
            <gmf-backgroundlayerselector
              gmf-backgroundlayerselector-map="::mainCtrl.map"
              class="dropdown-menu">
            </gmf-backgroundlayerselector>
          </div>
          <div class="gmf-app-map-messages">
            <gmf-disclaimer
              gmf-disclaimer-map="::mainCtrl.map">
            </gmf-disclaimer>
          </div>
          <gmf-displayquerywindow
            gmf-displayquerywindow-draggable-containment="::mainCtrl.displaywindowDraggableContainment"
            gmf-displayquerywindow-featuresstyle="::mainCtrl.queryFeatureStyle"
            gmf-displayquerywindow-desktop="true">
          </gmf-displayquerywindow>
        </div>
        <gmf-map
          class="gmf-map"
          gmf-map-map="mainCtrl.map"
          gmf-map-manage-resize="mainCtrl.manageResize"
          gmf-map-resize-transition="mainCtrl.resizeTransition"
          gmf-contextualdata=""
          gmf-contextualdata-map="::mainCtrl.map"
          gmf-contextualdata-projections="::[21781, 4326]"
          ngeo-map-query=""
          ngeo-map-query-map="::mainCtrl.map"
          ngeo-map-query-active="mainCtrl.queryActive"
          ngeo-map-query-autoclear="mainCtrl.queryAutoClear"
          ngeo-bbox-query=""
          ngeo-bbox-query-map="::mainCtrl.map"
          ngeo-bbox-query-active="mainCtrl.queryActive"
          ngeo-bbox-query-autoclear="mainCtrl.queryAutoClear">
        </gmf-map>

        <!--infobar-->
        <div class="gmf-app-footer" ng-class="{'gmf-app-active': mainCtrl.showInfobar}">
          <button class="btn fa gmf-app-map-info ng-cloak" ng-click="mainCtrl.showInfobar = !mainCtrl.showInfobar"
                  ng-class="{'fa-angle-double-up': !mainCtrl.showInfobar, 'fa-angle-double-down': mainCtrl.showInfobar}"></button>

          <div ngeo-scaleselector="mainCtrl.scaleSelectorValues"
               ngeo-scaleselector-map="mainCtrl.map"
               ngeo-scaleselector-options="mainCtrl.scaleSelectorOptions"></div>
          <div id="scaleline"></div>
          <div class="pull-right">
            <gmf-elevationwidget
                gmf-elevationwidget-map="::mainCtrl.map"
                gmf-elevationwidget-layers="::mainCtrl.elevationLayers"
                gmf-elevationwidget-active="mainCtrl.showInfobar">
            </gmf-elevationwidget>
            <gmf-mouseposition
                 gmf-mouseposition-map="mainCtrl.map"
                 gmf-mouseposition-projections="::mainCtrl.mousePositionProjections"
                 class="text-center">
            </gmf-mouseposition>
          </div>
        </div>
      </div>
      <ngeo-modal ng-model="mainCtrl.modalShareShown">
        <gmf-share gmf-share-email="true"></gmf-share>
      </ngeo-modal>
      <ngeo-modal
          ngeo-modal-closable="false"
          ng-model="mainCtrl.userMustChangeItsPassword()"
          ng-model-options="{getterSetter: true}">
        <div class="modal-header">
          <h4 class="modal-title">
            {{'You must change your password' | translate}}
          </h4>
        </div>
        <div class="modal-body">
          <gmf-authentication
            gmf-authentication-force-password-change="::true">
          </gmf-authentication>
        </div>
      </ngeo-modal>
    </main>
    <footer>
      <gmf-profile
        gmf-profile-active="profileChartActive"
        gmf-profile-line="mainCtrl.profileLine"
        gmf-profile-map="::mainCtrl.map"
        gmf-profile-linesconfiguration="::mainCtrl.profileLinesconfiguration"
        ngeo-resizemap="mainCtrl.map"
        ngeo-resizemap-state="profileChartActive">
      </gmf-profile>
    </footer>
    <script src="https://maps.googleapis.com/maps/api/js?v=3&key=AIzaSyCYnqxEQA5sz13sWSgMr97ejzvUeGP8gz4"></script>
    <script src="/${instance}/wsgi/dynamic.js?interface=desktop"></script>
  </body>
</html>