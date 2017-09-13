using System.Web;
using System.Web.Optimization;
using System.Web.Optimization.HashCache;
namespace PharmaACE.ForecastApp
{
    public class BundleConfig
    {
        // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkId=254725
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.UseCdn = true;
            BundleStyles(bundles);
            BundleScripts(bundles);
            BundleTable.EnableOptimizations = true;
        }
        private static void BundleScripts(BundleCollection bundles)
        {
          
            bundles.Add(new ScriptBundle("~/Scripts/jqueryLIB").Include(
                        "~/Scripts/lib/jquery/jquery.min.js"));
           
            bundles.Add(new ScriptBundle("~/Scripts/bootstrapLIB").Include(
                       "~/Scripts/lib/jquery/bootstrap.min.js"));

            bundles.Add(new ScriptBundle("~/Scripts/bootboxScript").Include(
                       "~/Scripts/lib/bootstrap/bootbox.js"));

            bundles.Add(new ScriptBundle("~/Scripts/jquerycookieLIB").Include(
                        "~/Scripts/lib/jquery/jquery.cookie.js"));

            bundles.Add(new ScriptBundle("~/Scripts/newsFeedLIB").Include("~/Scripts/lib/jquery/rssmikle.js"));

            bundles.Add(new ScriptBundle("~/Scripts/serviceLIB").Include(
                        "~/Scripts/custom/PharmaACE.ForecastApp.Service.js", "~/Scripts/custom/lib/jquery/jquery.dataTables.min.js"));

            bundles.Add(new ScriptBundle("~/Scripts/commonLIB").Include(
                        "~/Scripts/custom/main.js",
                        "~/Scripts/custom/wow.min.js"));

            bundles.Add(new ScriptBundle("~/Scripts/siteMasterLIB").Include(
                        "~/Scripts/lib/jquery/jquery.dataTables.min.js",
                        "~/Scripts/lib/bootstrap/dataTables.bootstrap.min.js"));

            bundles.Add(new ScriptBundle("~/Scripts/forecastLIB").Include(
                        "~/Scripts/custom/PharmaACE.ForecastApp.Constants.js",
                        "~/Scripts/custom/PharmaACE.ForecastApp.NewsFeed.js"));
            bundles.Add(new ScriptBundle("~/Scripts/leftMenuLIB").Include(
                        "~/Scripts/lib/jquery/jquery.metisMenu.js",
                        "~/Scripts/custom/custom.js",
                        "~/Scripts/custom/template.js"));

            //Started Js Bundling

            var HomeIndexScript = new ScriptBundle("~/Scripts/HomeIndexScript").Include(
                        "~/Scripts/lib/jquery/jquery.min.js",
                        "~/Scripts/lib/jquery/jquery.cookie.js",
                        "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js",
                        "~/Scripts/custom/PharmaACE.ForecastApp.Validator.js",
                        "~/Scripts/lib/bootstrap/bootbox.js",
                        "~/Scripts/lib/bootstrap/bootstrap.min.js",
                        "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                        "~/Scripts/custom/lib/jquery/jquery.dataTables.min.js",
                        "~/Scripts/lib/jquery/jquery.easy-overlay.js",
                        "~/Scripts/custom/PharmaACE.ForecastApp.HomeIndex.js",
                        "~/Scripts/custom/main.js",
                        "~/Scripts/custom/wow.min.js");
            HomeIndexScript.Transforms.Add(new HashCacheTransform());
            bundles.Add(HomeIndexScript);
            
            var UserWorkspaceIndexScript = new ScriptBundle("~/Scripts/UserWorkspaceIndexScript").Include(
                         "~/Scripts/custom/PharmaACE.ForecastApp.Notification.js",
                         "~/Scripts/lib/jquery/jquery.contextMenu.js",
                         "~/Scripts/lib/jquery/jquery.ui.position.min.js",
                         "~/Scripts/lib/jquery/jquery.dataTables.min.js",
                         "~/Scripts/lib/bootstrap/bootstrap-filestyle.min.js",
                         "~/Scripts/lib/jquery/jquery.flot.js",
                         "~/Scripts/lib/jquery/jquery.flot.pie.js",
                         "~/Scripts/lib/upload/jquery.knob.js",
                         "~/Scripts/lib/upload/jquery.ui.widget.js",
                         "~/Scripts/lib/upload/jquery.fileupload.js",
                         "~/Scripts/lib/upload/script.js",
                         "~/Scripts/lib/jquery/calendar_zebra_datepicker.js",
                         "~/Scripts/lib/bootstrap/bootstrap-select.min.js",
                         "~/Scripts/lib/jquery/jquery.easy-overlay.js",
                         "~/Scripts/custom/PharmaACE.ForecastApp.SharePopup.js",
                         "~/Scripts/lib/bootstrap/formValidation.min.js",
                         "~/Scripts/lib/jquery/icheck.min.js",
                         "~/Scripts/custom/PharmaACE.ForecastApp.UWIndex.js",
                          "~/Scripts/lib/bootstrap/bootstrap-toggle.min.js"

                      );
            UserWorkspaceIndexScript.Transforms.Add(new HashCacheTransform());
            bundles.Add(UserWorkspaceIndexScript);

             var HelpDeskScript = new ScriptBundle("~/Scripts/HelpDeskScript").Include(
                        "~/Scripts/lib/jquery/jquery.min.js",
                      "~/Scripts/lib/bootstrap/bootbox.js",
                        "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js",
                         "~/Scripts/lib/jquery/jquery.nicescroll.min.js",
                        "~/Scripts/custom/PharmaACE.ForecastApp.Validator.js",
                        "~/Scripts/custom/PharmaACE.ForecastApp.Constants.js",
                         "~/Scripts/custom/PharmaACE.ForecastApp.Service.js"
                      );
            HelpDeskScript.Transforms.Add(new HashCacheTransform());
            bundles.Add(HelpDeskScript);
            
             var AdminIndexScript = new ScriptBundle("~/Scripts/AdminIndexScript").Include(
                        "~/Scripts/lib/jquery/jquery.min.js",
                      "~/Scripts/lib/bootstrap/bootbox.js",
                        "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js",
                        "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                         "~/Scripts/lib/jquery/bootstrap.min.js",
                        "~/Scripts/lib/jquery/icheck.min.js",
                        "~/Scripts/lib/jquery/custom.js",
                        "~/Scripts/custom/bootbox.js",
                        "~/Scripts/lib/jquery/jquery.dataTables.js"
                      );
            AdminIndexScript.Transforms.Add(new HashCacheTransform());
            bundles.Add(AdminIndexScript);

              var SignUpAdminUserScript = new ScriptBundle("~/Scripts/SignUpAdminUserScript").Include(
                       "~/Scripts/lib/jquery/jquery.min.js",
                       "~/Scripts/lib/jquery/bootstrap.min.js",
                       "~/Scripts/lib/bootstrap/bootbox.js",
                       "~/Scripts/lib/jquery/custom.js",
                       "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                       "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js",
                       "~/Scripts/lib/jquery/jquery.nicescroll.min.js"
                      );
              SignUpAdminUserScript.Transforms.Add(new HashCacheTransform());
              bundles.Add(SignUpAdminUserScript);

              var SubscriberRegistrationScript = new ScriptBundle("~/Scripts/SubscriberRegistrationScript").Include(
                        "~/Scripts/lib/jquery/jquery.min.js",
                        "~/Scripts/lib/jquery/jquery.nicescroll.min.js",    
                         "~/Scripts/lib/jquery/bootstrap.min.js",
                         "~/Scripts/lib/bootstrap/bootbox.js",
                         "~/Scripts/lib/jquery/custom.js",
                         "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                          "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js",
                         "~/Scripts/lib/modernizr/moment-with-locales.js",
                         "~/Scripts/lib/bootstrap/bootstrap-datetimepicker.js"
                         );
              SubscriberRegistrationScript.Transforms.Add(new HashCacheTransform());
              bundles.Add(SubscriberRegistrationScript);


              var UserListScript = new ScriptBundle("~/Scripts/UserListScript").Include(
                 "~/Scripts/lib/bootstrap/bootbox.js",
                  "~/Scripts/lib/jquery/jquery.min.js",
                  "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                  "~/Scripts/lib/jquery/bootstrap.min.js",
                  "~/Scripts/lib/jquery/jquery.nicescroll.min.js",
                  "~/Scripts/lib/jquery/icheck.min.js",
                   "~/Scripts/lib/jquery/jquery.min.js",
                  "~/Scripts/lib/jquery/custom.js",
                  "~/Scripts/custom/bootbox.js",
                  "~/Scripts/lib/jquery/jquery.dataTables.js"
                  );
              UserListScript.Transforms.Add(new HashCacheTransform());
              bundles.Add(UserListScript);

              var ViewUserScript = new ScriptBundle("~/Scripts/ViewUserScript").Include(
                    "~/Scripts/lib/jquery/jquery.min.js",
                    "~/Scripts/lib/bootstrap/bootbox.js",  
                    "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                    "~/Scripts/lib/jquery/bootstrap.min.js",
                    "~/Scripts/lib/jquery/jquery.nicescroll.min.js",
                    "~/Scripts/lib/jquery/icheck.min.js",
                    "~/Scripts/lib/jquery/custom.js",
                    "~/Scripts/custom/bootbox.js",
                    "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js"
                 );
              ViewUserScript.Transforms.Add(new HashCacheTransform());
              bundles.Add(ViewUserScript);

              var ForecastAppServiceScript = new ScriptBundle("~/Scripts/ForecastAppServiceScript").Include(
                  "~/Scripts/custom/PharmaACE.ForecastApp.Service.js"
                );
              ForecastAppServiceScript.Transforms.Add(new HashCacheTransform());
              bundles.Add(ForecastAppServiceScript);

             var CFSiteMasterScript = new ScriptBundle("~/Scripts/CFSiteMasterScript").Include(
                     "~/Scripts/lib/jquery/jquery.min.js",
                    "~/Scripts/lib/jquery/bootstrap.min.js",
                    "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js",
                    "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                    "~/Scripts/lib/bootstrap/bootbox.js",
                    "~/Scripts/custom/summernote.js",
                     "~/Scripts/lib/jquery/jquery.nicescroll.min.js",
                     "~/Scripts/custom/PharmaACE.ForecastApp.Constants.js"
                 );
              CFSiteMasterScript.Transforms.Add(new HashCacheTransform());
              bundles.Add(CFSiteMasterScript);

              var CompanyProfileScript = new ScriptBundle("~/Scripts/CompanyProfileScript").Include(
              "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
              "~/Scripts/lib/jquery/jquery.dataTables.min.js",
              "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js",
              "~/Scripts/lib/bootstrap/bootbox.js" 
              );
              CompanyProfileScript.Transforms.Add(new HashCacheTransform());
              bundles.Add(CompanyProfileScript);

              var LiveFeedScript = new ScriptBundle("~/Scripts/LiveFeedScript").Include(
                   "~/Scripts/lib/jquery/jquery.min.js",
                    "~/Scripts/lib/jquery/bootstrap.min.js",

                     "~/Scripts/custom/bootbox.js",

                   "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                   "~/Scripts/custom/PharmaACE.ForecastApp.Constants.js",
                   "~/Scripts/custom/PharmaACE.ForecastApp.FeedEngine.js",    
                   "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js",
                   "~/Scripts/custom/PharmaACE.ForecastApp.NewsFeed.js", 
                   "~/Scripts/lib/bootstrap/formValidation.min.js", 
                   "~/Scripts/lib/bootstrap/bootstrap-tagsinput.min.js" ,
                   "~/Scripts/lib/jquery/jquery.nicescroll.min.js"
                  
                    );
              LiveFeedScript.Transforms.Add(new HashCacheTransform());
              bundles.Add(LiveFeedScript);

              var KMSiteMasterScript = new ScriptBundle("~/Scripts/KMSiteMasterScript").Include(
                    "~/Scripts/lib/jquery/jquery.min.js",
                    "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                    "~/Scripts/lib/jquery/bootstrap.min.js",
                    "~/Scripts/lib/jquery/jquery.dataTables.min.js",
                    "~/Scripts/lib/bootstrap/dataTables.bootstrap.min.js",
                    "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js",
                    "~/Scripts/lib/jquery/jquery.nicescroll.min.js",
                    "~/Scripts/lib/jquery/dataTables.colVis.js",
                    "~/Scripts/lib/jquery/jquery.PrintArea.js_4.js",
                    "~/Scripts/lib/jquery/base64.js",
                    "~/Scripts/lib/jquery/jquery.base64.js",
                    "~/Scripts/lib/jquery/jspdf.js",
                    "~/Scripts/lib/jquery/sprintf.js",
                    "~/Scripts/lib/jquery/tableExport.js",
                    "~/Scripts/lib/jquery/html2canvas.js",
                    "~/Scripts/lib/bootstrap/bootbox.js"
                  );
              KMSiteMasterScript.Transforms.Add(new HashCacheTransform());
              bundles.Add(KMSiteMasterScript);

            var DrugsIndexScript = new ScriptBundle("~/Scripts/DrugsIndexScript").Include(
                    "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                    "~/Scripts/lib/jquery/jquery.dataTables.min.js",
                    "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js",
                    "~/Scripts/lib/bootstrap/bootbox.js" 
                   );
              DrugsIndexScript.Transforms.Add(new HashCacheTransform());
              bundles.Add(DrugsIndexScript);


             var DrugsProductDetailsScript = new ScriptBundle("~/Scripts/DrugsProductDetailsScript").Include(
                "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                "~/Scripts/lib/jquery/jquery.nicescroll.min.js"
               );
              DrugsProductDetailsScript.Transforms.Add(new HashCacheTransform());
              bundles.Add(DrugsProductDetailsScript);

              var DrugsPatentDetailsScript = new ScriptBundle("~/Scripts/DrugsPatentDetailsScript").Include(
                 "~/Scripts/lib/bootstrap/jquery.dataTables.min.js",
                 "~/Scripts/lib/jquery/jquery.nicescroll.min.js"
                );
              DrugsPatentDetailsScript.Transforms.Add(new HashCacheTransform());
              bundles.Add(DrugsPatentDetailsScript);

              var DiseaseAreaIndexScript = new ScriptBundle("~/Scripts/DiseaseAreaIndexScript").Include(
                  "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                  "~/Scripts/lib/bootstrap/bootbox.js"
                  );
              DiseaseAreaIndexScript.Transforms.Add(new HashCacheTransform());
              bundles.Add(DiseaseAreaIndexScript);

              var KMDiseaseDetailScript = new ScriptBundle("~/Scripts/KMDiseaseDetailScript").Include(
                "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.Constants.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.FeedEngine.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.Constants.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.NewsFeed.js",
                "~/Scripts/lib/bootstrap/bootbox.js"
                  );
              KMDiseaseDetailScript.Transforms.Add(new HashCacheTransform());
              bundles.Add(KMDiseaseDetailScript);

            var forecastUtilitiesScript = new ScriptBundle("~/Scripts/forecastUtilitiesScript").Include(
              "~/Scripts/lib/jquery/jquery.min.js",
            // "~/Scripts/lib/modernizr/modernizr.custom.js",
           //   "~/Scripts/lib/modernizr/grid.js",
              "~/Scripts/lib/jquery/bootstrap.min.js",
              "~/Scripts/lib/jquery/jquery.nicescroll.min.js",
              "~/Scripts/lib/bootstrap/bootbox.js",
              "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
              "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js",
              "~/Scripts/custom/PharmaACE.ForecastApp.Notification.js",
              "~/Scripts/custom/PharmaACE.ForecastApp.Utilities.js"
                );
            forecastUtilitiesScript.Transforms.Add(new HashCacheTransform());
            bundles.Add(forecastUtilitiesScript);

            var forecastIndexScript = new ScriptBundle("~/Scripts/forecastIndexScript").Include(
                "~/Scripts/lib/jquery/jquery.min.js",
                "~/Scripts/lib/jquery/bootstrap.min.js",
                "~/Scripts/lib/jquery/jquery.nicescroll.min.js",
                "~/Scripts/lib/bootstrap/bootbox.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.Notification.js",                
                "~/Scripts/custom/main.js",
                "~/Scripts/custom/wow.min.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.ForecastIndex.js"
                  );
              forecastIndexScript.Transforms.Add(new HashCacheTransform());
              bundles.Add(forecastIndexScript);


              var forecastModelScript = new ScriptBundle("~/Scripts/forecastModelScript").Include(
                "~/Scripts/lib/jquery/jquery-1.12.4.min.js",                
                "~/Scripts/lib/bootstrap/bootstrap-multiselect.js",
                "~/Scripts/lib/jquery/bootstrap.min.js",
                "~/Scripts/custom/bootbox.js",
                "~/Scripts/lib/jquery/list.min.js",
                "~/Scripts/lib/jquery/icheck.min.js",
                "~/Scripts/lib/bootstrap/bootstrap-select.min.js",
                "~/Scripts/lib/jquery/jquery.nicescroll.min.js",
                "~/Scripts/lib/jquery/jquery.timers-1.2.js",                
                "~/Scripts/lib/jquery/jquery.easy-overlay.js",
                "~/Scripts/lib/jquery/jquery.nestable.js",                
                "~/Scripts/custom/PharmaACE.ForecastApp.FeedEngine.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.NewsFeed.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.SharePopup.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.Notification.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.Constants.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.ForecastModel.js"
                  ).Include(
                "~/Scripts/lib/jquery/jquery-ui-1.12.1.js");
              forecastModelScript.Transforms.Add(new HashCacheTransform());
              bundles.Add(forecastModelScript);

            var forecastReferenceScript = new ScriptBundle("~/Scripts/forecastReferenceScript").Include(
                "~/Scripts/lib/jquery/jquery-1.12.4.min.js",
                "~/Scripts/lib/jquery/bootstrap.min.js",                
                "~/Scripts/lib/jquery/jquery.nestable.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.FeedEngine.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",                
                "~/Scripts/custom/PharmaACE.ForecastApp.Notification.js",
                "~/Scripts/custom/PharmaACE.ForecastApp.Constants.js",                
                "~/Scripts/custom/PharmaACE.ForecastApp.ForecastReference.js"
                  ).Include(
                "~/Scripts/lib/jquery/jquery-ui-1.12.1.js");
            forecastReferenceScript.Transforms.Add(new HashCacheTransform());
            bundles.Add(forecastReferenceScript);

            var ReportingtIndexScript = new ScriptBundle("~/Scripts/ReportingtIndexScript").Include(
                    "~/Scripts/lib/jquery/jquery.min.js",
                    //"~/Scripts/lib/jquery/jquery-ui.js",
                    "~/Scripts/lib/bootstrap/bootstrap.min.js",
                    "~/Scripts/lib/bootstrap/bootbox.js" ,
                    "~/Scripts/lib/jquery/jquery.easy-overlay.js",
                    "~/Scripts/lib/jquery/moment.min.js",
                    "~/Scripts/lib/bootstrap/bootstrap-colorpicker.js",    
                    "~/Scripts/lib/jquery/jquery.nicescroll.min.js",
                    "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                    "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js"
                   );
              ReportingtIndexScript.Transforms.Add(new HashCacheTransform());
              bundles.Add(ReportingtIndexScript);

            var copIndexScript = new ScriptBundle("~/Scripts/COPIndexScript").Include(                    
                    "~/Scripts/lib/jquery/jquery.dataTables.min.js",
                    "~/Scripts/lib/bootstrap/bootstrap-select.min.js",
                    "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                    "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js",
                    "~/Scripts/custom/PharmaACE.ForecastApp.FeedEngine.js",
                    "~/Scripts/custom/PharmaACE.ForecastApp.NewsFeed.js",
                    "~/Scripts/custom/PharmaACE.ForecastApp.CoP.js"
                   );
            copIndexScript.Transforms.Add(new HashCacheTransform());
            bundles.Add(copIndexScript);
            var copAskQuestionScript = new ScriptBundle("~/Scripts/COPAskQuestionScript").Include(
                    "~/Scripts/custom/summernote.js",
                    "~/Scripts/custom/PharmaACE.ForecastApp.Service.js",
                    "~/Scripts/custom/PharmaACE.ForecastApp.Utility.js",
                    "~/Scripts/custom/PharmaACE.ForecastApp.CoP.js"
                   );
            copAskQuestionScript.Transforms.Add(new HashCacheTransform());
            bundles.Add(copAskQuestionScript);


            //Rendered on Search partial views for dropdown style
            var BootstrapselectScript = new ScriptBundle("~/Scripts/BootstrapselectScript").Include(
                                             "~/Scripts/lib/bootstrap/bootstrap-select.min.js" );
            BootstrapselectScript.Transforms.Add(new HashCacheTransform());
            bundles.Add(BootstrapselectScript);


            //Rendered on Community Practice
            var CPScript = new ScriptBundle("~/Scripts/CPScript").Include(
                                             "~/Scripts/custom/PharmaACE.ForecastApp.Constants.js",
                                            "~/Scripts/custom/PharmaACE.ForecastApp.FeedEngine.js",
                                             "~/Scripts/custom/PharmaACE.ForecastApp.NewsFeed.js"
                                             );
            CPScript.Transforms.Add(new HashCacheTransform());
            bundles.Add(CPScript);

        }
        private static void BundleStyles(BundleCollection bundles)
        {
             var siteCSSBundle= new StyleBundle("~/Content/siteCSS").Include("~/Content/CSS/Site.css");
               siteCSSBundle.Transforms.Add(new HashCacheTransform());
               bundles.Add(siteCSSBundle);

               var bootstrapCSSBundle = new StyleBundle("~/Content/bootstrapCSS").Include("~/Content/CSS/bootstrap.css");
               bootstrapCSSBundle.Transforms.Add(new HashCacheTransform());
               bundles.Add(bootstrapCSSBundle);
            
           var fontawesomeCSSBundle = new ScriptBundle("~/Content/fontawesomeCSS").Include("~/Content/CSS/font-awesome.css");
           fontawesomeCSSBundle.Transforms.Add(new HashCacheTransform());
           bundles.Add(fontawesomeCSSBundle);

           var bootstrapglyphiconsCSSBundle = new StyleBundle("~/Content/glyphiconCSS").Include("~/Content/CSS/bootstrap-glyphicons.css");
           bootstrapglyphiconsCSSBundle.Transforms.Add(new HashCacheTransform());
           bundles.Add(bootstrapglyphiconsCSSBundle);

            var bootstraptagsinputCSSBundle =new StyleBundle("~/Content/bootstrap-tagsinputCSS").Include("~/Content/CSS/bootstrap-tagsinput.css");   //Renderd on LiveFeed/Index
            bootstraptagsinputCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(bootstraptagsinputCSSBundle);
            
            var qastylesCSSBundle =new StyleBundle("~/Content/qa-stylesCSS").Include("~/Content/CSS/qa-styles.css", new CssRewriteUrlTransform());                       //Renderd on CommunityPractice/ViewAnswer
             qastylesCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(qastylesCSSBundle);
            
            var summernoteCSSBundle = new StyleBundle("~/Content/summernoteCSS").Include("~/Content/CSS/summernote.css");                       //Renderd on CommunityPractice/ViewAnswer
            summernoteCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(summernoteCSSBundle);
            
            var adminuserfontawesomeCSSBundle =new StyleBundle("~/Content/adminuserfont-awesomeCSS").Include("~/Content/CSS/adminuserfont-awesome.min.css");  //Renderd on Admin/Index
             adminuserfontawesomeCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(adminuserfontawesomeCSSBundle);
           

            var opensansCSSBundle =new StyleBundle("~/Content/opensansCSS").Include("~/Content/CSS/open-sans.css");
             opensansCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(opensansCSSBundle);

            var siteMasterCSSBundle =new StyleBundle("~/Content/siteMasterCSS").Include(                        
                        "~/Content/CSS/font-awesome.min.css",                        
                        "~/Content/CSS/animate.css",
                        "~/Content/CSS/main.css",
                        "~/Content/CSS/responsive.css",                        
                        "~/Content/CSS/custom.css");
             siteMasterCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(siteMasterCSSBundle);

            var CFSiteMasterCSSBundle =new StyleBundle("~/Content/CFSiteMasterCSS").Include(
                     "~/Content/CSS/font-awesome.min.css",
                     "~/Content/CSS/bootstrap.css",
                     "~/Content/CSS/bootstrap-glyphicons.css",
                      "~/Content/CSS/animate.css",
                        "~/Content/CSS/main.css",
                        "~/Content/CSS/responsive.css",
                        "~/Content/CSS/custom.css");
             CFSiteMasterCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(CFSiteMasterCSSBundle);


           var KMSiteMasterCSSBundle =new StyleBundle("~/Content/KMSiteMasterCSS").Include(
               "~/Content/CSS/core.css",
                 "~/Content/CSS/bootstrap-glyphicons.css",
                   "~/Content/CSS/jquery.dataTables.min.css",
                  "~/Content/CSS/bootstrap.css",
                   "~/Content/CSS/font-awesome.css",
                    "~/Content/CSS/animate.css",
                      "~/Content/CSS/main.css",
                      "~/Content/CSS/responsive.css",
                      "~/Content/CSS/custom.css");
             KMSiteMasterCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(KMSiteMasterCSSBundle);

            var KMDieseasindicationCSSBundle = new StyleBundle("~/Content/KMDieseasindicationCSS")
                .Include("~/Content/CSS/dieseasindication.css", new CssRewriteUrlTransform())
                .Include("~/Content/CSS/drug.css", new CssRewriteUrlTransform())
                .Include("~/Content/CSS/jquery.fancybox.css", new CssRewriteUrlTransform());
            KMDieseasindicationCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(KMDieseasindicationCSSBundle);

            var KMDieseasdetailCSSBundle = new StyleBundle("~/Content/KMDieseasdetailCSS").Include(
              "~/Content/CSS/dieseasdetail.css");
            KMDieseasdetailCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(KMDieseasindicationCSSBundle);
            var KMHomeLoggedCSSBundle = new StyleBundle("~/Content/KMHomeLoggedCSS").Include(
              "~/Content/CSS/kmloggedcss.css");
            KMHomeLoggedCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(KMHomeLoggedCSSBundle);


            var KMProductdetailCSSBundle = new StyleBundle("~/Content/KMProductdetailCSS").Include(
             "~/Content/CSS/productdetail.css");
            KMProductdetailCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(KMProductdetailCSSBundle);

            var KMDrugCSSBundle = new StyleBundle("~/Content/KMDrugCSS").Include(
             "~/Content/CSS/bootstrap-select.min.css",
             "~/Scripts/export/buttons.dataTables.css",
                "~/Content/CSS/drug.css");
            KMDrugCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(KMDrugCSSBundle);
            var CommunityCSSBundle = new StyleBundle("~/Content/CommunityCSS").Include(
                            "~/Content/CSS/dataTables.bootstrap.min.css",
                             "~/Content/CSS/bootstrap-select.min.css"
                             );
                              

            CommunityCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(CommunityCSSBundle);

            var AdminCSSBundle =new StyleBundle("~/Content/AdminCSS").Include(
                "~/Content/CSS/adminuserbootstrap.min.css",
                 "~/Content/CSS/adminuseranimate.min.css",
                  "~/Content/CSS/adminusercustom.css",
                  "~/Content/CSS/green.css"
                  
                   );
            AdminCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(AdminCSSBundle);




              var ReportingIndexCSSBundle =new StyleBundle("~/Content/ReportingIndexCSS").Include(
                        "~/Content/CSS/font-awesome.css",
                        "~/Content/CSS/custom.css",
                        "~/Content/CSS/bootstrap.min.css",
                        "~/bootstrap-glyphicons.css",
                        "~/Content/CSS/animate.css",
                        //"~/Content/CSS/pharmabi.min.css",
                        "~/Content/CSS/daterangepicker.css",
                         "~/Content/CSS/bootstrap-colorpicker.css"
                       );
            ReportingIndexCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(ReportingIndexCSSBundle);


            var homeIndexCSSBundle = new StyleBundle("~/Content/homeIndexCSS")
                        .Include("~/Content/ionicons/css/ionicons.css", new CssRewriteUrlTransform())
                        .Include("~/Content/foundation-icons/foundation-icons.css", new CssRewriteUrlTransform())
                        .Include("~/Content/octicons/octicons.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/animate.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/bootstrap.min.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/animate.min.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/custom.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/homepage.css", new CssRewriteUrlTransform());
            homeIndexCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(homeIndexCSSBundle);

            var forecastIndexCSSBundle = new StyleBundle("~/Content/forecastIndexCSS")
                        .Include("~/Content/CSS/bootstrap-glyphicons.css", new CssRewriteUrlTransform())
                        .Include("~/Content/ionicons/css/ionicons.css", new CssRewriteUrlTransform())
                        .Include("~/Content/foundation-icons/foundation-icons.css", new CssRewriteUrlTransform())
                        .Include("~/Content/octicons/octicons.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/bootstrap.min.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/animate.min.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/custom.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/font-awesome.css", new CssRewriteUrlTransform());
            forecastIndexCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(forecastIndexCSSBundle);

            var forecastModelCSSBundle = new StyleBundle("~/Content/forecastModelCSS").Include("~/Content/CSS/bootstrap-glyphicons.css")
                        .Include("~/Content/CSS/simple-sidebar-min.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/bootstrap-multiselect.css")
                        .Include("~/Content/CSS/bootstrap-select.min.css")
                        .Include("~/Content/CSS/animate.css")
                        .Include("~/Content/CSS/font-awesome.css")
                        .Include("~/Content/CSS/bootstrap.css")
                        .Include("~/Content/CSS/aero.css", new CssRewriteUrlTransform());
            forecastModelCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(forecastModelCSSBundle);

            var forecastReferenceCSSBundle = new StyleBundle("~/Content/forecastReferenceCSS")
                        .Include("~/Content/CSS/bootstrap-glyphicons.css")
                        .Include("~/Content/CSS/simple-sidebar-min.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/font-awesome.css")
                        .Include("~/Content/CSS/bootstrap.css");
            forecastReferenceCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(forecastReferenceCSSBundle);

            var userworkspaceIndexCSSBundle = new StyleBundle("~/Content/UserworkspaceIndexCSS")
                        .Include("~/Content/CSS/jquery.contextMenu.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/bootstrap.min.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/aero.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/calendarDefault.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/calendarStyle.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/userworkspace.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/bootstrap-select.min.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/dataTables.bootstrap.min.css", new CssRewriteUrlTransform())
                        .Include("~/Content/CSS/bootstrap-toggle.min.css", new CssRewriteUrlTransform());
            userworkspaceIndexCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(userworkspaceIndexCSSBundle);
            
            var helpDeskCSSbundle = new StyleBundle("~/Content/HelpDeskCSS")
                         .Include("~/Content/CSS/font-awesome.css", new CssRewriteUrlTransform())
                         .Include("~/Content/CSS/bootstrap.css", new CssRewriteUrlTransform())
                         .Include("~/Content/CSS/simple-sidebar-min.css", new CssRewriteUrlTransform())
                         .Include("~/Content/CSS/animate.min.css", new CssRewriteUrlTransform())
                         .Include("~/Content/CSS/helpdesk.css", new CssRewriteUrlTransform());                      
            helpDeskCSSbundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(helpDeskCSSbundle);

            var liveFeedCSSbundle = new StyleBundle("~/Content/LiveFeedCSS")                       
                         .Include("~/Content/CSS/bootstrap-tagsinput.css", new CssRewriteUrlTransform())
                         .Include("~/Content/CSS/livefeed.css", new CssRewriteUrlTransform());
            liveFeedCSSbundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(liveFeedCSSbundle);

            var globalPaceCSSbundle = new StyleBundle("~/Content/GlobalPaceCSS")                        
                         .Include("~/Content/CSS/globalpace.css", new CssRewriteUrlTransform());
            globalPaceCSSbundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(globalPaceCSSbundle);


            
            var BootstrapselectCSSBundle = new StyleBundle("~/Content/BootstrapselectCSS").Include(
                      "~/Content/CSS/bootstrap-select.min.css"
                    );
            BootstrapselectCSSBundle.Transforms.Add(new HashCacheTransform());
            bundles.Add(BootstrapselectCSSBundle);

        }
    }
}